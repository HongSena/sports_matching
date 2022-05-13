import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: TextButton(onPressed:(){
            context.beamBack();
          },
            child: Text('뒤로', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
          ),
          title: Text('파티생성 페이지'),
          actions: [
            TextButton(onPressed:(){
              context.beamBack();
            },
              child: Text('완료', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
            ),
          ],
        ),
        body: Container(color: Colors.green)
    );
  }
}
