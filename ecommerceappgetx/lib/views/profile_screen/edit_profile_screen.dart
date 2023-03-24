import 'dart:io';

import 'package:ecommerceappgetx/common_widgets/bg_widget.dart';
import 'package:ecommerceappgetx/common_widgets/custom_button.dart';
import 'package:ecommerceappgetx/common_widgets/custom_textfield.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/home_controller.dart';
import 'package:ecommerceappgetx/controllers/profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final homeController = Get.put(HomeController());
  final profileController = Get.put(ProfileController());
  final dynamic data;

  EditProfileScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return bgWidget(
      child: Scaffold(
        appBar: AppBar(),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // if data image url and controller path is empty
                data['imageUrl'] == '' && profileController.profileImgPath.isEmpty
                    ? Image.asset(imgProfile2, width: 100,
                  fit:  BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                // if data is not emptybut controller path is empty
                    : data['imageUrl'] != '' && profileController.profileImgPath.isEmpty ?

                    Image.network(data['imageUrl'], width: 100, height: 100, fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                // if both are emtpy
                : Image.file(File(profileController.profileImgPath.value),
                width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                // 10.widthBox,

                10.heightBox,
                CustomButton(
                    titleText: 'Change',
                    buttonColor: redColor,
                    textColor: whiteColor,
                    onPress: (){
                      profileController.changeImage(context);
                    }
                ),
                const Divider(),
                20.heightBox,
                customeTextField(name, nameHint, profileController.nameController),
                10.heightBox,
                customeTextField(oldPassword, passwordHint, profileController.oldpassController),
                10.heightBox,
                customeTextField(newPassword, passwordHint, profileController.newpassController),

                20.heightBox,
                profileController.isLoading.value ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ) : SizedBox(
                  width: context.screenWidth - 60,
                  child: CustomButton(
                      titleText: 'Save',
                      buttonColor: redColor,
                      textColor: whiteColor,
                      onPress: () async{
                        profileController.isLoading(true);

                        // if image is not selected
                        if(profileController.profileImgPath.value.isNotEmpty){
                          await profileController.uploadProfileImage();
                        }else{
                          profileController.profileImageLink = data['imageUrl'];
                        }

                        if(data['password'] == profileController.oldpassController.text){
                          profileController.changeAuthPassword(
                            email: data['email'],
                            password: profileController.oldpassController.text,
                              newpassword : profileController.newpassController.text
                          );

                          await profileController.updateProfile(
                              name: profileController.nameController.text,
                              password: profileController.newpassController.text,
                              imgUrl: profileController.profileImageLink
                          );
                          VxToast.show(context, msg: "Profile Updated");
                        }else{
                          VxToast.show(context, msg: "Wrong old password");
                          profileController.isLoading(false);
                        }
                      }
                  ),
                ),
              ],
            ).box.white.shadowSm.rounded.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50, left: 12, right: 12)).make(),
          ),
        ),
      ),
    );
  }
}
