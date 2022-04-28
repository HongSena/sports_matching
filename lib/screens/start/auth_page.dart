import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import '../../constants/common_size.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);
  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey)
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        TextEditingController _textEditingController = TextEditingController(text: "010");
        return Scaffold(
          appBar: AppBar(
            title: Text('전화번호 로그인', style: Theme.of(context).appBarTheme.titleTextStyle,),
            elevation: 2,
          ),
          body: Padding(
            padding: const EdgeInsets.all(common_padding),
            child: Column(
              children: [
                Row(
                  children: [
                    ExtendedImage.asset('assets/imgs/tomato.png', width: size.width*0.2, height: size.width*0.2),
                    SizedBox(width: common_small_padding),
                    Text('동글동글 멋진몸매에 빨간 옷을입고 \n새콤달콤 향기풍기는~ 멋쟁이 토마토')
                  ],
                ),
                SizedBox(height: common_padding),
                TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    MaskedInputFormatter("000 0000 0000")
                  ],
                  decoration: InputDecoration(
                    focusedBorder: inputBorder, border: inputBorder
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
