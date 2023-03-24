 import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/views/category_screen/category_details.dart';
import 'package:get/get.dart';

Widget featuredButton({required String title, required icon}){
  return Row(
    children: [
      Image.asset(icon, width: 60, fit: BoxFit.fill,),
      10.widthBox,
      title.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white.padding(const EdgeInsets.all(4))
      .roundedSM.outerShadowSm
      .make().onTap(() {
        Get.to(() => CategoryDetails(title: title));
  });
}