import 'package:ecommerceappgetx/common_widgets/applogo_widget.dart';
import 'package:ecommerceappgetx/common_widgets/bg_widget.dart';
import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/common_widgets/custom_textfield.dart';
import 'package:ecommerceappgetx/consts/colors.dart';
import 'package:ecommerceappgetx/consts/strings.dart';
import 'package:ecommerceappgetx/consts/styles.dart';
import 'package:ecommerceappgetx/controllers/auth_controller.dart';
import 'package:ecommerceappgetx/controllers/home_controller.dart';
import 'package:ecommerceappgetx/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final homeController = Get.find<HomeController>();
  SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              children: [
                (context.screenHeight * 0.1).heightBox,
                applogoWidget(),
                10.heightBox,
                "Join the $appname".text.fontFamily(bold).white.size(18).make(),
                15.heightBox,

                Obx(
                    () => Column(
                    children: [
                      customeTextField(name, nameHint, homeController.nameController),
                      customeTextField(email, emailHint, homeController.emailController),
                      customeTextField(password, passwordHint, homeController.passwordController),
                      customeTextField(retypePassword, passwordHint, homeController.retypeController),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: (){},
                            child: forgetPass.text.make()
                        ),
                      ),
                      //5.heightBox,

                      Row(
                        children: [
                          Obx(
                          () => Checkbox(
                                checkColor: redColor,
                                value: homeController.isCheck.value,
                                activeColor: Colors.white,
                                onChanged: (newValue){
                                  homeController.isCheck.value = newValue!;
                                }
                            ),
                          ),
                          5.widthBox,
                          Expanded(
                            child: RichText(text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(
                                    fontFamily: regular,
                                    color: fontGrey,
                                  )
                                ),
                                TextSpan(
                                    text: termsAndCond,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )
                                ),
                                TextSpan(
                                    text: " & ",
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: fontGrey,
                                    )
                                ),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                      fontFamily: regular,
                                      color: redColor,
                                    )
                                ),
                              ]
                            )),
                          ),
                        ],
                      ),
                      authController.isLoading.value ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          ) : CustomButton(
                            titleText: signup,
                            buttonColor: homeController.isCheck.value == true ? redColor : lightGrey,
                            textColor: whiteColor,
                            onPress: () async{
                              authController.isLoading(true);
                              if(homeController.isCheck.value != false){
                                try{
                                  authController.signUpMethod(
                                      email: homeController.emailController.text,
                                      password: homeController.passwordController.text
                                  ).then((value) {
                                    authController.storeUserData(
                                        name: homeController.nameController.text,
                                        email: homeController.emailController.text,
                                        password: homeController.passwordController.text
                                    );
                                  }).then((value) {
                                    VxToast.show(context, msg: loggedIn);
                                    Get.offAll(() => Home());
                                  });
                                }catch (e){
                                  authController.isLoading(false);
                                  authController.signOutMethod(context);
                                  VxToast.show(context, msg: e.toString());
                                }
                              }
                            }
                        ).box.rounded.padding(const EdgeInsets.all(16)).width(context.screenWidth - 50).make(),


                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreayHaveAccount.text.color(fontGrey).make(),
                          login.text.color(redColor).make().onTap(() {
                            Get.back();
                          })
                        ],
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
