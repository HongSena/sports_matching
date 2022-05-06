import 'package:beamer/beamer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/router/locations.dart';
import 'package:sports_matching/screens/start_screen.dart';
import 'package:sports_matching/screens/splash_screen.dart';
import 'package:sports_matching/states/user_provider.dart';
import 'package:sports_matching/utils/logger.dart';

final _routerDelegate = BeamerDelegate(
    guards: [BeamGuard(pathBlueprints: ['/'], check:(context, location){
      return context.watch<UserProvider>().userState;  //이 값이 true이면 homepage로 false면 authpage로
    },
        showPage: BeamPage(child: StartScreen())//fasle일 경우
    )],
    locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()])
);


void main() {
  logger.d('my first log');
  Provider.debugCheckInvalidValueType = null;
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
      future: _initialization,
      builder: (context, snapshot) {
        return AnimatedSwitcher(duration: Duration(milliseconds: 500), child: _splashLoadingWidget(snapshot));// 화면전환 애니매이션 500밀리초 뒤에 화면이 전환된다.
      }
    );
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object> snapshot) {
    if(snapshot.hasError){
      print('error occur while loading.');
      return Text('Error occur');
    }else if(snapshot.connectionState == ConnectionState.done){
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
    return ChangeNotifierProvider<UserProvider>(
      create: (BuildContext context) {
          return UserProvider();
        },
      child: MaterialApp.router( //위젯의 top
        theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'DH', //글씨체
            hintColor: Colors.grey[350],
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              subtitle1: TextStyle(color: Colors.black87, fontSize: 15),
              subtitle2: TextStyle(color: Colors.grey, fontSize: 13)
            ),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    primary: Colors.white,
                    minimumSize: Size(48, 48))),
            // appBarTheme: AppBarTheme(
            //     backgroundColor: Colors.white,
            //     elevation: 2,
            //     titleTextStyle: TextStyle(color: Colors.black, fontSize: 20.0),
            //     actionsIconTheme: IconThemeData(color: Colors.black87))
                bottomNavigationBarTheme: BottomNavigationBarThemeData(
                  selectedItemColor: Colors.red, unselectedItemColor: Colors.black54
                )),
        routeInformationParser: BeamerParser(), //비머에게 전달
        routerDelegate: _routerDelegate,
      ),
    );
  }
}
