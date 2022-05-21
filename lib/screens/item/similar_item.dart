import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:sports_matching/constants/common_size.dart';

class SimilarItem extends StatelessWidget {
  const SimilarItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AspectRatio(
          aspectRatio: 5/4,
            child: ExtendedImage.network('https://picsum.photos/100', fit: BoxFit.cover,borderRadius: BorderRadius.circular(8), shape: BoxShape.rectangle,),
        ),
        Text('Similar data title', overflow: TextOverflow.ellipsis, maxLines: 1),
        Padding(
          padding: const EdgeInsets.only(bottom: common_small_padding),
          child: Text('Similar data price', style: TextStyle(color: Colors.black54, fontSize: 11, fontWeight: FontWeight.w100)),
        )
      ],
    );
  }
}
