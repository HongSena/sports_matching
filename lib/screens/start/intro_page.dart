import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import '../../utils/logger.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('스포츠 매칭 시스템', style: TextStyle(fontSize: 22, color: Colors.red),),
            ExtendedImage.asset('assets/imgs/ronnie.png'),
            Text('"최대한 무겁게, 최대한 많이"\n' '-로니콜먼-', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
            Text('스포츠 매칭 서비스는 동네 근처 운동할 사람을 구할수 있다.\n''최고의 파트너를 구해 함께 근성장을 도모하자'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextButton(onPressed:(){
                  logger.d('button clicked');
                },
                    child: Text(
                      '지금 운동 파트너 구하러 가기',
                    style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(backgroundColor: Colors.red,),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
