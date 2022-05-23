import 'package:cloud_firestore/cloud_firestore.dart';

/// chatKey : ""
/// msg : ""
/// createDate : ""
/// userKey : ""
/// reference : ""

class ChatModel {
  late String chatKey;
  late String msg;
  late String createDate;
  late String userKey;
  DocumentReference? reference;
  ChatModel({
      required this.chatKey,
      required this.msg,
      required this.createDate,
      required this.userKey,
      this.reference,});

  ChatModel.fromJson(Map<String, dynamic> json, this.chatKey, this.reference) {
    chatKey = json['chatKey'];
    msg = json['msg'];
    createDate = json['createDate'];
    userKey = json['userKey'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['chatKey'] = chatKey;
    map['msg'] = msg;
    map['createDate'] = createDate;
    map['userKey'] = userKey;
    map['reference'] = reference;
    return map;
  }
  ChatModel.fromQuerySnapShot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data(), snapshot.id, snapshot.reference);
  ChatModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);


}