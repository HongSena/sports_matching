import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/screens/home_screen.dart';
import 'package:sports_matching/screens/input/category_input_screen.dart';
import 'package:sports_matching/screens/input/input_screen.dart';
import 'package:sports_matching/states/category_notifier.dart';
import 'package:sports_matching/states/select_image_notifier.dart';

import '../screens/item/item_detail_screen.dart';

const LOCATION_HOME = 'home';
const LOCATION_INPUT = 'input';
const LOCATION_ITEM = 'item';
const LOCATION_ITEM_ID = 'item_id';
const LOCATION_CATEGORY_INPUT = 'category_input';





class HomeLocation extends BeamLocation{
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey(LOCATION_HOME))];
  }

  @override
  List get pathBlueprints => ['/'];
}


class InputLocation extends BeamLocation{
  @override
  Widget builder(BuildContext context, Widget navigator) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: categoryNotifier),
          ChangeNotifierProvider(create: (context){return SelectImageNotifier();}),
        ],
      child: super.builder(context, navigator),
    );
    
  }
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if(state.pathBlueprintSegments.contains(LOCATION_INPUT))
        BeamPage(
            key: const ValueKey(LOCATION_INPUT),
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (BuildContext context) => SelectImageNotifier(),
                ),
                ChangeNotifierProvider.value(value: categoryNotifier),
              ],
              child: const InputScreen(),
            ),
        ),
      if(state.pathBlueprintSegments.contains(LOCATION_CATEGORY_INPUT))
        BeamPage(
            key: const ValueKey(LOCATION_CATEGORY_INPUT),
            child: ChangeNotifierProvider.value(value: categoryNotifier, child: const CategoryInputScreen(),)
        ),
    ];
  }

  @override
  List get pathBlueprints =>['/input', '/input/category_input'];

}

class ItemLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      ...HomeLocation().buildPages(context, state),
      if(state.pathParameters.containsKey(LOCATION_ITEM_ID))
        BeamPage(
            key:  ValueKey(LOCATION_ITEM_ID),
            child: ItemDetailScreen(LOCATION_ITEM_ID)
        ),

    ];
  }

  @override
  List get pathBlueprints =>['/${LOCATION_ITEM}/:${LOCATION_ITEM_ID}'];

}