import 'package:flutter/material.dart';
import 'package:sports_matching/states/firebase_auth_state.dart';
import 'package:sports_matching/states/user_provider.dart';
import '../screens/home_screen.dart';
import '../utils/logger.dart';
import 'package:provider/provider.dart';
class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController _emailContriller = TextEditingController();
  TextEditingController _pwContriller = TextEditingController();
  TextEditingController _cpwContriller = TextEditingController();
  //VerificationStatus

  @override
  void dispose() {
    _emailContriller.dispose();
    _pwContriller.dispose();
    _cpwContriller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              SizedBox(height: 16.0,),
              Image.asset('assets/imgs/tomato.png'),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _emailContriller,
                decoration: textInputDecor('Email'),
                validator: (text){
                  if(text!.isNotEmpty && text.contains("@")){
                    return null;
                  }else{
                    return '정확한 메세지를 전달해 주세요';
                  }
                },
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _pwContriller,
                decoration: textInputDecor('Password'),
                obscuringCharacter: '*',
                obscureText: true,
                validator: (text){
                  if(text!.isNotEmpty && text.length > 5){
                    return null;
                  }else{
                    return '정확한 비밀번호를 입력해 주세요';
                  }
                },
              ),
              SizedBox(height: 10.0,),
              TextFormField(
                cursorColor: Colors.black54,
                controller: _cpwContriller,
                decoration: textInputDecor('Confirm Password'),
                obscuringCharacter: '*',
                obscureText: true,
                validator: (text){
                  if(text!.isNotEmpty && _pwContriller.text == _cpwContriller.text){
                    return null;
                  }else{
                    return '입력한 값이 비밀번호와 일치하지 않습니다.';
                  }
                },
              ),
              FlatButton(
                color: Colors.red,
                onPressed: () {
                  if(_formkey.currentState!.validate()){
                    logger.d('Validation success');
                    Provider.of<FirebaseAuthState>(context, listen: false).registerUser(context, _emailContriller.text, _pwContriller.text);
                  }
                },
                child: Text('join', style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              )

            ],
          ),
        ),
      ),
    );
  }
}
InputDecoration textInputDecor(String hint) {
  return InputDecoration(
      hintText: hint,
      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(12.0)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(12.0)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(12.0)),
      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(12.0)),
      filled: true,
      fillColor: Colors.grey[100]);
}
void attemptVerify(BuildContext context)async{
  context.read<UserProvider>().setUserAuth(true);
}
