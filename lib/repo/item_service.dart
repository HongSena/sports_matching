import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sports_matching/data/item_model.dart';

import '../constants/data_keys.dart';
import '../utils/logger.dart';

class ItemService{
  static final ItemService _itemService = ItemService._internal();
  factory ItemService() => _itemService;
  ItemService._internal();


  Future createNewItem(Map<String, dynamic> json, String itemkey) async {
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemkey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    logger.d(documentSnapshot.data().toString());
    if (!documentSnapshot.exists) {
      await documentReference.set(json);
    }
  }

  Future<ItemModel> getItem(String itemKey) async{
    DocumentReference<Map<String, dynamic>> documentReference = FirebaseFirestore.instance.collection(COL_ITEMS).doc(itemKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    ItemModel itemModel = ItemModel.fromSnapShot(documentSnapshot);

    return itemModel;
  }

}