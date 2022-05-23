import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_matching/data/address_model_addressFromLocation.dart';
import 'package:sports_matching/data/chat_model.dart';
import 'package:sports_matching/repo/chat_service.dart';
import 'package:sports_matching/states/user_notifier.dart';

import '../../data/chatroom_model.dart';
import '../../data/user_model.dart';
import '../../states/chat_notifier.dart';
import 'chat.dart';

// class ChatroomScreen extends StatefulWidget {
//   final String chatroomKey;
//
//   const ChatroomScreen({Key? key, required this.chatroomKey}) : super(key: key);
//
//   @override
//   State<ChatroomScreen> createState() => _ChatroomScreenState();
// }
//
// class _ChatroomScreenState extends State<ChatroomScreen> {
//   TextEditingController _textEditingController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         UserModel userModel = context.read<UserNotifier>().userModel!;
//         Size _size = MediaQuery.of(context).size;
//         return Scaffold(
//           appBar: AppBar(),
//           backgroundColor: Colors.grey[200],
//           body: SafeArea(
//             child: Column(
//               children: [
//                 MaterialBanner(
//                     padding: EdgeInsets.zero,
//                     leadingPadding: EdgeInsets.zero,
//                     actions: [Container()],
//                     content: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ListTile(
//                           dense: true,
//                           leading: Padding(
//                             padding: const EdgeInsets.only(left: 12.0, top: 8, bottom: 4),
//                             child: ExtendedImage.asset(
//                               'assets/imgs/tomato.png',
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                           contentPadding: EdgeInsets.only(left: 4, right: 0),
//                           title: RichText(
//                               text: TextSpan(
//                                   text: '거래완료',
//                                   style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w900),
//                                   children: [
//                                     TextSpan(
//                                       text: '이케아 소르테라 분리수거함 5개',
//                                       style: TextStyle(
//                                           color: Colors.black87,
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w200),
//                                     )
//                                   ])),
//                           subtitle: RichText(
//                               text: TextSpan(
//                                   text: '3만원',
//                                   style: TextStyle(
//                                       color: Colors.black87,
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.w900),
//                                   children: [
//                                     TextSpan(
//                                       text: '가격제안 불가',
//                                       style: TextStyle(
//                                           color: Colors.black87,
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.w200),
//                                     )
//                                   ])),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(left: 16, bottom: 12),
//                           child: SizedBox(
//                             height: 32,
//                             child: TextButton.icon(onPressed: () {},
//                                 icon: Icon(Icons.edit, size: 16, color: Colors.black,),
//                                 label: Text('후기 남기기', style: TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w200),),
//                                 style: TextButton.styleFrom(backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color: Colors.grey[300]!, width: 1)),)),
//                           ),
//                         ),
//                         SizedBox(height: 12,)
//                       ],
//                     )),
//                 Expanded(
//                     child: Container(
//                       color: Colors.white,
//                       child: ListView.separated(
//                           padding: EdgeInsets.all(16),
//                           itemBuilder: (context, index) {
//                             bool isMine = (index%2==0);
//                             return Chat(size: _size, isMine: isMine);
//                           },
//                           separatorBuilder: (context, index) {
//                             return SizedBox(height: 12);
//                           },
//                           itemCount: 30),
//                     )),
//                 _buildInputBar(userModel)
//               ],
//             ),
//           ),
//         );
//       }
//     );
//   }
//
//   Widget _buildInputBar(UserModel userModel) {
//     return SizedBox(
//       height: 48,
//       child: Row(
//         children: [
//           IconButton(
//               onPressed: () {},
//               icon: Icon(
//                 Icons.add,
//                 color: Colors.red,
//               )),
//           Expanded(
//               child: TextFormField(
//                 controller: _textEditingController,
//             decoration: InputDecoration(
//               isDense: true,
//               fillColor: Colors.white,
//               filled: true,
//               suffixIcon: GestureDetector(
//                   onTap: () {
//                     print('icon clicked!');
//                   },
//                   child: Icon(
//                     Icons.emoji_emotions_outlined,
//                     color: Colors.red,
//                   )),
//               suffixIconConstraints: BoxConstraints.tight(Size(40, 40)),
//               contentPadding: EdgeInsets.all(10),
//               hintText: '메시지를 입력하시렵니까?',
//               border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                   borderSide: BorderSide(color: Colors.grey)),
//             ),
//           )),
//           IconButton(
//               onPressed: () async {
//                 ChatModel chatModel = ChatModel(msg: _textEditingController.text, createdDate: DateTime.now(), userKey: userModel.userKey);
//                 String editChatroomkey = widget.chatroomKey.substring(1);
//                 await ChatService().createNewChat(editChatroomkey, chatModel);
//                 _textEditingController.clear();
//               },
//               icon: Icon(
//                 Icons.send,
//                 color: Colors.red,
//               ))
//         ],
//       ),
//     );
//   }
// }


class ChatroomScreen extends StatefulWidget {
  final String chatroomKey;
  const ChatroomScreen({Key? key, required this.chatroomKey}) : super(key: key);

  @override
  _ChatroomScreenState createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController _textEditingController = TextEditingController();
  late ChatNotifier _chatNotifier;

  // @override
  // void initState() {
  //   _chatNotifier = ChatNotifier('${widget.chatroomKey}_${widget.userKey}');
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    UserModel userModel = context.read<UserNotifier>().userModel!;
    _chatNotifier = ChatNotifier('${widget.chatroomKey}_${userModel.userKey}');
    return ChangeNotifierProvider<ChatNotifier>.value(
      value: _chatNotifier,
      child: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          Size _size = MediaQuery.of(context).size;
          UserModel userModel = context.read<UserNotifier>().userModel!;
          return Scaffold(
            appBar: AppBar(),
            backgroundColor: Colors.grey[200],
            body: SafeArea(
              child: Column(
                children: [
                  _buildItemInfo(context),
                  Expanded(
                      child: Container(
                        color: Colors.white,
                        child: ListView.separated(
                            reverse: true,
                            padding: EdgeInsets.all(16),
                            itemBuilder: (context, index) {
                              bool isMine = chatNotifier.chatList[index].userKey ==
                                  userModel.userKey;
                              return Chat(
                                size: _size,
                                isMine: isMine,
                                chatModel: chatNotifier.chatList[index],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 12,
                              );
                            },
                            itemCount: chatNotifier.chatList.length),
                      )),
                  _buildInputBar(userModel)
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  MaterialBanner _buildItemInfo(BuildContext context) {
    ChatroomModel? chatroomModel = context.read<ChatNotifier>().chatroomModel;
    return MaterialBanner(
      padding: EdgeInsets.zero,
      leadingPadding: EdgeInsets.zero,
      actions: [Container()],
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 12, top: 12, bottom: 12),
                child: chatroomModel == null
                    ? Shimmer.fromColors(
                  highlightColor: Colors.grey[300]!,
                  baseColor: Colors.grey,
                  child: Container(
                      width: 32, height: 32, color: Colors.white),
                )
                    : ExtendedImage.network(
                  chatroomModel.itemImage,
                  fit: BoxFit.cover,
                  width: 32,
                  height: 32,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '거래완료',
                        style: Theme.of(context).textTheme.bodyText1,
                        children: [
                          TextSpan(text: ' '),
                          TextSpan(
                              text: chatroomModel == null
                                  ? ""
                                  : chatroomModel.itemTitle,
                              style: Theme.of(context).textTheme.bodyText2)
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: chatroomModel == null
                            ? ""
                            : chatroomModel.itemLevel,
                        style: Theme.of(context).textTheme.bodyText1,
                        children: [
                          TextSpan(
                              text: '(가격제안불가)',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: Colors.black12))
                        ]),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 12),
            child: SizedBox(
              height: 32,
              child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    size: 16,
                    color: Colors.black87,
                  ),
                  label: Text('후기 남기기',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black87)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side:
                          BorderSide(color: Colors.grey[300]!, width: 1)))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(UserModel userModel) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.grey,
              )),
          Expanded(
              child: TextFormField(
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: '메세지를 입력하세요.',
                    isDense: true,
                    fillColor: Colors.white,
                    filled: true,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        print('icon clicked');
                      },
                      child:
                      Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                    ),
                    suffixIconConstraints: BoxConstraints.tight(Size(40, 40)),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey))),
              )),
          IconButton(
              onPressed: () async {
                ChatModel chatModel = ChatModel(
                    userKey: userModel.userKey,
                    msg: _textEditingController.text,
                    createdDate: DateTime.now());

                _chatNotifier.addNewChat(chatModel);
                print('${_textEditingController.text}');
                _textEditingController.clear();
              },
              icon: Icon(
                Icons.send,
                color: Colors.grey,
              )),
        ],
      ),
    );
  }
}