import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../constants/common_size.dart';

class EvalutionScreen extends StatefulWidget {
  EvalutionScreen({Key? key}) : super(key: key);

  @override
  State<EvalutionScreen> createState() => _EvalutionScreenState();
}

class _EvalutionScreenState extends State<EvalutionScreen> {
  Widget _textGap = SizedBox(height: common_padding);
  List<Widget> radioList = [];
  int selectIndex = 0;
  int selectIndex2 = 0;
  List<IconData> icondata = [Icons.thumb_down, Icons.thumb_up];
  Widget customRadio(IconData icon, int index){
    return OutlineButton(
        onPressed: (){
          chageIndex(index);
        },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(color:Colors.white),
      child: Icon(icon, color:selectIndex == index ? Colors.red : Colors.grey)
    );
  }
  Widget customRadio2(IconData icon, int index){
    return OutlineButton(
        onPressed: (){
          chageIndex2(index);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        borderSide: BorderSide(color:Colors.white),
        child: Icon(icon, color:selectIndex2 == index ? Colors.red : Colors.grey)
    );
  }

  void chageIndex(int index){
    setState((){
      selectIndex = index;
    });
  }
  void chageIndex2(int index){
    setState((){
      selectIndex2 = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text('평가하기'),),
      body: Stack(
        children: [
          Scaffold(
            bottomNavigationBar: SafeArea(
              top: false,
              bottom: true,
              child: Container(
                height: _size.height*0.08,
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
                  ExtendedImage.asset('assets/imgs/ronnie.png', height: _size.width*0.6, width:_size.width),
                  _textGap,
                  Text('로니 콜먼님은 어땠나요?', style: TextStyle(fontSize: 25),),
                  SizedBox(height: 40),
                  Text('스포츠맨십이 좋았어요'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customRadio(icondata[0],0),
                      customRadio(icondata[1],1),
                    ],
                  ),
                  _textGap,
                  Text('운동을 잘해요'),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customRadio2(icondata[0],0),
                      customRadio2(icondata[1],1),
                    ],
                  ),
                  _textGap,
                ],
              )),
        ],
      ),
    );
  }
}


