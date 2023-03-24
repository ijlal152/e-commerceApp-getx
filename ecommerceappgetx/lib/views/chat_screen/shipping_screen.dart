import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/common_widgets/custom_textfield.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/cart_controller.dart';
import 'package:ecommerceappgetx/views/chat_screen/paymentmethod.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customeTextField("Address", "Street no", cartController.addressController),
            customeTextField("City", "Fateh Jang City", cartController.cityController),
            customeTextField("State", "State", cartController.stateController),
            customeTextField("Postal Code", "Postal Code", cartController.postalCodeController),
            customeTextField("Phone", "Phone", cartController.phoneController),

          ],
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: 60,
        child: CustomButton(
            titleText: "Continue",
            buttonColor: redColor,
            textColor: whiteColor,
            onPress: (){
              if(cartController.addressController.text.length > 10){
                Get.to(() => PaymentMethodScreen());
              }else{
                VxToast.show(context, msg: "Please fill the form");
              }
            }
        ),
      ),
    );
  }
}
