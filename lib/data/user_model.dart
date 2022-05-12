import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class UserModel{
  late String userKey;
  late String email;
  late String address;
  late String userRank;
  late double userMannerScore;
  late num lat;
  late num log;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  DocumentReference? reference;
  UserModel({
    required this.userKey,
    required this.email,
    required this.address,
    required this.userRank,
    required this.userMannerScore,
    required this.lat,
    required this.log,
    required this.geoFirePoint,
    required this.createdDate,
    required this.reference,});

  UserModel.fromJson(Map<String, dynamic> json, this.userKey, this.reference) {
    email = json['email'];
    address = json['address'];
    userRank = json['userRank'];
    userMannerScore = json['userMannerScore'];
    lat = json['lat'];
    log = json['log'];
    geoFirePoint = GeoFirePoint((json['geoFirePoint']['geopoint']).latitude, (json['geoFirePoint']['geopoint']).longitude);
    createdDate = json['createdDate']== null ? DateTime.now().toUtc(): (json['createdDate'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['address'] = address;
    map['userRank'] = userRank;
    map['userMannerScore'] = userMannerScore;
    map['lat'] = lat;
    map['log'] = log;
    map['geoFirePoint'] = geoFirePoint.data;
    map['createdDate'] = createdDate;
    return map;
  }
}