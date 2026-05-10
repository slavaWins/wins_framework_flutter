import 'package:flutter/foundation.dart';

abstract class IEventerWebSocketService {
  void onData(String eventType, dynamic dataRaw);
}

class EventerWebSocketDefaultService
    with ChangeNotifier
    implements IEventerWebSocketService {



  static final EventerWebSocketDefaultService _instance = EventerWebSocketDefaultService._internal();
  factory EventerWebSocketDefaultService() => _instance;

  EventerWebSocketDefaultService._internal() {
    print("[WS] EventerWebSocketDefaultService");
  }

  void onData(String eventType, dynamic dataRaw) {


    print("Not Implements IEventerWebSocketService!");
  }
}
