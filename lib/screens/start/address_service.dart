
import 'package:dio/dio.dart';
import 'package:sports_matching/constants/keys.dart';
import 'package:sports_matching/data/AddressModle.dart';
import 'package:sports_matching/data/address_model_addressFromLocation.dart';
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

  Future<List<address_model_addressFromLocation>> findAddressByCordinate({required double log, required double lat}) async {

    final List<double> formDatas = <double>[log, lat, log-0.01, lat, log+0.01, lat, log, lat-0.01, log, lat-0.01];
    List<address_model_addressFromLocation> addresses = [];
    for(int i = 0; i<formDatas.length; i+=2){
      final response = await Dio()
          .get('http://api.vworld.kr/req/address?service=address&request=GetAddress&type=PARCEL&point=${formDatas[i]},${formDatas[i+1]}&key=${VWORLD_KEY}')
          .catchError((e){
        logger.e(e.message);
      });
      address_model_addressFromLocation addressModel2 = address_model_addressFromLocation.fromJson(response.data["response"]);
      if(response.data['response']['status'] == 'OK'){
        addresses.add(addressModel2);
      }

    }
    logger.d(addresses);
    return addresses;
  }
}

