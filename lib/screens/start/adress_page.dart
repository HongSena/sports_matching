import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_matching/screens/start/address_service.dart';
import 'package:sports_matching/utils/logger.dart';

class AdressPage extends StatelessWidget {
  AdressPage({Key? key}) : super(key: key);

  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(left: 16, right: 16), //전방향 패딩
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
        TextFormField(
          controller: _addressController,
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey,),
          hintText: '도로명주소를 입력해주세요',
          hintStyle: TextStyle(color: Colors.grey[350]),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey))
          ),
        ),
        TextButton.icon(onPressed: (){
          final text = _addressController.text;
          if(text.isNotEmpty){
            AddressService().searchAddresBystr(text);
          }
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
            logger.d('index: $index');
            return ListTile(
              title: Text('adress : $index'),
              subtitle: Text('subtitle : $index'),
            );
          }, itemCount: 30,),
        )
      ],),
    );
  }
}
