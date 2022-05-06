
import 'package:flutter/material.dart';
import 'package:sports_matching/widgets/sign_in_form.dart';
import '../../widgets/sign_up_form.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}
class _AuthPageState extends State<AuthPage>{
  List<Widget> forms = [SignUpForm(), SignInForm()];
  int selectedForms = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(children: forms, index: selectedForms),
            Positioned(
              left: 0, right: 0, bottom: 0, height: 40,
              child: Container(
                color: Colors.white,
                child: FlatButton(
                  shape: Border(top: BorderSide(width: 0.8, color: Colors.grey)),
                    onPressed: () {
                      setState(() {
                        if(selectedForms == 0){
                          selectedForms = 1;
                        }else{
                          selectedForms = 0;
                        }
                      });
                    },
                    child: RichText(text: TextSpan(text: (selectedForms == 0)?'계정이 있나요? ':'계정이 없나요? ',style: TextStyle(color: Colors.grey), children: [TextSpan(text:(selectedForms == 0)? ' 로그인하기':' 회원가입하기', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold))]),),
              ),
            ),
          )],
        ),
      ),
    );
  }
}
