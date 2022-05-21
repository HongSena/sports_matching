import 'package:beamer/beamer.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';
import 'package:sports_matching/data/item_model.dart';
import 'package:sports_matching/repo/item_service.dart';
import '../../data/user_model.dart';
import '../../router/locations.dart';

class MapPage extends StatefulWidget {
  final UserModel _userModel;
  const MapPage(this._userModel, {Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late final controller;
  Offset? _dragStart;
  double _scaleData = 1.0;

  void initState() {
    controller = MapController(location: LatLng(widget._userModel.geoFirePoint.latitude, widget._userModel.geoFirePoint.longitude));
    super.initState();
  }

  _scaleStart(ScaleStartDetails details){
    _dragStart = details.focalPoint;
    _scaleData = 1.0;
  }
  _scaleUpdate(ScaleUpdateDetails details){

    var scaleDiff = details.scale - _scaleData;
    _scaleData = details.scale;
    controller.zoom += scaleDiff;

    final now = details.focalPoint;
    final diff = now - _dragStart!;
    _dragStart = now;
    controller.drag(diff.dx, diff.dy);
    setState(() {});
  }

  Widget _buildItemWidget(Offset offset, ItemModel itemModel){
    String imgUrl = "";
    if(itemModel.category == 'football'){
      imgUrl = 'assets/imgs/football-ball.png';
    }else if(itemModel.category == 'baskeyball'){
      imgUrl = 'assets/imgs/football-ball.png';
    }else if(itemModel.category == 'baseball'){
      imgUrl = 'assets/imgs/baseball.png';
    }else if(itemModel.category == 'bodybuilding'){
      imgUrl = 'assets/imgs/ronnie.png';
    }else if(itemModel.category == 'crossfit'){
      imgUrl = 'assets/imgs/crossfit.png';
    }else if(itemModel.category == 'powerlifting'){
      imgUrl = 'assets/imgs/powerlifting.png';
    }else if(itemModel.category == 'running'){
      imgUrl = 'assets/imgs/run.png';
    }else if(itemModel.category == 'fencing'){
      imgUrl = 'assets/imgs/fencing.png';
    }else{
      imgUrl = 'assets/imgs/tomato.png';
    }
    return Positioned(
          left: offset.dx,
          top: offset.dy,
          width: 34,
          height: 34,
          child: InkWell(
            onTap: (){
              context.beamToNamed('/$LOCATION_ITEM/:${itemModel.itemKey}');
            },
              child: ExtendedImage.asset(imgUrl, shape: BoxShape.circle)
          )
      );
  }

  Widget _bulidMarkerWidget(Offset offset, {Color color = Colors.red}){
    return Positioned(
        left: offset.dx,
        top: offset.dy,
        width: 24,
        height: 24,
        child: Icon(Icons.location_on, color: color,)
    );
  }
  @override
  Widget build(BuildContext context) {
    return MapLayoutBuilder(
      builder: (BuildContext context, MapTransformer transformer) { 
        final myLocationOnMap = transformer.fromLatLngToXYCoords(LatLng(widget._userModel.geoFirePoint.latitude, widget._userModel.geoFirePoint.longitude));
        final myLocationWidget = _bulidMarkerWidget(myLocationOnMap);
        Size size = MediaQuery.of(context).size;
        final middleOnScreen = Offset(size.width/2, size.height/2);
        final latLngOnMap = transformer.fromXYCoordsToLatLng(middleOnScreen);
        return FutureBuilder<List<ItemModel>>(
          future: ItemService().getNearByItems(widget._userModel.userKey, latLngOnMap),
          builder: (context, snapshot) {
            List<Widget> nearByItems = [];
            if(snapshot.hasData){
              snapshot.data!.forEach((item) {
                //print('print poinr = ${item.geoFirePoint.latitude} - ${item.geoFirePoint.longitude}');
                final offset = transformer.fromLatLngToXYCoords(LatLng(item.geoFirePoint.latitude, item.geoFirePoint.longitude));
                nearByItems.add(_buildItemWidget(offset, item));
              });
            }
            return Stack(
              children: [
                GestureDetector(
                  onScaleStart: _scaleStart,
                  onScaleUpdate: _scaleUpdate,
                  child: Map(
                    controller: controller,
                    builder: (context, x, y, z) {
                      final url = 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
                      return ExtendedImage.network(
                        url,
                        fit: BoxFit.cover,
                      );
                    },),
                ),
                myLocationWidget,
                ...nearByItems
              ],
            );
          }
        );
      },
      controller: controller,
    );
  }

}
