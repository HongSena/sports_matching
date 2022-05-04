import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_matching/data/AddressModle.dart';
import 'package:sports_matching/data/address_model_addressFromLocation.dart';
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
  List<address_model_addressFromLocation> _addressModel2List = [];
  bool _isGettingLocation = false;


  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

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
            _addressModel2List.clear();
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
          _addressModel = null;
          _addressModel2List.clear();
          setState(() {
            _isGettingLocation = true;
          });
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
          List<address_model_addressFromLocation> addresses = await AddressService().findAddressByCordinate(log: _locationData.longitude!, lat: _locationData.latitude!);
          _addressModel2List.addAll(addresses);
          setState(() {
            _isGettingLocation = false;
          });
        },
            icon:_isGettingLocation?SizedBox(width: 24, height: 24,child: CircularProgressIndicator(color: Colors.white, )):Icon(
              CupertinoIcons.compass,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              _isGettingLocation?'위치 찾는 중...':'현재 위치 찾기',

        ),
            style: TextButton.styleFrom(minimumSize: Size(10, 48)),
        ),
        if(_addressModel != null) //text검색을 위한 listview
          Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index){
              if (_addressModel==null || _addressModel!.result==null || _addressModel!.result!.items == null || _addressModel!.result!.items![index].address == null){
                return Container();
              }
            return ListTile(
              onTap: () async {
                _saveAddressAndGoToNextPage(_addressModel!.result!.items![index].address!.road ?? "");

              },
              title: Text(_addressModel!.result!.items![index].address!.road ?? ""),
              subtitle: Text(_addressModel!.result!.items![index].address!.parcel ?? ""),
            );
          },
            itemCount: (_addressModel==null || _addressModel!.result==null || _addressModel!.result!.items == null )? 0: _addressModel!.result!.items!.length),
        ),
        if(_addressModel2List.isNotEmpty)// Location 검색을 위한 list view
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index){
                if (_addressModel2List[index].result == null ||
                    _addressModel2List[index].result!.isEmpty){
                  return Container();
                }
                return ListTile(
                    onTap: () async {
                      _saveAddressAndGoToNextPage(_addressModel2List[index].result![0].text ?? "");
                    },
                  title: Text(_addressModel2List[index].result![0].text ?? ""),
                  subtitle: Text(_addressModel2List[index].result![0].zipcode ?? ""),
                );
              },
              itemCount: _addressModel2List.length,
            ),
          ),
      ],),
    );

  }
  _saveAddressAndGoToNextPage(String address)async{
    await _saveAddressOnSharedPreference(address);
    context.read<PageController>().animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.ease);
  }
  _saveAddressOnSharedPreference(String address) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('address', address);
  }
}
