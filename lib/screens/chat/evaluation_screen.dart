import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/repo/chat_service.dart';
import 'package:sports_matching/repo/item_service.dart';
import 'package:sports_matching/states/chat_notifier.dart';
import '../../constants/common_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../utils/logger.dart';

class EvalutionScreen extends StatefulWidget {
  EvalutionScreen({Key? key}) : super(key: key);

  @override
  State<EvalutionScreen> createState() => _EvalutionScreenState();
}

class _EvalutionScreenState extends State<EvalutionScreen> {
  Widget _textGap = SizedBox(height: common_padding);
  final _valueList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedValue = '1';
  final _valueList2 = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  var _selectedValue2 = '1';




  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('평가하기'),
      ),
      body: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: SafeArea(
              top: false,
              bottom: true,
              child: Container(
                height: _size.height * 0.08,
                decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey[300]!))),
                child: Padding(
                  padding: const EdgeInsets.all(common_small_padding),
                  child: Row(
                    children: [
                      SizedBox(
                        width: common_small_padding,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('로니 콜먼님의 현재 헬창력 : 10',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200)),
                          Text('로니 콜먼님의 현재 매너 점수 : 8.9',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200))
                        ],
                      ),
                      Expanded(child: Container()),
                      TextButton(
                          onPressed: () {
                            context.beamToNamed('/');
                          },
                          child: Text('평가하기'))
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
              child: Column(
            children: [
              ExtendedImage.asset('assets/imgs/ronnie.png',
                  height: _size.width * 0.6, width: _size.width),
              _textGap,
              Text(
                '로니 콜먼님은 어땠나요?',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 40),
              Text('스포츠맨십이 좋았어요'),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: DropdownButton(
                      value: _selectedValue,
                      items: _valueList.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedValue = value!;
                        });
                      },
                    ))
                  ]),
              _textGap,
              Text('운동을 잘해요'),
              SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: DropdownButton(
                      value: _selectedValue2,
                      items: _valueList2.map((value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedValue2 = value!;
                        });
                      },
                    ))
                  ]),
              _textGap,
            ],
          )),
        ],
      ),
    );
  }
}
