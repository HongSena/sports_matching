import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/category_notifier.dart';


class CategoryInputScreen extends StatelessWidget {
  const CategoryInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('종목 선택'),
      ),
      body: ListView.separated(itemBuilder: (context, index){
        return ListTile(
          onTap: (){
            context.read<CategoryNotifier>().setNewCategoryWithKor(categoriesMapEngToKor.values.elementAt(index));
            Beamer.of(context).beamBack();
          },
          title: Text(
            categoriesMapEngToKor.values.elementAt(index),
            style: TextStyle(color: context.read<CategoryNotifier>().currentCategoryInKor == categoriesMapEngToKor.values.elementAt(index) ?Theme.of(context).primaryColor: Colors.black),),
        );
      },
          separatorBuilder: (context, index){
        return Divider(height: 1, thickness: 1, color:  Colors.grey[300],);
          }, itemCount: categoriesMapEngToKor.length)
    );
  }
}

