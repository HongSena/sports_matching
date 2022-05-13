import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:sports_matching/constants/common_size.dart';

import 'multi_image_select.dart';
class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var _divider =  Divider(height: 1, thickness: 1, color: Colors.grey, indent: common_padding, endIndent: common_padding);
  bool _levelLimitSelected = false;
  var _border = UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  TextEditingController _levelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(onPressed:(){
            context.beamBack();
          },
            child: Text('뒤로', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
          ),
          title: Text('파티생성 페이지'),
          actions: [
            TextButton(onPressed:(){
              context.beamBack();
            },
              child: Text('완료', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
            ),
          ],
        ),
        body: ListView(
          children: [
            MultiImageSelect(),
            _divider,
            TextFormField(decoration: InputDecoration(hintText: '글 제목', contentPadding: EdgeInsets.symmetric(horizontal: common_padding),focusedBorder:_border,enabledBorder: _border)),
            _divider,
            ListTile(dense:true, title: Text('종목 선택'), trailing: Icon(Icons.navigate_next),),
            _divider,
            Row(children: [
              Expanded(child: Padding(
                padding: const EdgeInsets.only(left: common_padding),
                child: TextFormField(keyboardType: TextInputType.number, controller: _levelController, decoration: InputDecoration(hintText: '요구 헬창력을 설정하세요', icon: Icon(Icons.sports_tennis_sharp, color: (_levelController.text.isEmpty)?Colors.grey:Colors.black87),focusedBorder: _border, enabledBorder: _border),),
              )),
              TextButton.icon(onPressed: (){setState(() {
                _levelLimitSelected = !_levelLimitSelected;
              });}, icon: Icon(_levelLimitSelected?Icons.check_circle:Icons.check_circle_outline, color: _levelLimitSelected?Theme.of(context).primaryColor:Colors.black54),label: Text('설정하기', style: TextStyle(color: _levelLimitSelected?Theme.of(context).primaryColor:Colors.black54),), style: TextButton.styleFrom(backgroundColor: Colors.transparent, primary: Colors.grey))],),
            _divider,
            TextFormField(maxLines: null,keyboardType: TextInputType.multiline,decoration: InputDecoration(hintText: '게시글 내용', contentPadding: EdgeInsets.symmetric(horizontal: common_padding),focusedBorder: _border,enabledBorder: _border)),

          ],
        )
    );
  }
}

