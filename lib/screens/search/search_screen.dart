import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/common_size.dart';
import '../../data/item_model.dart';
import '../../repo/algolia_service.dart';
import '../../utils/logger.dart';
import '../../widgets/item_list_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static final borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[200]!));

  final TextEditingController _textEditingController = TextEditingController();

  final List<ItemModel> items = [];

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
          ),
          child: Container(
            child: Center(
              child: TextFormField(
                controller: _textEditingController,
                autofocus: true,
                onFieldSubmitted: (value) async {
                  String value1 = value.toString();
                  isProcessing = true;
                  setState(() {});
                  List<ItemModel> newItems =
                  await AlgoliaService().queryItems(value1);
                  if (newItems.isNotEmpty) {
                    items.clear();
                    items.addAll(newItems);
                  }
                  print('${items.toString()}');
                  isProcessing = false;
                  setState(() {});
                },
                decoration: InputDecoration(
                    isDense: true,
                    fillColor: Colors.grey[200],
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    filled: true,
                    hintText: '아이템 검색',
                    enabledBorder: borderStyle,
                    focusedBorder: borderStyle),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          if (isProcessing)
            LinearProgressIndicator(
              minHeight: 2,
            ),
          ListView.separated(
              padding: EdgeInsets.all(common_padding),
              itemCount: items.length,
              itemBuilder: (context, index) {
                logger.d('아이템 길이 : ${items[0]}');
                ItemModel item = items[index];
                Size size = MediaQuery.of(context).size;
                return ItemListWidget(item , imgSize: size.width / 4);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: common_padding * 2 + 1,
                  thickness: 1,
                  color: Colors.grey[200],
                  indent: common_small_padding,
                  endIndent: common_small_padding,
                );
              },
              ),
        ],
      ),
    );
  }
}