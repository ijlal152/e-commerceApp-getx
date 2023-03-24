import 'package:ecommerceappgetx/consts/consts.dart';

Widget customeTextField(String title, String hint,  controller){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title.text.color(redColor).fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          fillColor: lightGrey,
          isDense: true,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: redColor)
          )
        ),
      ),

      5.heightBox,
    ],
  );
}