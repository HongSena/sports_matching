//임시 화면 file
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Config extends StatelessWidget {
  SizedBox _sizedbox = SizedBox(height: 5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: ListView
                  (
                  children: [
                    TextButton.icon(onPressed: () {
                      print('press');
                    },

                      icon: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.announcement, color: Colors.black,)),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5.0
                        ),
                        child: Text("공지사항", style: TextStyle(color: Colors.black),),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 12)
                      ),
                    ),
                    Divider(color: Colors.black26, height: 0, indent: 15, endIndent: 20, thickness: 1,)
                    ,
                    TextButton.icon(onPressed: () {
                      print('press');
                    },icon: Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Icon(Icons.announcement, color: Colors.black,)),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5.0
                        ),
                        child: Text("공지사항", style: TextStyle(color: Colors.black),),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 12)
                      ),
                    )
                    ,
                    Divider
                      (
                      color: Colors.blue, height: 0
                      ,
                      thickness: 0.5
                      ,
                    )
                    ,
                    TextButton.icon(onPressed: () {
                      print('press');
                    },
                      icon: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.announcement, color: Colors.black,)),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5.0
                        ),
                        child: Text("공지사항", style: TextStyle(color: Colors.black),),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 12)
                      ),
                    )
                    ,
                    Divider
                      (
                      color: Colors.blue,
                      height: 0
                      ,
                      indent: 15
                      ,
                      endIndent: 20
                      ,
                      thickness: 0.5
                      ,
                    )
                    ,
                    TextButton.icon(onPressed: () {
                      print('press');
                    },
                      icon: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.announcement, color: Colors.black,)),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5.0
                        ),
                        child: Text("공지사항", style: TextStyle(color: Colors.black),),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 12)
                      ),
                    )
                    ,
                    Divider
                      (
                      color: Colors.blue,
                      height: 0
                      ,
                      indent: 15
                      ,
                      endIndent: 20
                      ,
                      thickness: 0.5
                      ,
                    )
                    ,
                    TextButton.icon(onPressed: () {
                      print('press');
                    },
                      icon: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.announcement, color: Colors.black,)),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5.0
                        ),
                        child: Text("공지사항", style: TextStyle(color: Colors.black),),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 12)
                      ),
                    )
                    ,
                    Divider
                      (
                      color: Colors.blue,
                      height: 0
                      ,
                      indent: 15
                      ,
                      endIndent: 20
                      ,
                      thickness: 0.5
                      ,
                    )
                    ,
                    TextButton.icon(onPressed: () {
                      print('press');
                    },
                      icon: Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: Icon(Icons.announcement, color: Colors.black,)),
                      label: Padding(
                        padding: EdgeInsets.only(left: 5.0
                        ),
                        child: Text("공지사항", style: TextStyle(color: Colors.black),),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white10,
                          alignment: Alignment.centerLeft, padding: EdgeInsets.symmetric(vertical: 12)
                      ),
                    )
                    ,
                    Divider
                      (
                      color: Colors.blue,
                      height: 0
                      ,
                      indent: 15
                      ,
                      endIndent: 20
                      ,
                      thickness: 0.5
                      ,
                    )
                    ,
                  ]
                  ,
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}



