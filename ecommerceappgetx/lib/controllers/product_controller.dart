import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var quantity = 0.obs;
  var subcat = [];
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  getSubCategories(title) async{
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s = decoded.categories.where((element) => element.name ==title).toList();
    //print(s[1]);
    for(var e in s[0].subcategory){
      subcat.add(e);
    }
  }

  changeColorIndex(index){
    colorIndex.value = index;
  }

  increaseQty(totalQty){
    if(quantity.value < totalQty){
      quantity.value ++;
    }
  }
  decreaseQty(){
    if(quantity.value > 0){
      quantity.value --;
    }
  }

  calculateTotalPrice(price){
    totalPrice.value = price * quantity.value;
  }

  // add to cart
addToCart({required title, required img,
  required sellerName, required color,
  required qty, required tPrice, required vendorId,context
}) async{
    await firestore.collection(cartCollection).doc().set({
      'title' : title,
      'img' : img,
      'sellername' : sellerName,
      'color' : color,
      'qty' : qty,
      'vendor_id': vendorId,
      'tPrice' : tPrice,
      'added_by' : currentUser!.uid
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
}

  resetValues(){
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToWishList(docId, context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist' : FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Marked as Favorite");
  }

  removeFromWishList(docId, context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist' : FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from Favorite");
  }

  checkIfFav(data) async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }else{
      isFav(false);
    }
  }

}