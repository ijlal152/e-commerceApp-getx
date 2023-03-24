import 'package:ecommerceappgetx/consts/consts.dart';

Widget detailsCard({required width, required String title, required String count}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count.text.fontFamily(bold).color(darkFontGrey).size(14).make(),
      5.heightBox,
      title.text.color(darkFontGrey).size(11).make()
    ],
  ).box.white.rounded.width(width).height(70).padding(const EdgeInsets.all(4)).make();
}