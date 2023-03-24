import 'package:ecommerceappgetx/common_widgets/applogo_widget.dart';
import 'package:ecommerceappgetx/common_widgets/bg_widget.dart';
import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/common_widgets/custom_textfield.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/consts/lists.dart';
import 'package:ecommerceappgetx/controllers/auth_controller.dart';
import 'package:ecommerceappgetx/controllers/home_controller.dart';
import 'package:ecommerceappgetx/views/auth_screen/signup_screen.dart';
import 'package:ecommerceappgetx/views/home_screen/home.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final homeController = Get.find<HomeController>();
    final homeController = Get.put(HomeController());
    final authController = Get.put(AuthController());
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,

                Obx(
                    () => Column(
                    children: [
                      customeTextField(email, emailHint, homeController.emailController),
                      customeTextField(password, passwordHint, homeController.passwordController),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: (){},
                            child: forgetPass.text.make()
                        ),
                      ),
                      //5.heightBox,

                      authController.isLoading.value ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ) : CustomButton(
                          titleText: login,
                          buttonColor: redColor,
                          textColor: whiteColor,
                          onPress: () async{
                            authController.isLoading(true);
                            await authController.loginMethod(
                                email: homeController.emailController.text,
                                password: homeController.passwordController.text,
                              context: context
                            );
                            authController.isLoading(false);
                            // homeController.emailController.clear();
                            // homeController.passwordController.clear();
                            // homeController.emailController.dispose();
                            // homeController.passwordController.dispose();
                            //Get.to(() => Home());
                          }
                      ).box.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 50).make(),

                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),

                      5.heightBox,
                      CustomButton(
                          titleText: signup,
                          buttonColor: lightgolden,
                          textColor: redColor,
                          onPress: (){
                            Get.to(() => SignupScreen());
                          }
                      ).box.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).make(),

                      10.heightBox,
                      loginWith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(3, (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: lightGrey,
                            child: Image.asset(socialIconList[index], width: 30,),
                          ),
                        )),
                      ),
                    ],
                  ).box.white.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 70).shadowSm.make(),
                ),


              ],
            ),
          ),
        )
    );
  }
}
