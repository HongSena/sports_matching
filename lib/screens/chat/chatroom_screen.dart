import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sports_matching/data/address_model_addressFromLocation.dart';

class ChatroomScreen extends StatefulWidget {
  final String chatroomKey;

  const ChatroomScreen({Key? key, required this.chatroomKey}) : super(key: key);

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            MaterialBanner(
                padding: EdgeInsets.zero,
                leadingPadding: EdgeInsets.zero,
                actions: [Container()],
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 8, bottom: 4),
                        child: ExtendedImage.asset(
                          'assets/imgs/tomato.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      contentPadding: EdgeInsets.only(left: 4, right: 0),
                      title: RichText(
                          text: TextSpan(
                              text: '거래완료',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900),
                              children: [
                            TextSpan(
                              text: '이케아 소르테라 분리수거함 5개',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200),
                            )
                          ])),
                      subtitle: RichText(
                          text: TextSpan(
                              text: '3만원',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w900),
                              children: [
                            TextSpan(
                              text: '가격제안 불가',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w200),
                            )
                          ])),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 12),
                      child: SizedBox(
                        height: 32,
                        child: TextButton.icon(onPressed: () {},
                            icon: Icon(Icons.edit, size: 16, color: Colors.black,),
                            label: Text('후기 남기기', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w200),),
                            style: TextButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: Colors.grey[300]!, width: 1)),)),
                      ),
                    ),
                    SizedBox(height: 12,)
                  ],
                )),
            Expanded(
                child: Container(
              color: Colors.yellowAccent,
            )),
            _buildInputBar()
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar() {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.red,
              )),
          Expanded(
              child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              suffixIcon: GestureDetector(
                  onTap: () {
                    print('icon clicked!');
                  },
                  child: Icon(
                    Icons.emoji_emotions_outlined,
                    color: Colors.red,
                  )),
              suffixIconConstraints: BoxConstraints.tight(Size(40, 40)),
              contentPadding: EdgeInsets.all(10),
              hintText: '메시지를 입력하시렵니까?',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
