// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth_login/helper/join_or_login.dart';
// import 'package:firebase_auth_login/helper/login_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class AuthPage extends StatelessWidget{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;//핸드폰 사이즈 가져옴 context는 폰에대한 정보 가지고 있음
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            size: size,
            // painter: LoginBackground(isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage(),
              Stack(
                children: <Widget>[
                  _inputFrom(size),
                  _authButton(size),
                ],),
              Container(height:  size.height*0.01,),
              //Consumer<JoinOrLogin>(
              Consumer(
                builder: (context, joinOrLogin, child) => GestureDetector(
                    onTap: (){
                      //joinOrLogin.toggle();
                    },
                    child: Text("Don't have an Account? Create One",//joinOrLogin.isJoin ? "로그인하셈 ㅋㅋ" :"Don't have an Account? Create One",
                      style : TextStyle(color:Colors.blue), )),
              ),
              Container(height:  size.height*0.05,)
            ],
          ),
        ],
      ),
    );
  }
  // void _register(BuildContext context) async{
  //   final UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
  //   final User? user = result.user;
  //   if(user == null){
  //     final snackBar = SnackBar(content: Text("Please try again later."),);
  //     Scaffold.of(context).showSnackBar(snackBar);
  //   }
  // }
  // void _login(BuildContext context) async{
  //   final UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
  //   final User? user = result.user;
  //   if(user == null){
  //     final snackBar = SnackBar(content: Text("Please try again later."),);
  //     Scaffold.of(context).showSnackBar(snackBar);
  //   }
  // }
  Widget _logoImage(){
    return Expanded(

      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 24, right: 24),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/sports.gif"),
          ),
        ),
      ),
    );
  }
  Widget _inputFrom(Size size){
    return Padding(
      padding: EdgeInsets.all(size.width*0.1),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(icon: Icon(Icons.account_circle),
                    labelText: "Email",),
                  validator: <String>(value){
                    if(value.isEmpty){
                      return "Please input correct Email.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(icon: Icon(Icons.vpn_key),
                    labelText: "Password",),
                  validator: <String>(value){
                    if(value.isEmpty){
                      return "Please input correct Password.";
                    }
                    return null;
                  },
                ),
                Container(height: 8,),
                // Consumer<JoinOrLogin>(
                //   builder: (context, value, child) => Opacity(
                //       opacity: value.isJoin?0:1,//투명도설정
                //       child: Text("Forgot Password")),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _authButton(Size size){
    return Positioned(
      left: size.width*0.15,
      right: size.width*0.15,
      bottom: 15,
      child: SizedBox(
        height: 40,
        //child: Consumer<JoinOrLogin>(
        child: Consumer(
          builder: (context, joinOrLogin, child) => RaisedButton(
            child: Text(
              //joinOrLogin.isJoin ? "Join" :"Login" ,
              "Login",
              style:  TextStyle(fontSize: 20, color: Colors.white),
            ),
            color: Colors.red,//joinOrLogin.isJoin ? Colors.blue : Colors.red,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: (){
              // if(_formKey.currentState!.validate()){
              //   joinOrLogin.isJoin ? _register(context) : _login(context);
              //
              // }
            },),
        ),
      ),
    );
  }
}


