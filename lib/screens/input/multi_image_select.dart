import 'dart:typed_data';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_matching/states/select_image_notifier.dart';
import '../../constants/common_size.dart';
import 'package:provider/provider.dart';
import 'package:sports_matching/states/select_image_notifier.dart';

class MultiImageSelect extends StatefulWidget {
  MultiImageSelect({
    Key? key,
  }) : super(key: key);

  @override
  State<MultiImageSelect> createState() => _MultiImageSelectState();
}

class _MultiImageSelectState extends State<MultiImageSelect> {
  @override
  Widget build(BuildContext context){

    return LayoutBuilder(
      builder: (context, constraints){
        SelectImageNotifier selectImageNotifier = context.watch<SelectImageNotifier>();
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
                child: InkWell(
                  onTap: () async {
                    final ImagePicker _picker = ImagePicker();
                    final List<XFile>? images = await _picker.pickMultiImage(imageQuality: 10);
                    if(images != null && images.isNotEmpty){
                      await context.read<SelectImageNotifier>().setNewImages(images);
                    }
                  },
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
              ),
              ...List.generate(selectImageNotifier.images.length, (index) => Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: common_padding/2, top: common_padding, bottom: common_padding),
                    child: ExtendedImage.memory(
                        selectImageNotifier.images[index],
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                        loadStateChanged: (state){
                          switch(state.extendedImageLoadState){
                            case LoadState.loading:
                              return Container(width: imageSize, height: imageSize, padding: EdgeInsets.all(imageSize/3), child: CircularProgressIndicator());
                            case LoadState.completed:
                              return null;
                            case LoadState.failed:
                              return Icon(Icons.cancel);
                          }
                        },
                        borderRadius: BorderRadius.circular(16),
                        shape: BoxShape.rectangle)
                  ),
                  Positioned(
                      right: 8,
                      width: 24,
                      height: 24,
                      child: IconButton(
                          padding: EdgeInsets.all(8),
                          onPressed: (){
                            selectImageNotifier.removeImage(index);
                            setState(() {});
                          },
                          icon: Icon(
                              Icons.remove_circle,
                              color: Colors.grey
                          )
                      )
                  )
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
