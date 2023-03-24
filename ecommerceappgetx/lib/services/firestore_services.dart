import 'package:ecommerceappgetx/consts/consts.dart';

class FirestoreServices{

  // get user data
  static getuser(uid){
    return firestore.collection(userCollection).where('id', isEqualTo: uid).snapshots();
  }

  // get products according to category

  static getProducts(category){
    return firestore.collection(productsCollection)
        .where('p_category', isEqualTo: category).snapshots();
  }

  static getSubCategoryProduct(title){
    return firestore.collection(productsCollection)
        .where('p_category', isEqualTo: title).snapshots();
  }

  // get cart data
static getCartData(uid){
    return firestore.collection(cartCollection).where('added_by', isEqualTo: uid).snapshots();
}

// delete document
static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
}

static getChatMessges(docId){
    return firestore.collection(chatsCollection).doc(docId).collection(messagesCollection)
        .orderBy('created_on', descending: false).snapshots();
}

static getAllOrders(){
    return firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).snapshots();
}

static getWishList(){
    return firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).snapshots();
}

  static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromId', isEqualTo: currentUser!.uid).snapshots();
  }

  static getCounts() async{
    var res = await Future.wait([
      firestore.collection(cartCollection).where('added_by', isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist', arrayContains: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by', isEqualTo: currentUser!.uid).get().then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }

  static allProducts(){
    return firestore.collection(productsCollection).snapshots();
  }

  static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('is_featured', isEqualTo: true).get();
  }

  static searchProducts(title){
    return firestore.collection(productsCollection).where('p_name', isLessThanOrEqualTo: title).get();
  }


}