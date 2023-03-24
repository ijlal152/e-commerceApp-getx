import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/consts/lists.dart';
import 'package:ecommerceappgetx/controllers/product_controller.dart';
import 'package:ecommerceappgetx/views/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String title;
  dynamic data;
  ItemDetails({Key? key, required this.title, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(Colors.orange.value);
    // print(Colors.pink.v alue);
    // print(Colors.green.value);
    var productController = Get.put(ProductController());
    return WillPopScope(
      onWillPop: ()async{
        productController.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            productController.resetValues();
            Get.back();
          }, icon: const Icon(Icons.arrow_back)),
          title: title.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.share)
            ),
            Obx(
                () => IconButton(
                  onPressed: (){
                    if(productController.isFav.value){
                      productController.removeFromWishList(data.id, context);
                      //productController.isFav(false);
                    }else{
                      productController.addToWishList(data.id, context);
                      //productController.isFav(true);
                    }
                  },
                  icon: Icon(Icons.favorite,
                  color: productController.isFav.value ? redColor : darkFontGrey,
                  )
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VxSwiper.builder(
                          autoPlay: true,
                            height: 350,
                            viewportFraction: 1.0,
                            itemCount: data['p_imgs'].length,
                            aspectRatio: 16 /9,
                            itemBuilder: (context, index){
                              return Image.network(
                                data['p_imgs'][index],
                              width: double.infinity,
                              fit: BoxFit.cover,);
                            }
                        ),
                        10.heightBox,

                        title.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),

                        10.heightBox,

                        VxRating(
                          value: double.parse(data['p_rating']),
                            onRatingUpdate: (value){

                            },
                          normalColor: textfieldGrey,
                          selectionColor: golden,
                          count: 5,
                          maxRating: 25,
                          size: 25,
                          stepInt: true,
                        ),

                        10.heightBox,

                        "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(18).make(),

                        10.heightBox,

                        Row(
                          children: [
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Seller".text.white.fontFamily(semibold).make(),
                                    5.heightBox,
                                    "${data['p_seller']}".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                                  ],
                                )
                            ),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.message_rounded, color: darkFontGrey,),
                            ).onTap(() {
                              Get.to(() => ChatScreen(),
                              arguments: [data['p_seller'], data['vendor_id']],
                              );
                            }),
                          ],
                        ).box.height(60).padding(const EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),

                        20.heightBox,
                        Obx(
                          () =>  Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                     width: 100,
                                    child: color.text.color(textfieldGrey).make(),
                                  ),
                                  Row(
                                    children: List.generate(
                                        data['p_colors'].length,
                                            (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                VxBox()
                                                    .size(40, 40).roundedFull
                                                    .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                                .margin(const EdgeInsets.symmetric(horizontal: 4)).make().onTap(() {
                                                  productController.changeColorIndex(index);
                                                }),

                                                Visibility(
                                                  visible: index == productController.colorIndex.value,
                                                    child: const Icon(Icons.done, color: Colors.white,)),
                                              ],
                                            )),
                                  ),
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),

                              // qyantity row

                              Obx(
                                () => Row(
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: quantity.text.color(textfieldGrey).make(),
                                    ),
                                    IconButton(
                                        onPressed: (){
                                          productController.decreaseQty();
                                          productController.calculateTotalPrice(int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)
                                    ),
                                    productController.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                    IconButton(
                                        onPressed: (){
                                          productController.increaseQty(int.parse(data['p_qty']));
                                          productController.calculateTotalPrice(int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)
                                    ),
                                    10.widthBox,
                                    "${data['p_qty']} available".text.color(textfieldGrey).make(),
                                  ],
                                ).box.padding(const EdgeInsets.all(8)).make(),
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: total.text.color(textfieldGrey).make(),
                                  ),
                                  "${productController.totalPrice.value}".numCurrency.text.color(redColor).size(16).fontFamily(bold).make()
                                ],
                              ).box.padding(const EdgeInsets.all(8)).make(),
                            ],
                          ).box.white.shadowSm.make(),
                        ),

                        10.heightBox,
                        description.text.color(darkFontGrey).fontFamily(semibold).make(),
                        10.heightBox,
                        "${data['p_desc']}".text.color(darkFontGrey).make(),

                        10.heightBox,
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: List.generate(itemDetailButtonsList.length, (index) => ListTile(
                            title: itemDetailButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).semiBold.make(),
                            trailing: const Icon(Icons.arrow_forward),
                          )),
                        ),

                        // products your may also like section
                        20.heightBox,

                        productsyoumaylike.text.color(darkFontGrey).fontFamily(bold).size(16).make(),

                        10.heightBox,

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(6, (index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(imgP1, width: 150, fit: BoxFit.cover,),
                                10.heightBox,
                                "Laptop 4GB/64GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                                10.heightBox,
                                "\$600".text.color(redColor).fontFamily(bold).size(16).make(),
                              ],
                            ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(8)).make()),
                          ),
                        ),

                      ],
                    ),
                  ),
                )
            ),



            SizedBox(
              height: 60,
              width: double.infinity,
              child: CustomButton(
                  titleText: addToCart,
                  buttonColor: redColor,
                  textColor: whiteColor,
                  onPress: (){
                    if(productController.quantity.value > 0){
                      productController.addToCart(
                          context: context,
                          vendorId: data['vendor_id'],
                          title: data['p_name'].toString(),
                          img: data['p_imgs'][0].toString(),
                          sellerName: data['p_seller'].toString(),
                          color: data['p_colors'][productController.colorIndex.value].toString(),
                          qty: productController.quantity.value.toString(),
                          tPrice: productController.totalPrice.value.toString()
                      );
                      VxToast.show(context, msg: addedtocart);
                    }else{
                      VxToast.show(context, msg: "Quantity can't be 0");
                    }
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
