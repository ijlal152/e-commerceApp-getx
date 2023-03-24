import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/services/firestore_services.dart';
import 'package:ecommerceappgetx/views/category_screen/itemDetails.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? searchData;
  const SearchScreen({Key? key, required this.searchData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: searchData!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(searchData),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator(),);
          }else if(snapshot.data!.docs.isEmpty){
            return "No product found".text.makeCentered();
          }else{
            var searchedData = snapshot.data!.docs;
            var filteredData = searchedData.where((element) => element['p_name'].toString().toLowerCase().contains(searchData!.toLowerCase())).toList();
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    mainAxisExtent: 300
                  ),
                children: filteredData.mapIndexed((currentValue, index){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(filteredData[index]['p_imgs'][0], width: 200, height: 200, fit: BoxFit.cover,),
                      10.heightBox,
                      "${filteredData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                      5.heightBox,
                      "${filteredData[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make(),
                    ],
                  ).box.white.margin(const EdgeInsets.symmetric(horizontal: 4))
                      .roundedSM.outerShadowMd.padding(const EdgeInsets.all(12))
                      .make().onTap(() {
                    Get.to(() => ItemDetails(title: "${filteredData[index]['p_name']}", data: filteredData[index]));
                  });
                }).toList(),
              ),
            );
          }
          }
      ),
    );
  }
}
