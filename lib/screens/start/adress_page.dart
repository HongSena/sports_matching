import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sports_matching/data/AddressModle.dart';
import 'package:sports_matching/screens/start/address_service.dart';
import 'package:sports_matching/utils/logger.dart';

class AdressPage extends StatefulWidget {
  AdressPage({Key? key}) : super(key: key);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  TextEditingController _addressController = TextEditingController();

  AddressModle? _addressModel;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(left: 16, right: 16), //전방향 패딩
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        TextFormField(
          controller: _addressController,
          onFieldSubmitted: (text) async {
            _addressModel = await AddressService().searchAddresBystr(text);
            setState(() {

            });
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey,),
          hintText: '도로명주소를 입력해주세요',
          hintStyle: TextStyle(color: Colors.grey[350]),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey))
          ),
        ),
        TextButton.icon(onPressed: () async {

          Location location = new Location();

          bool _serviceEnabled;
          PermissionStatus _permissionGranted;
          LocationData _locationData;

          _serviceEnabled = await location.serviceEnabled();
          if (!_serviceEnabled) {
            _serviceEnabled = await location.requestService();
            if (!_serviceEnabled) {
              return;
            }
          }

          _permissionGranted = await location.hasPermission();
          if (_permissionGranted == PermissionStatus.denied) {
            _permissionGranted = await location.requestPermission();
            if (_permissionGranted != PermissionStatus.granted) {
              return;
            }
          }
          _locationData = await location.getLocation();
          logger.d(_locationData);
        },
            icon:Icon(
              CupertinoIcons.compass,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
          '현재 위치 찾기',

        ),
            style: TextButton.styleFrom(minimumSize: Size(10, 48)),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index){
              if (_addressModel==null || _addressModel!.result==null || _addressModel!.result!.items == null || _addressModel!.result!.items![index].address == null){
                return Container();
              }
            return ListTile(
              title: Text(_addressModel!.result!.items![index].address!.road!),
              subtitle: Text(_addressModel!.result!.items![index].address!.parcel!),
            );
          },
            itemCount: (_addressModel==null || _addressModel!.result==null || _addressModel!.result!.items == null )? 0: _addressModel!.result!.items!.length,),
        )
      ],),
    );
  }
}
