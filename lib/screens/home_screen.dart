
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/states/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: [Container(color: Colors.accents[0]),Container(color: Colors.accents[3]),Container(color: Colors.accents[6]),Container(color: Colors.accents[9])],
      ),
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
        type: BottomNavigationBarType.fixed,
        currentIndex: _bottomSelectedIndex,
        items: [
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(_bottomSelectedIndex==0?'assets/imgs/selected_home_1.png':'assets/imgs/home_1.png')), label: '홈'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(_bottomSelectedIndex==1?'assets/imgs/selected_placeholder.png':'assets/imgs/placeholder.png')), label: '지도'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(_bottomSelectedIndex==2?'assets/imgs/selected_smartphone_10.png':'assets/imgs/smartphone_10.png')), label: '채팅'),
          BottomNavigationBarItem(icon: ImageIcon(AssetImage(_bottomSelectedIndex==3?'assets/imgs/selected_user_3.png':'assets/imgs/user_3.png')), label: '내 정보'),
        ],
        onTap: (index){
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
      ),
    );
  }
}
