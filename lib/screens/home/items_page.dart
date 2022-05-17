import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_matching/constants/common_size.dart';
import 'package:sports_matching/repo/user_service.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width*0.25;
        return ListView.separated(
          padding: EdgeInsets.all(common_small_padding),
          separatorBuilder: (context, index){
            return Divider(
              height: common_padding*2+1,
              thickness: 1,
              color: Colors.grey.shade300,
              indent: common_small_padding,
            );
          },
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){

              },
              child: SizedBox(height: imgSize, child: Row(
                children: [
                  SizedBox(height: imgSize, width: imgSize, child: ExtendedImage.asset('assets/imgs/ronnie.png', shape: BoxShape.rectangle ,borderRadius: BorderRadius.circular(12),)),
                  SizedBox(width: common_small_padding,),
                  Expanded(child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('work', style: Theme.of(context).textTheme.subtitle1),
                      Text('53일 전', style: Theme.of(context).textTheme.subtitle2),
                      Text('5000원'),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(CupertinoIcons.chat_bubble_2, color: Colors.grey[500], size: 17),
                          Text('23', style: TextStyle( color: Colors.grey[500], fontSize: 13)),
                          Icon(CupertinoIcons.heart, color: Colors.grey[500], size: 17),
                          Text('30', style: TextStyle( color: Colors.grey[500], fontSize: 13),)
                        ],
                      )
                    ],
                  ))
                ],
              ),),
            );}, itemCount: 10,);
      }
    );
  }
}

