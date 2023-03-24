import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishList(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.data!.docs.isEmpty){
              return "No item in wishlist".text.color(darkFontGrey).makeCentered();
            }else{
              var data = snapshot.data!.docs;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                        itemBuilder: (context, index){
                        return ListTile(
                          leading: Image.network(data[index]['p_imgs'][0], width: 80, fit: BoxFit.cover,),
                          title: "${data[index]['p_name']}".text.fontFamily(semibold).size(16).make(),
                          subtitle: "${data[index]['p_price']}".numCurrency.text.fontFamily(semibold).color(redColor).make(),
                          trailing: const Icon(Icons.favorite, color: Colors.red,).onTap(() {
                            //FirestoreServices.deleteDocument(data[index].id);
                            firestore.collection(productsCollection).doc(data[index].id).set({
                              'p_wishlist' : FieldValue.arrayRemove([currentUser!.uid])
                            }, SetOptions(merge: true));
                          }),
                        );
                        }
                    ),
                  ),
                ],
              );
            }
          }
      ),
    );
  }
}
