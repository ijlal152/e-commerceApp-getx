import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{

  var isLoading = false.obs;


  Future<UserCredential?> loginMethod({required String email, required String password, context}) async{
    UserCredential? userCredential;
    try{
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      VxToast.show(context, msg: loggedIn);
      Get.offAll(() => Home());
    } on FirebaseAuthException catch (e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Sign Up method

  Future<UserCredential?> signUpMethod({required String email, required String password, context}) async{
    UserCredential? userCredential;
    try{
      await auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // storing data to firestore cloud

  storeUserData({required name, required email, required password}) async{
    DocumentReference store = firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name' : name, 'email' : email,
      'password' : password, 'imageUrl' : '',
      'id' : currentUser!.uid,
      'cart_count' : "00",
      'order_count' : "00",
      'wishlist_count' : "00"
    });
  }

  signOutMethod(context) async{
    try{
      await auth.signOut();
    } catch (e){
      VxToast.show(context, msg: e.toString());
    }
  }

}