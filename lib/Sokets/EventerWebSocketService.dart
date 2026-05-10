import 'package:flutter/foundation.dart';

class EventerWebSocketService with ChangeNotifier {




  ValueChanged<dynamic>? onNotifyBell = null;
  ValueChanged<dynamic>? onNotifyBell2 = null;
  ValueChanged<dynamic>? onNotifChatMessage = null;
  ValueChanged<dynamic>? onNotifChatMessageDialog = null;
  ValueChanged<dynamic>? onNotifChatMessageChat = null;
  ValueChanged<dynamic>? onNotifChatDeleteMessage = null;
  ValueChanged<dynamic>? onNotifChatTypingStatus = null;
  ValueChanged<dynamic>? onNotifChatTypingStatus2 = null;
  ValueChanged<dynamic>? onNotifChatReadingTo = null;
  ValueChanged<dynamic>? onNotifChatReadingTo2 = null;
  ValueChanged<dynamic>? onNotifSetOnline = null;
  ValueChanged<dynamic>? onNotifSetOnline2 = null;

  
  void onData(String eventType, dynamic dataRaw){


    if (eventType == "notify_bell") {
      if (onNotifyBell != null) {
        onNotifyBell!(dataRaw);
      }
      if (onNotifyBell2 != null) {
        onNotifyBell2!(dataRaw);
      }
    }

    if (eventType == "chat_delete_messages") {
      if (onNotifChatDeleteMessage != null) {
        onNotifChatDeleteMessage!(dataRaw);
      }
    }

    if (eventType == "chat_reading_to") {
      if (onNotifChatReadingTo != null) {
        onNotifChatReadingTo!(dataRaw);
      }
      if (onNotifChatReadingTo2 != null) {
        onNotifChatReadingTo2!(dataRaw);
      }
    }

    if (eventType == "on_set_user_online") {
      if (onNotifSetOnline != null) {
        onNotifSetOnline!(dataRaw);
      }
      if (onNotifSetOnline2 != null) {
        onNotifSetOnline2!(dataRaw);
      }
    }

    if (eventType == "chat_typing_status") {
      if (onNotifChatTypingStatus != null) {
        onNotifChatTypingStatus!(dataRaw);
      }
      if (onNotifChatTypingStatus2 != null) {
        onNotifChatTypingStatus2!(dataRaw);
      }
    }

    if (eventType == "chat_message") {
      if (onNotifChatMessage != null) {
        onNotifChatMessage!(dataRaw);
      }
      if (onNotifChatMessageDialog != null) {
        onNotifChatMessageDialog!(dataRaw);
      }
      if (onNotifChatMessageChat != null) {
        onNotifChatMessageChat!(dataRaw);
      }
    }
  }


}