import 'package:ecommerceappgetx/common_widgets/bg_widget.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/consts/lists.dart';
import 'package:ecommerceappgetx/controllers/product_controller.dart';
import 'package:ecommerceappgetx/views/category_screen/category_details.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productController = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: categories.text.fontFamily(bold).white.make(),
          ),
          body: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  shrinkWrap: true,
                    itemCount: 9,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      mainAxisExtent: 200
                    ),
                    itemBuilder: (context, index){
                      return Column(
                        children: [
                          Image.asset(
                              categoryImages[index],
                            height: 120,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          10.heightBox,
                          categoriesList[index].text.color(darkFontGrey).align(TextAlign.center).make()
                        ],
                      ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make().onTap(() {
                        productController.getSubCategories(categoriesList[index]);
                        Get.to(() => CategoryDetails(title: categoriesList[index]));
                      });
                    }
                ),
              )
          ),
        )
    );
  }
}
