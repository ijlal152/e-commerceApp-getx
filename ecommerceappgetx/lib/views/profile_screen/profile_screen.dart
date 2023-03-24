import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/common_widgets/bg_widget.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/consts/lists.dart';
import 'package:ecommerceappgetx/controllers/auth_controller.dart';
import 'package:ecommerceappgetx/controllers/profile_controller.dart';
import 'package:ecommerceappgetx/services/firestore_services.dart';
import 'package:ecommerceappgetx/views/auth_screen/login_screen.dart';
import 'package:ecommerceappgetx/views/chat_screen/message_screen.dart';
import 'package:ecommerceappgetx/views/order_screen/order_screen.dart';
import 'package:ecommerceappgetx/views/profile_screen/components/details_card.dart';
import 'package:ecommerceappgetx/views/profile_screen/edit_profile_screen.dart';
import 'package:ecommerceappgetx/views/wishlist_screen/wishlist_screen.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final profileController = Get.put(ProfileController());
  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(child: Scaffold(
      body: StreamBuilder(
        stream: FirestoreServices.getuser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            );
          }else{
            var data = snapshot.data!.docs[0];
            return SafeArea(
              child: Column(
                children: [
                  // edit profile button
                  Padding(
                    padding: EdgeInsets.all(10,),
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.edit, color: whiteColor,)
                    ).onTap(() {
                      profileController.nameController.text = data['name'];
                      //profileController.newpassController.text = data['password'];
                      Get.to(() => EditProfileScreen(data: data));
                    }),
                  ),


                  // users details section

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        data['imageUrl'] == "" ? Image.asset(imgProfile2, width: 70,
                          fit:  BoxFit.cover,).box
                            .roundedFull.clip(Clip.antiAlias).make() : Image.network(data['imageUrl'], width: 40,
                          fit:  BoxFit.cover,).box
                            .roundedFull.clip(Clip.antiAlias).make(),
                        10.widthBox,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "${data['name']}".text.fontFamily(semibold).white.make(),
                              "${data['email']}".text.white.make(),
                            ],
                          ),
                        ),
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.white
                                )
                            ),
                            onPressed: () async{
                              await Get.put(AuthController()).signOutMethod(context);
                              Get.offAll(() => LoginScreen());
                            },
                            child: logout.text.fontFamily(semibold).white.make()
                        )
                      ],
                    ),
                  ),

                  //10.heightBox,

                  FutureBuilder(
                    future: FirestoreServices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(),);
                      }else{
                        var countdata= snapshot.data;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                width: context.screenWidth / 3.4,
                                title: 'in your cart',
                                count: "${countdata[0]}"
                            ),
                            detailsCard(
                                width: context.screenWidth / 3.4,
                                title: 'in your wishlist',
                                count: "${countdata[1]}"
                            ),
                            detailsCard(
                                width: context.screenWidth / 3.4,
                                title: 'in your orders',
                                count: "${countdata[2]}"
                            ),
                          ],
                        );
                      }

                      }
                  ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     detailsCard(
                  //         width: context.screenWidth / 3.4,
                  //         title: 'in your cart',
                  //         count: "${data['cart_count']}"
                  //     ),
                  //     detailsCard(
                  //         width: context.screenWidth / 3.4,
                  //         title: 'in your wishlist',
                  //         count: "${data['wishlist_count']}"
                  //     ),
                  //     detailsCard(
                  //         width: context.screenWidth / 3.4,
                  //         title: 'in your orders',
                  //         count: "${data['order_count']}"
                  //     ),
                  //   ],
                  // ),

                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index){
                        return ListTile(
                          onTap: (){
                            switch (index){
                              case 0:
                                Get.to(() => OrderScreen());
                                break;
                              case 1:
                                Get.to(() => WishlistScreen());
                                break;
                              case 2:
                                Get.to(() => AllMessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(profileButtonsIcons[index], width: 22,),
                          title: profileButtonsList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                        );
                      },
                      separatorBuilder: (context, index){
                        return const Divider(color: lightGrey,);
                      },
                      itemCount: profileButtonsList.length
                  ).box.white
                      .rounded.shadowSm.margin(const EdgeInsets.all(12))
                      .padding(const EdgeInsets.symmetric(horizontal: 16)).make().box.color(redColor).make()

                ],
              ),
            );
          }
          }
      )
    ));
  }
}
