import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/cart_controller.dart';
import 'package:ecommerceappgetx/views/home_screen/home.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: "Choose Payment Method".text.fontFamily(semibold).color(darkFontGrey).make(),
        ),

        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
              () => Column(
              children: List.generate(paymetMethodsImgList.length, (index) {
                return GestureDetector(
                  onTap: (){
                    cartController.changePaymentMethodIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: cartController.paymentIndex.value == index ? redColor : Colors.transparent,
                        width: 3
                      )
                    ),
                    child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(paymetMethodsImgList[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          colorBlendMode: cartController.paymentIndex.value == index ? BlendMode.darken : BlendMode.color,
                          color: cartController.paymentIndex.value == index ? Colors.black.withOpacity(0.4) : Colors.transparent,
                          ),
                          cartController.paymentIndex.value == index ?Transform.scale(
                            scale: 1.3,
                            child: Checkbox(
                                value: true,
                                activeColor: Colors.green,
                                onChanged: (value){
                                  //cartController.paymentIndex = value;
                                },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                              ),
                            ),
                          ) : Container(),

                          Positioned(
                            bottom: 5,
                              right: 10,
                              child: paymentMethodName[index].text.white.fontFamily(semibold).size(16).make()
                          ),
                        ],
                      ),

                  ),
                );
              }),
            ),
          ),
        ),


        bottomNavigationBar: SizedBox(
          height: 60,
          child: SizedBox(
            height: 60,
            child: cartController.placingOrder.value ? const Center(child: CircularProgressIndicator(),) :CustomButton(
                titleText: "Please my order",
                buttonColor: redColor,
                textColor: whiteColor,
                onPress: () async{
                  await cartController.placeMyOrder(
                      orderPaymentMethod: paymentMethodName[cartController.paymentIndex.value],
                      totalAmount: cartController.totalP.value
                  );
                  await cartController.clearCart();
                  VxToast.show(context, msg: "Your order has been placed successfully");
                  Get.offAll(() => Home());
                }
            ),
          ),
        ),
      ),
    );
  }
}
