import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sports_matching/states/user_provider.dart';
import '../../constants/common_size.dart';
import '../../utils/logger.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController _phoneNumberController = TextEditingController(text: "010");

  TextEditingController _codeNumberController = TextEditingController(text: "");

  final inputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey)
  );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  VerificationStatus _verificationStatus = VerificationStatus.none;

  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        return IgnorePointer(
          ignoring: _verificationStatus == VerificationStatus.verifying,
          child: Form(
            key: _formKey,
            child: Scaffold(

              appBar: AppBar(
                title: Text('전화번호 로그인', style: Theme.of(context).appBarTheme.titleTextStyle,),
                elevation: 2,
              ),

              body: Padding(
                padding: const EdgeInsets.all(common_padding),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        MaskedInputFormatter("000 0000 0000")
                      ],
                      decoration: InputDecoration(focusedBorder: inputBorder, border: inputBorder),
                      validator: (phoneNumber){
                        if(phoneNumber?.length==13 && phoneNumber != null){
                          return null;
                        }else{
                          return '전화번호를 확인하세요';
                        }
                      }
                    ),

                    SizedBox(height: common_padding),

                    TextButton(onPressed: (){
                      if(_formKey.currentState != null){
                        bool passed = _formKey.currentState!.validate();
                        print(passed);
                        if(passed){
                          setState(() {
                            _verificationStatus = VerificationStatus.codeSent;
                          });
                        }
                      }
                      logger.d('auth_page 인증문자 받기 button clicked!');


                    },
                      child: Text(
                        '인증문자 발송',
                      ),
                    ),

                    SizedBox(height: common_small_padding,),

                    AnimatedOpacity(
                      opacity: (_verificationStatus == VerificationStatus.none) ? 0 : 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: getVerifivationHeight(_verificationStatus),
                        child: TextFormField(
                          controller: _codeNumberController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            MaskedInputFormatter("000000")
                          ],
                          decoration: InputDecoration(
                              focusedBorder: inputBorder, border: inputBorder
                          ),
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: getVerifivationBtnHeight(_verificationStatus),
                      child: TextButton(onPressed: (){
                        logger.d('auth_page 인증하기 button clicked!');
                        attemptVerify();
                      },
                        child: (_verificationStatus == VerificationStatus.verifying) ? CircularProgressIndicator(color: Colors.white,):Text(
                          '인증하기',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  double getVerifivationHeight(VerificationStatus status){
    switch(status){
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verifivationdone:
        return 60 + common_small_padding;
    }
  }

  double getVerifivationBtnHeight(VerificationStatus status){
    switch(status){
      case VerificationStatus.none:
        return 0;
      case VerificationStatus.codeSent:
      case VerificationStatus.verifying:
      case VerificationStatus.verifivationdone:
        return 48 + common_small_padding;
    }
  }
//인증 버튼 눌렀을 때
  void attemptVerify() async {
    setState(() {
      _verificationStatus = VerificationStatus.verifying;
    });

    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _verificationStatus = VerificationStatus.verifivationdone;
    });
    
    context.read<UserProvider>().setUserAuth(true);

  }

  _getAdress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String address = prefs.getString('address')??"";
    logger.d("address from shared pref = $address");
  }
}




enum VerificationStatus{
  none, codeSent, verifying, verifivationdone
}