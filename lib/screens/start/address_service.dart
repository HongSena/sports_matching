import 'package:dio/dio.dart';
import 'package:sports_matching/constants/keys.dart';
import 'package:sports_matching/utils/logger.dart';
class AddressService{
  void searchAddresBystr(String text) async {

    final formData = {
      'key:': VWORLD_KEY,
      'request': 'search',
      'type': 'ADDRESS',
      'category': "ROAD",
      'query': text,
      'size': 30,
    };
    logger.d(formData);
    final response = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e){
      logger.e(e.message);
    });
    logger.d(response);
  }
}