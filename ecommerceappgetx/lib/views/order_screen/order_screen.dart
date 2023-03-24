import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/services/firestore_services.dart';
import 'package:ecommerceappgetx/views/order_screen/order_details.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.data!.docs.isEmpty){
            return "You did not order anything yet!".text.color(darkFontGrey).makeCentered();
          }else{
            var data = snapshot.data!.docs;
            return ListView.builder(
              itemCount: data.length,
                itemBuilder: (context, index){
                return ListTile(
                  // onTap: (){
                  //   Get.to(() => OrderDetails(data: data,));
                  // },
                  leading: "${index + 1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                  title: data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                  subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                  trailing: IconButton(onPressed: (){
                    Get.to(() => OrderDetails(data: data[index],));
                  }, icon: const Icon(Icons.arrow_forward_ios_rounded,
                  color: darkFontGrey,)),
                );
                }
            );
          }
          }
      ),
    );
  }
}
