import 'package:algolia/algolia.dart';

import '../data/item_model.dart';
import '../utils/logger.dart';

const Algolia algolia = Algolia.init(
  applicationId: 'M5B3SL2SS8',
  apiKey: '0018de7278ee07d72db26cd316d5f03f',
);

class AlgoliaService {
  static final AlgoliaService _algoliaService = AlgoliaService._internal();

  factory AlgoliaService() => _algoliaService;

  AlgoliaService._internal();

  Future<List<ItemModel>> queryItems(String queryStr) async {
    logger.d(queryStr);
    AlgoliaQuery query = algolia.instance.index('items').query(queryStr);
    // Perform multiple facetFilters
    // query = query.facetFilter('status:published');
    // query = query.facetFilter('isDelete:false');
    AlgoliaQuerySnapshot algoliaSnapshot = await query.getObjects();
    List<AlgoliaObjectSnapshot> hits = algoliaSnapshot.hits;
    logger.d(hits.length);
    List<ItemModel> items = [];
    hits.forEach((element) {
      ItemModel item =
      ItemModel.fromAlgoliaObject(element.data, element.objectID);
      items.add(item);
    });
    return items;
  }
}
