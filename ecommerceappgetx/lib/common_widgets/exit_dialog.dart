import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context){
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        confirm.text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        Divider(),
        10.heightBox,
        exit.text.size(16).color(darkFontGrey).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomButton(
                titleText: yes,
                buttonColor: redColor,
                textColor: whiteColor,
                onPress: (){
                  SystemNavigator.pop();
                }
            ),
            CustomButton(
                titleText: no,
                buttonColor: redColor,
                textColor: whiteColor,
                onPress: (){
                  Navigator.pop(context);
                }
            ),
          ],
        ),
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).rounded.make(),
  );
}