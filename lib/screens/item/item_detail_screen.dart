import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sports_matching/repo/item_service.dart';
import '../../constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import '../../data/item_model.dart';
class ItemDetailScreen extends StatefulWidget {
  final String itemKey;
  const ItemDetailScreen(this.itemKey, {Key? key}) : super(key: key);

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}


class _ItemDetailScreenState extends State<ItemDetailScreen> {
  PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();
  bool isAppbarCollapsed = false;
  Size? _size;
  num? _statusBarHeight;
  @override
  void initState() {
    print('_size: $_size');
    print('_statusBarHeight $_statusBarHeight');
    _scrollController.addListener(() {
      print('flag');
      if(_size == null || _statusBarHeight == null)
        return;
      if(isAppbarCollapsed){
        if(_scrollController.offset < _size!.width - kToolbarHeight - _statusBarHeight!){
          isAppbarCollapsed = false;
          setState(() {});
        }

      }else{
        if(_scrollController.offset > _size!.width - kToolbarHeight - _statusBarHeight!){
          isAppbarCollapsed = true;
          setState(() {});
        }
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ItemModel>(
      future: ItemService().getItem(widget.itemKey),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ItemModel itemModel = snapshot.data!;
          return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              _size = MediaQuery.of(context).size;
              _statusBarHeight = MediaQuery.of(context).padding.top;
              return Stack(
                fit: StackFit.expand,
                children: [
                  Scaffold(
                    body: CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: _size!.width,
                          flexibleSpace: FlexibleSpaceBar(
                            title: SizedBox(
                              child: SmoothPageIndicator(
                                  controller: _pageController, // PageController
                                  count: itemModel.imageDownloadurls.length,
                                  effect: WormEffect(
                                      activeDotColor: Theme.of(context).primaryColor,
                                      dotColor: Theme.of(context).colorScheme.background,
                                      radius: 2,
                                      dotHeight: 4,
                                      dotWidth: 4
                                  ), // your preferred effect
                                  onDotClicked: (index) {}),
                            ),
                                centerTitle: true,
                                background: PageView.builder(
                                  controller: _pageController,
                                  allowImplicitScrolling: true,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ExtendedImage.network(
                                      itemModel.imageDownloadurls[index],
                                      fit: BoxFit.cover,
                                      scale: 0.1,
                                    );
                                  },
                                  itemCount: itemModel.imageDownloadurls.length,
                                ),
                          ),
                        ),
                        // SliverToBoxAdapter(
                        //   child: Container(
                        //     height: _size!.height * 2,
                        //     color: Colors.cyan,
                        //     child:
                        //     Center(child: Text('item key is${widget.itemKey}')),
                        //   ),
                        // ),
                        SliverList(
                          delegate: SliverChildListDelegate([
                              Row(
                                children: [
                                  ExtendedImage.network(
                                    'https://picsum.photos/50',
                                    fit: BoxFit.cover,
                                    width: _size!.width/10,
                                    height: _size!.width/10,
                                    shape: BoxShape.circle,
                                  ),
                                  //Expanded(child: child)
                                  Column(
                                    children: [
                                      Text('유저이름'),
                                      Text('유저 위치')
                                    ]
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text('37.3', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),),
                                              SizedBox(
                                                  width: 50,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(2),
                                                    child: LinearProgressIndicator(
                                                      color: Colors.blueAccent,
                                                      value: 0.373,
                                                      minHeight: 3,
                                                      backgroundColor: Colors.grey[200],
                                                    ),
                                                  )
                                              )
                                            ],
                                          ),
                                          ImageIcon(ExtendedAssetImageProvider('assets/imgs/happiness.png'), color: Colors.blueAccent)
                                        ],
                                      ),
                                      Text('매너점수', style: TextStyle(decoration: TextDecoration.underline),
                                      )
                                    ],
                                  )
                                ],
                              )
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: kToolbarHeight + _statusBarHeight!,
                    child: Container(
                      height: kToolbarHeight + _statusBarHeight!,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black12,
                                Colors.black12,
                                Colors.black12,
                                Colors.black12,
                                Colors.transparent
                              ])),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    height: kToolbarHeight+_statusBarHeight!,
                    child: Scaffold(
                      backgroundColor: Colors.transparent,
                      appBar: AppBar(
                        backgroundColor: isAppbarCollapsed?Colors.red:Colors.transparent,
                        shadowColor: Colors.transparent,
                        foregroundColor: isAppbarCollapsed?Colors.black87:Colors.white,
                      ),
                    ),
                  )
                ],
              );
            },
          );
        }
        return Container();
      },
    );
  }
}