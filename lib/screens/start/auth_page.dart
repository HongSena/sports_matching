
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
  int selectedForms = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(children: forms, index: selectedForms),
            Container(
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      if(selectedForms == 0){
                        selectedForms = 1;
                      }else{
                        selectedForms = 0;
                      }
                    });
                  },
                  child: Text('go to sign up')),
            ),
          ],
        ),
      ),
    );
  }
}
