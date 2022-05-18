import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sports_matching/constants/common_size.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sports_matching/data/item_model.dart';
import 'package:sports_matching/repo/item_service.dart';
import 'package:sports_matching/repo/user_service.dart';

import '../../router/locations.dart';
import '../../utils/logger.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width * 0.25;
        return FutureBuilder<List<ItemModel>>(
            future: ItemService().getItems(),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: (snapshot.hasData && snapshot.data!.isNotEmpty)
                      ?_listView(imgSize, snapshot.data!)
                      :_shimmerListView(imgSize));
            });
      },
    );
  }


  ListView _listView(double imgSize, List<ItemModel> items) {
    return ListView.separated(
      padding: EdgeInsets.all(common_small_padding),
      separatorBuilder: (context, index) {
        return Divider(
          height: common_padding * 2 + 1,
          thickness: 1,
          color: Colors.grey.shade300,
          indent: common_small_padding,
        );
      },
      itemBuilder: (context, index) {
        ItemModel item = items[index];
        return InkWell(
          onTap: () {
            context.beamToNamed('/$LOCATION_ITEM/:${item.itemKey}');
            },
          child: SizedBox(height: imgSize, child: Row(
            children: [
              SizedBox(height: imgSize,
                  width: imgSize,
                  child: ExtendedImage.network(
                    item.imageDownloadurls[0],
                    shape: BoxShape.rectangle,
                    fit: BoxFit.cover,
                    borderRadius: BorderRadius.circular(12),)),
              SizedBox(width: common_small_padding,),
              Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: Theme
                          .of(context)
                          .textTheme
                          .subtitle1),
                      Text('53일 전', style: Theme
                          .of(context)
                          .textTheme
                          .subtitle2),
                      Text(item.requiredLevelSet?'${item.requiredLevel.toString()}레벨':'요구레벨 없음'),
                      Expanded(child: Container()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(CupertinoIcons.chat_bubble_2, color: Colors
                              .grey[500], size: 17),
                          Text('23', style: TextStyle(
                              color: Colors.grey[500], fontSize: 13)),
                          Icon(CupertinoIcons.heart, color: Colors.grey[500],
                              size: 17),
                          Text('30', style: TextStyle(
                              color: Colors.grey[500], fontSize: 13),)
                        ],
                      )
                    ],
                  ))
            ],
          ),),
        );
      }, itemCount: items.length);
  }

  Widget _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      enabled: true,
      child: ListView.separated(
        padding: EdgeInsets.all(common_small_padding),
        separatorBuilder: (context, index) {
          return Divider(
            height: common_padding * 2 + 1,
            thickness: 1,
            color: Colors.grey.shade300,
            indent: common_small_padding,
          );
        },
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {

            },
            child: SizedBox(height: imgSize, child: Row(
              children: [
                Container(
                  height: imgSize,
                  width: imgSize,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    shape: BoxShape.rectangle,
                    color: Colors.white,),
                ),
                SizedBox(width: common_small_padding,),
                Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 16, width: 150, decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          color: Colors.white,)),
                        SizedBox(height: 4,),
                        Container(
                            height: 16, width: 180, decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          color: Colors.white,)),
                        SizedBox(height: 4,),
                        Container(
                            height: 16, width: 100, decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          color: Colors.white,)),
                        Expanded(child: Container()),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(height: 14,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,))
                          ],
                        )
                      ],
                    ))
              ],
            ),),
          );
        }, itemCount: 10,),
    );
  }
}

