import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:sports_matching/router/locations.dart';
import 'package:sports_matching/screens/auth_screen.dart';
import 'package:sports_matching/screens/splash_screen.dart';
import 'package:sports_matching/utils/logger.dart';

final _routerDelegate = BeamerDelegate(
    guards: [BeamGuard(pathBlueprints: ['/'], check:(context, location){
      return false;//이 값이 true이면 homepage로 false면 authpage로
    },
        showPage: BeamPage(child: AuthScreen())//fasle일 경우
    )],
    locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()])
);


void main() {
  logger.d('my first log');
  runApp(MyApp());
}


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: Future.delayed(Duration(seconds: 3), ()=>100),
      builder: (context, snapshot) {
        return AnimatedSwitcher(duration: Duration(milliseconds: 500), child: _splashLoadingWidget(snapshot));// 화면전환 애니매이션 500밀리초 뒤에 화면이 전환된다.
      }
    );
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object> snapshot) {
    if(snapshot.hasError){
      print('error');
      return Text('error');
    }else if(snapshot.hasData){
      return sportsApp();
    }else{
      return SplashScreen();
    }
  }
}


class sportsApp extends StatelessWidget {
  const sportsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router( //위젯의 top
      theme: ThemeData(
          primarySwatch: Colors.red,
          fontFamily: 'DH' //글씨체
      ),
      routeInformationParser: BeamerParser(), //비머에게 전달
      routerDelegate: _routerDelegate,
    );
  }
}
