import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/common_widgets/home_buttons.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/consts/lists.dart';
import 'package:ecommerceappgetx/controllers/home_controller.dart';
import 'package:ecommerceappgetx/services/firestore_services.dart';
import 'package:ecommerceappgetx/views/category_screen/itemDetails.dart';
import 'package:ecommerceappgetx/views/home_screen/components/featured_buttons.dart';
import 'package:ecommerceappgetx/views/home_screen/components/search_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeController = Get.find<HomeController>();

    return Container(
      padding: const EdgeInsets.all(12),
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: TextFormField(
                  controller: homeController.searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if(homeController.searchController.text.isNotEmptyAndNotNull){
                        Get.to(() => SearchScreen(searchData: homeController.searchController.text));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchanything,
                    hintStyle: TextStyle(color: textfieldGrey)
                  ),
                ),
              ),

              // swiper brands

              VxSwiper.builder(
                aspectRatio: 16 / 9,
                  autoPlay: true,
                  height: 150,
                  enlargeCenterPage: true,
                  itemCount: sliderList.length,
                  itemBuilder: (context, index){
                    return Image.asset(
                        sliderList[index],
                      fit: BoxFit.fill,
                    ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                  }
              ),

              10.heightBox,

              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(2, (index) => homeButtons(
                            width: context.screenWidth / 2.5,
                            height: context.screenHeight * 0.15,
                            icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            title: index == 0 ? todayDeal : flashsale,
                            onPress: (){}
                        )
                        ),
                      ),

                      10.heightBox,

                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: secondsliderList.length,
                          itemBuilder: (context, index){
                            return Image.asset(
                              secondsliderList[index],
                              fit: BoxFit.fill,
                            ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                          }
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3, (index) => homeButtons(
                            width: context.screenWidth / 3.4,
                            height: context.screenHeight * 0.15,
                            icon: index == 0 ? icTopCategories : index == 1 ? icBrands : icTopSeller,
                            title: index == 0 ? topCategories : index == 1 ? brand : topSellers,
                            onPress: (){}
                        )
                        ),
                      ),

                      20.heightBox,

                      Align(
                          alignment: Alignment.centerLeft,
                          child: featuredCategories.text.color(darkFontGrey).size(15).fontFamily(semibold).make()
                      ),
                      20.heightBox,
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(3, (index) => Column(
                            children: [
                              featuredButton(title: featuredTitles1[index], icon: featuredImages1[index]),
                              10.heightBox,
                              featuredButton(title: featuredTitles2[index], icon: featuredImages2[index]),
                            ],
                          )).toList(),
                        ),
                      ),

                      20.heightBox,

                      Container(
                        padding: const EdgeInsets.all(12),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: redColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            featuredProduct.text.white.fontFamily(bold).size(18).make(),
                            10.heightBox,

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProducts(),
                                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if(!snapshot.hasData){
                                    return const Center(child: CircularProgressIndicator(),);
                                  }else if(snapshot.data!.docs.isEmpty){
                                    return "No featured product".text.make();
                                  }else{
                                    var featuredProductData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(featuredProductData.length, (index) => Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.network(featuredProductData[index]['p_imgs'][0],height: 150 ,width: 130, fit: BoxFit.cover,),
                                          10.heightBox,
                                          "${featuredProductData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                          10.heightBox,
                                          "${featuredProductData[index]['p_price']}".numCurrency.text.color(redColor).fontFamily(bold).size(16).make(),
                                        ],
                                      ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4))
                                          .roundedSM.padding(const EdgeInsets.all(8))
                                          .make().onTap(() {
                                        Get.to(() => ItemDetails(title: "${featuredProductData[index]['p_name']}", data: featuredProductData[index]));
                                      })),
                                    );
                                  }
                                }
                              ),
                            ),
                          ],
                        ),
                      ),

                      20.heightBox,
                      VxSwiper.builder(
                          aspectRatio: 16 / 9,
                          autoPlay: true,
                          height: 150,
                          enlargeCenterPage: true,
                          itemCount: secondsliderList.length,
                          itemBuilder: (context, index){
                            return Image.asset(
                              secondsliderList[index],
                              fit: BoxFit.fill,
                            ).box.rounded.clip(Clip.antiAlias).margin(const EdgeInsets.symmetric(horizontal: 8)).make();
                          }
                      ),

                      // All Products section

                      20.heightBox,

                      StreamBuilder(
                        stream: FirestoreServices.allProducts(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return const Center(child: CircularProgressIndicator(),);
                          }else{
                            var allProductData = snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allProductData.length,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 8,
                                    crossAxisSpacing: 8,
                                    mainAxisExtent: 300
                                ),
                                itemBuilder: (context, index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(allProductData[index]['p_imgs'][0], width: 200, height: 200, fit: BoxFit.cover,),
                                      const Spacer(),
                                      "${allProductData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                      10.heightBox,
                                      "${allProductData[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                                    ],
                                  ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4))
                                      .roundedSM.padding(const EdgeInsets.all(12))
                                      .make().onTap(() {
                                        Get.to(() => ItemDetails(title: "${allProductData[index]['p_name']}", data: allProductData[index]));
                                  });
                                }
                            );
                          }
                          }
                      )

                    ],
                  ),
                ),
              ),

            ],
          )
      ),
    );
  }
}
