import 'package:flutter/foundation.dart';
import 'package:sports_matching/data/chat_model.dart';
import 'package:sports_matching/data/chatroom_model.dart';
import 'package:sports_matching/repo/chat_service.dart';

import '../utils/logger.dart';
class ChatNotifier extends ChangeNotifier {
  ChatroomModel? _chatroomModel;
  List<ChatModel> _chatList = [];
  String chatroomKey;

  ChatNotifier(this.chatroomKey) {
    ChatService().connectChatroom('${chatroomKey.substring(1)}').listen((chatroomModel) {
      this._chatroomModel = chatroomModel;
      if (this._chatList.isEmpty) {
        ChatService().getChatList(chatroomKey.substring(1)).then((chatList) {
          _chatList.addAll(chatList);
          notifyListeners();
        });
      } else {
        if (this._chatList[0].reference == null) this._chatList.removeAt(0);
        ChatService()
            .getLatestChats(chatroomKey.substring(1), this._chatList[0].reference!)
            .then((latestChats) {
          this._chatList.insertAll(0, latestChats);
          notifyListeners();
        });
      }
    });
  }

  void addNewChat(ChatModel chatModel) {
    _chatList.insert(0, chatModel);
    notifyListeners();

    ChatService().createNewChat(chatroomKey.substring(1), chatModel);
  }

  List<ChatModel> get chatList => _chatList;

  ChatroomModel? get chatroomModel => _chatroomModel;

  String get ChatroomKey => chatroomKey.substring(1);
}