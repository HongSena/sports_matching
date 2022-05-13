import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/common_size.dart';

class MultiImageSelect extends StatelessWidget {
  const MultiImageSelect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        Size _size = MediaQuery.of(context).size;
        var imageSize = _size.width*0.3 - common_small_padding * 4;
        return SizedBox(
          height: _size.width*0.3,
          width: _size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Padding(
                padding: const EdgeInsets.all(common_padding),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded, color: Colors.grey),
                      Text('0/10', style: TextStyle(color: Colors.grey),)
                    ],
                  ),
                  width: imageSize,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.grey, width: 1)),
                ),
              ),
              ...List.generate(20, (index) => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: common_padding/2, top: common_padding, bottom: common_padding),
                    child: ExtendedImage.network('https://picsum.photos/100', width: imageSize, height: imageSize, borderRadius: BorderRadius.circular(16), shape: BoxShape.rectangle),
                  ),
                  Positioned(right: 8, width: 24, height: 24, child: IconButton(padding: EdgeInsets.all(8),onPressed: (){}, icon: Icon(Icons.remove_circle, color: Colors.grey)))
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
