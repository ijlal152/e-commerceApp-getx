import 'package:ecommerceappgetx/consts/consts.dart';

Widget CustomButton({required String titleText, required Color buttonColor, required Color textColor, required VoidCallback onPress}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: buttonColor,
      padding: const EdgeInsets.all(12)
    ),
      onPressed: onPress, child: titleText.text.color(textColor).fontFamily(bold).make()
  );
}