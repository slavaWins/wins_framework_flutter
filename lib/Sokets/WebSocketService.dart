import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:signalr_core_new/signalr_core_new.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../routes_config.dart';
import '../Auth/Services/AuthState.dart';
import '../Shared/Services/CryptoHelper.dart';
import 'EventerWebSocketService.dart';

class WebSocketService with ChangeNotifier {
  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() => _instance;

  bool _isConnecting = false;

  WebSocketService._internal() {
    print("[WS] connect by contrstuctor");
    connect();
  }

  final eventerWebSocketService = EventerWebSocketService();

  final authState = AuthState();

  WebSocketChannel? _channel;

  // Обработка входящих сообщений

  Future<String?> _Decrypt(String data) async {
    return await CryptoHelper.decrypt(
      data,
      AuthState.sessionDevice!.cryptToken!,
    );
  }

  void _handleMessage(dynamic message) async {
    if (kDebugMode) {
      // print('WebSocket message: $message');
    }

    String? _raw = message[0];

    if (!_raw!.startsWith("{")) {
      _raw = await _Decrypt(_raw);
    }

    if (_raw == null) {
      print("[WS] error dectypt or null mesg");
      return;
    }

    dynamic inner = json.decode(_raw);

    String eventType = inner["eventType"];
    print('[WebSocket message] ' + eventType);

    var dataRaw = inner["data"];

    try {
      eventerWebSocketService.onData(eventType, dataRaw);
    } catch (e) {
      print("Error socket on maping");
    }
  }

  @override
  void dispose() {
    print("DISPPosed");
    super.dispose();
  }

  Future<void> connect() async {
    if (_isConnecting) {
      print("[WS] _isConnecting blocked parallels");
      return;
    }

    _isConnecting = true;

    print("[WS] connect");

    await Future.delayed(const Duration(seconds: 1));

    var _jwtToken = (await authState.getJwtToken()) ?? "";
    _disconnect(); // Закрываем предыдущее подключение если было

    if (_jwtToken.length == 0) {
      print("Нет JWT что бы ws смог подключится, реконект заводим!!");
      print(_jwtToken);
      _reconnect();
      return;
    }

    var urlFull =
        RoutesConfig.domainApi +
            "/signal-service/signal?access_token=" +
            _jwtToken;

    try {
      final connection = HubConnectionBuilder()
          .withUrl(
        urlFull,
        HttpConnectionOptions(
          //logging: (level, message) => print(message),
        ),
      )
          .build();

      await connection.start();

      connection.on('SocketChannel', _handleMessage);

      connection.onclose((v) {
        print("[WS] OnClose conection connection.onclose");
        isReconecteing = false;
        _reconnect();
      });

      /*
      connection.on('ReceiveMessage', (message) {
        print(message.toString());
      });

      connection.on('Example', (message) {
        print(message.toString());
      });
*/
      //  await connection.invoke('SendMessage', args: ['Bob', 'Says hi!']);
    } on ClientException catch (e) {
      if (kDebugMode) {}

      _isConnecting = false;
      isReconecteing = false;
      print('WebSocket connection error: $e');
      _reconnect();
    } catch (e) {
      if (kDebugMode) {}

      _isConnecting = false;
      isReconecteing = false;
      print('WebSocket connection error: $e');
      _reconnect();
    } finally {
      _isConnecting = false;
    }
  }

  // Обработка ошибок
  void _handleError(dynamic error) {
    if (kDebugMode) {}
    print('WebSocket error: $error');
    _reconnect();
  }

  bool isReconecteing = false;

  Future<void> _reconnect() async {
    if (isReconecteing) return;
    isReconecteing = true;

    print('[WS] Forced reconnect called');

    await Future.delayed(const Duration(seconds: 5));

    await connect();

    isReconecteing = false;
  }

  // Закрытие соединения
  void _disconnect() {
    try {
      _channel?.sink.close();
    } catch (e) {
      print('[WS] Error closing channel: $e');
    }

    _channel = null;
  }

  // Отправка сообщения на сервер
  void send(dynamic data) {
    if (_channel != null) {
      _channel!.sink.add(data);
    }
  }
}
