import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../data/chatroom_model.dart';
import '../../repo/chat_service.dart';

class ChatListPage extends StatelessWidget {
  final String userKey;
  const ChatListPage({Key? key, required this.userKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChatroomModel>>(
        future: ChatService().getMyChatList(userKey),
        builder: (context, snapshot) {
          Size size = MediaQuery.of(context).size;
          return Scaffold(
            body: ListView.separated(
                itemBuilder: (context, index) {
                  ChatroomModel chatroomModel = snapshot.data![index];
                  bool iamBuyer = chatroomModel.buyerKey == userKey;

                  return ListTile(
                    onTap: () {
                      context.beamToNamed('/:${chatroomModel.chatroomKey}');
                    },
                    leading: ExtendedImage.asset(
                      'assets/imgs/ronnie.png',
                      shape: BoxShape.circle,
                      fit: BoxFit.cover,
                      height: size.width / 8,
                      width: size.width / 8,
                    ),
                    trailing: ExtendedImage.network(
                      chatroomModel.itemImage,
                      shape: BoxShape.rectangle,
                      fit: BoxFit.cover,
                      height: size.width / 8,
                      width: size.width / 8,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    title: RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: iamBuyer
                              ? chatroomModel.itemTitle
                              : chatroomModel.itemTitle,
                          style: Theme.of(context).textTheme.subtitle1,
                          children: [
                            TextSpan(text: " "),
                            TextSpan(
                              text: "${chatroomModel.itemAddress}",
                              style: TextStyle(fontSize: 8),
                            )
                          ]),
                    ),
                    subtitle: Text(
                      chatroomModel.lastMsg,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 10, color: Colors.grey[500])
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.grey[300],
                  );
                },
                itemCount: snapshot.hasData ? snapshot.data!.length : 0),
          );
        });
  }
}