import 'package:ecommerceappgetx/common_widgets/exit_dialog.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/home_controller.dart';
import 'package:ecommerceappgetx/views/cart_screen/cart_screen.dart';
import 'package:ecommerceappgetx/views/category_screen/category_screen.dart';
import 'package:ecommerceappgetx/views/home_screen/home_screen.dart';
import 'package:ecommerceappgetx/views/profile_screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // home controller
    final homeController = Get.put(HomeController());
    var navBarItems = [
      BottomNavigationBarItem(icon: Image.asset(icHome, width: 24,) , label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories, width: 24,) , label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart, width: 24,) , label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile, width: 24,) , label: account),
    ];

    var navBody =[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async{
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(() => Expanded(child: navBody.elementAt(homeController.currentNavIndex.value)))
          ],
        ),


        bottomNavigationBar: Obx(() => BottomNavigationBar(
          currentIndex: homeController.currentNavIndex.value,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(
              fontFamily: semibold
          ),
          items: navBarItems,
          type: BottomNavigationBarType.fixed,
          backgroundColor: whiteColor,
          onTap: (value){
            homeController.currentNavIndex.value = value;
          },
        ),)
      ),
    );
  }
}
