import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  var currentNavIndex = 0.obs;
  final isCheck = false.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final retypeController = TextEditingController();

  var searchController = TextEditingController();

  var username = "";

  getUsername() async{
    var n = await firestore.collection(userCollection).where('id', isEqualTo: currentUser!.uid).get().then((value) {
      if(value.docs.isNotEmpty){
        return value.docs.single['name'];
      }
    });
    username = n;
    //print(username);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getUsername();
  }


  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypeController.dispose();
    super.onClose();
  }

}