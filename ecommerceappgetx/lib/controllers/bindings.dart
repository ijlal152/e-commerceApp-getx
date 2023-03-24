import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/auth_controller.dart';
import 'package:ecommerceappgetx/controllers/home_controller.dart';
import 'package:ecommerceappgetx/controllers/profile_controller.dart';
import 'package:get/get.dart';

class AllBindings implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ProfileController());
  }
}