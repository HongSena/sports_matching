import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class UserModel{
  late String userKey;
  late String email;
  late String address;
  late String userRank;
  late double userMannerScore;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  DocumentReference? reference;
  UserModel({
    required this.userKey,
    required this.email,
    required this.address,
    required this.userRank,
    required this.userMannerScore,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference,});

  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference) {
    email = json['email'];
    address = json['address'];
    userRank = json['userRank'];
    userMannerScore = json['userMannerScore'];
    geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude, (json['geoFirePoint']['geopoint']).longitude);
    createdDate = json['createdDate']== null ? DateTime.now().toUtc(): (json['createdDate'] as Timestamp).toDate();
  }
  UserModel.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> snapshot) : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['address'] = address;
    map['userRank'] = userRank;
    map['userMannerScore'] = userMannerScore;
    map['geoFirePoint'] = geoFirePoint.data;
    map['createdDate'] = createdDate;
    return map;
  }
}