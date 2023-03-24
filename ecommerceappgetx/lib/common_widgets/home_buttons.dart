import 'package:ecommerceappgetx/consts/consts.dart';

Widget homeButtons({required width, required height, required icon, required String title, required onPress}){
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon, width: 26,),
        10.heightBox,
        title.text.fontFamily(semibold).color(darkFontGrey).make()
      ],
    ).box.rounded.white.size(width, height).shadowSm.make(),
  );
}