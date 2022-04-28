import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../states/user_provider.dart';
import '../../utils/logger.dart';

class IntroPage extends StatelessWidget {
  PageController controller;
  IntroPage(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    logger.d('현재 유저 상태 ${context.read<UserProvider>().userState}');
    return LayoutBuilder(
      builder: (context, constraints){
        Size size = MediaQuery.of(context).size; //디바이스의 사이즈를 가지고 온다. width height
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('스포츠 매칭 시스템',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Theme.of(context).colorScheme.primary)),
                SizedBox(
                    width: size.width*0.6,
                    height: size.height*0.5,
                    child: ExtendedImage.asset('assets/imgs/ronnie.png')),
                Text('"최대한 무겁게, 최대한 많이"\n' '-로니콜먼-', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                Text('스포츠 매칭 서비스는 동네 근처 운동할 사람을 구할수 있다.\n''최고의 파트너를 구해 함께 근성장을 도모하자'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(onPressed:(){
                      controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.ease);

                      logger.d('intro page button clicked');
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
      },
    );
  }
}
