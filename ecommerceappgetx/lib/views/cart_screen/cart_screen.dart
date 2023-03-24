import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/cart_controller.dart';
import 'package:ecommerceappgetx/services/firestore_services.dart';
import 'package:ecommerceappgetx/views/chat_screen/shipping_screen.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartController = Get.put(CartController());
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: CustomButton(
            titleText: proceedtoshopping,
            buttonColor: redColor,
            textColor: whiteColor,
            onPress: (){
              Get.to(() => ShippingScreen());
            }
        ),
      ),
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
          title: shoppingcarttext.text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCartData(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),);
          }else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: cartisempty.text.color(darkFontGrey).make(),
            );
          }else{
            var data = snapshot.data!.docs;
            cartController.productSnapshot = data;
            cartController.calculate(data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                          itemBuilder: (context, index){
                          return ListTile(
                            leading: Image.network(data[index]['img'], width: 80, fit: BoxFit.cover,),
                            title: "${data[index]['title']} (x${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                            subtitle: "${data[index]['tPrice']}".numCurrency.text.fontFamily(semibold).color(redColor).make(),
                            trailing: const Icon(Icons.delete, color: Colors.red,).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          );
                          }
                      )
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      totalPrice.text.fontFamily(semibold).color(darkFontGrey).make(),
                      Obx(() => "${cartController.totalP.value}".numCurrency.text.fontFamily(semibold).color(redColor).make()),
                    ],
                  ).box.padding(const EdgeInsets.all(12)).color(lightgolden)
                      .width(context.screenWidth - 60).roundedSM.make(),
                  10.heightBox,

                  // SizedBox(
                  //   width: context.screenWidth - 60,
                  //   child: CustomButton(
                  //       titleText: proceedtoshopping,
                  //       buttonColor: redColor,
                  //       textColor: whiteColor,
                  //       onPress: (){}
                  //   ),
                  // ),
                ],
              ),
            );
          }
          }
      )
    );
  }
}
