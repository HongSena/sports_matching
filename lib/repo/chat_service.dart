import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sports_matching/data/chatroom_model.dart';
import '../constants/data_keys.dart';
import '../data/chat_model.dart';

class ChatService{
  static final ChatService _itemService = ChatService._internal();
  factory ChatService() => _itemService;
  ChatService._internal();

  String? get userKey => null;

  var snapshotToChatroom = StreamTransformer<DocumentSnapshot<Map<String, dynamic>>, ChatroomModel>
      .fromHandlers(handleData: (snapshot, sink){
    ChatroomModel chatroom = ChatroomModel.fromSnapshot(snapshot);
    sink.add(chatroom);
  });


  Future createNewChatroom(ChatroomModel chatroomModel)async{
    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(
        ChatroomModel.generateChatRoomKey(
            chatroomModel.buyerKey, chatroomModel.itemKey));
    final DocumentSnapshot documentSnapshot = await documentReference.get();

    if (!documentSnapshot.exists) {
      await documentReference.set(chatroomModel.toJson());
    }
  }

  Future createNewChat(String chatroomKey, ChatModel chatModel)async{
    DocumentReference<Map<String, dynamic>> documentReference =
    FirebaseFirestore.instance
        .collection(COL_CHATROOMS)
        .doc('${chatroomKey}_${chatModel.userKey}')
        .collection(COL_CHATS)
        .doc();

    DocumentReference<Map<String, dynamic>> chatroomDocRef =
    FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(chatroomKey);

    await documentReference.set(chatModel.toJson());

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference, chatModel.toJson());
      transaction.update(chatroomDocRef, {
        DOC_LASTMSG: chatModel.msg,
        DOC_LASTMSGTIME: chatModel.createdDate,
        DOC_LASTMSGUSERKEY: chatModel.userKey
      });
    });
  }
  Stream<ChatroomModel> connectChatroom(String chatroomKey) {
    return FirebaseFirestore.instance
        .collection(COL_CHATROOMS)
        .doc(chatroomKey)
        .snapshots()
        .transform(snapshotToChatroom);
  }

  Future<List<ChatModel>> getChatList(String chatroomKey) async{
    QuerySnapshot<Map<String, dynamic>> snapshot = 
    await FirebaseFirestore.instance.collection(COL_CHATROOMS)
        .doc(chatroomKey).collection(COL_CHATS).orderBy(DOC_CREATEDDATE, descending: true).limit(10).get();
    List<ChatModel> chatlist = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromSnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }
  /////////
  Future<List<ChatModel>> getLatestChats(String chatroomKey, DocumentReference currentLatestChatRef) async{
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(chatroomKey)
        .collection(COL_CHATS).endAtDocument(await currentLatestChatRef.get()).orderBy(DOC_CREATEDDATE, descending: true).get();
    List<ChatModel> chatlist = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromSnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }

  Future<List<ChatModel>> getOlderChats(String chatroomKey, DocumentReference oldestChatRef) async{
    QuerySnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection(COL_CHATROOMS).doc(chatroomKey)
        .collection(COL_CHATS).startAfterDocument(await oldestChatRef.get()).orderBy(DOC_CREATEDDATE, descending: true).limit(10).get();
    List<ChatModel> chatlist = [];
    snapshot.docs.forEach((docSnapshot) {
      ChatModel chatModel = ChatModel.fromSnapshot(docSnapshot);
      chatlist.add(chatModel);
    });
    return chatlist;
  }

}
