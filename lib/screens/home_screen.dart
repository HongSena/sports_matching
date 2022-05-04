
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/states/user_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('잠원동'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.nosign)),
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.text_justify))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '홈'),
                BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '피드'),
        ],
      ),
    );
  }
}
