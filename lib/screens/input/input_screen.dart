import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sports_matching/repo/image_storage.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import 'package:sports_matching/constants/common_size.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/data/item_model.dart';
import 'package:sports_matching/repo/item_service.dart';
import 'package:sports_matching/router/locations.dart';
import 'package:sports_matching/states/category_notifier.dart';
import 'package:sports_matching/states/select_image_notifier.dart';
import 'package:sports_matching/states/user_notifier.dart';
import '../../utils/logger.dart';
import 'multi_image_select.dart';


class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  var _divider =  Divider(height: 1, thickness: 1, color: Colors.grey, indent: common_padding, endIndent: common_padding);
  bool _levelLimitSelected = false;
  var _border = UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent));
  TextEditingController _levelController = TextEditingController();
  bool isCreatingItem = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Size _size = MediaQuery.of(context).size;
        return IgnorePointer(
          ignoring: isCreatingItem,
          child: Scaffold(
              appBar: AppBar(
                leading: TextButton(onPressed:(){
                  context.beamToNamed('/');
                },
                  child: Text('뒤로', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                ),
                bottom: PreferredSize(preferredSize: Size( _size.width, 2), child: isCreatingItem?LinearProgressIndicator(minHeight: 2,):Container()),
                title: Text('파티생성 페이지'),
                actions: [
                  TextButton(onPressed: attemptCreateItem,
                    child: Text('완료', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  MultiImageSelect(),
                  Text('    운동 장소의 사진을 올려주세요'),
                  _divider,

                  TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                          hintText: '글 제목',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: common_padding
                          ),
                          focusedBorder:_border,enabledBorder: _border
                      )
                  ),
                  _divider,
                  ListTile(onTap: (){
                    context.beamToNamed('/$LOCATION_INPUT/$LOCATION_CATEGORY_INPUT');
                  },
                    dense:true,
                    title: (context.watch<CategoryNotifier>().currentCategoryInKor == '선택')?Text('운동을 선택하세요'):Text(context.watch<CategoryNotifier>().currentCategoryInKor), trailing: Icon(Icons.navigate_next),),
                  _divider,
                  ListTile(onTap: (){
                    context.beamToNamed('/$LOCATION_INPUT/$LOCATION_MAP_INPUT');
                  },
                    dense:true,
                    title: Text('운동을 할 곳을 선택하세요'), trailing: Icon(Icons.navigate_next),),
                  _divider,
                  Row(children: [
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(left: common_padding),
                      child: TextFormField(keyboardType: TextInputType.number, controller: _levelController, decoration: InputDecoration(hintText: '요구 헬창력을 설정하세요', icon: Icon(Icons.sports_tennis_sharp, color: (_levelController.text.isEmpty)?Colors.grey:Colors.black87),focusedBorder: _border, enabledBorder: _border),),
                    )),
                    TextButton.icon(onPressed: (){setState(() {
                      _levelLimitSelected = !_levelLimitSelected;
                    });}, icon: Icon(_levelLimitSelected?Icons.check_circle:Icons.check_circle_outline, color: _levelLimitSelected?Theme.of(context).primaryColor:Colors.black54),label: Text('설정하기', style: TextStyle(color: _levelLimitSelected?Theme.of(context).primaryColor:Colors.black54),), style: TextButton.styleFrom(backgroundColor: Colors.transparent, primary: Colors.grey))],),
                  _divider,
                  TextFormField(controller: _detailController, maxLines: null,keyboardType: TextInputType.multiline,decoration: InputDecoration(hintText: '게시글 내용', contentPadding: EdgeInsets.symmetric(horizontal: common_padding),focusedBorder: _border,enabledBorder: _border)),

                ],
              )
          ),
        );
      },
    );
  }

  void attemptCreateItem() async {
    if(FirebaseAuth.instance.currentUser == null) return;
    isCreatingItem = true;
    setState(() {});
    final String userKey = FirebaseAuth.instance.currentUser!.uid;
    final String itemKey = ItemModel.generateItemKey(userKey);
    UserNotifier userNotifier = context.read<UserNotifier>();
    List<Uint8List> images = context.read<SelectImageNotifier>().images;
    if(userNotifier.userModel == null) return;
    List<String> downloadUrls = await ImageStorage.uploadImage(images, itemKey);
    logger.d('img upload finished - ${downloadUrls.toString()}');
    ItemModel itemModel = ItemModel(
      itemKey: itemKey,
      userKey: userKey,
      imageDownloadurls: downloadUrls,
      title: _titleController.text,
      category: context.read<CategoryNotifier>().currentCategoryInEng,
      requiredLevel: _levelController.text,
      requiredLevelSet: _levelLimitSelected,
      detail: _detailController.text,
      address: userNotifier.userModel!.address,
      geoFirePoint: userNotifier.userModel!.geoFirePoint,
      createdDate: DateTime.now().toUtc(),
    );
    logger.d('img upload finished - ${itemKey}');

    await ItemService().createNewItem(itemModel.toJson(), itemKey);
    isCreatingItem = false;
    context.beamBack();
  }
}

