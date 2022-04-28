import 'package:dio/dio.dart';
import 'package:sports_matching/constants/keys.dart';
import 'package:sports_matching/data/AddressModle.dart';
import 'package:sports_matching/utils/logger.dart';
class AddressService{
  Future<AddressModle> searchAddresBystr(String text) async {
    final response = await Dio()
        .get('http://api.vworld.kr/req/search?request=search&size=30&query=${text}&type=address&category=road&key=${VWORLD_KEY}')
        .catchError((e){
      logger.e(e.message);
    });
    logger.d(response);
    AddressModle addressModle = AddressModle.fromJson(response.data["response"]);
    logger.d(addressModle);
    return addressModle;

  }
}

