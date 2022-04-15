import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_matching/utils/logger.dart';

class AdressPage extends StatelessWidget {
  const AdressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.all(16), //전방향 패딩 16
      child: Column(children: [
        TextFormField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.grey,),
          hintText: '도로명주소를 입력해주세요',
          hintStyle: TextStyle(color: Colors.grey[350]),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey))
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton.icon(onPressed: (){
              logger.d('adressPage button clicked!');
            },
                icon:Icon(
                  CupertinoIcons.compass,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
              '현재 위치 찾기',
              style: TextStyle(color: Colors.white),
            ),
                style: TextButton.styleFrom(backgroundColor: Colors.red,)),
          ],
        ),
        Expanded(
          child: ListView.builder(itemBuilder: (context, index){
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
