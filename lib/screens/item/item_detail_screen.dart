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
              Size _size = MediaQuery.of(context).size;
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: _size.width,
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
                    SliverToBoxAdapter(
                      child: Container(
                        height: _size.height * 2,
                        color: Colors.cyan,
                        child:
                        Center(child: Text('item key is${widget.itemKey}')),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
