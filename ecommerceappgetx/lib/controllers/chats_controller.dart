import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/home_controller.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getChatId();
  }

  var chats = firestore.collection(chatsCollection);
  var friendName = Get.arguments[0];
  var friendId = Get.arguments[1];
  var isLoading = false.obs;

  var senderName = Get.find<HomeController>().username;
  var currentID = currentUser!.uid;

  var messageController = TextEditingController();
  dynamic chatDocid;

  getChatId() async{
    isLoading(true);
    await chats.where('users', isEqualTo: {
      friendId : null,
      currentID: null,
    }).limit(1).get().then((QuerySnapshot snapshot) {
      if(snapshot.docs.isNotEmpty){
        chatDocid = snapshot.docs.single.id;
      }else{
        chats.add({
          'created_on': null,
          'last_msg' : '',
          'users' : {friendId: null, currentID: null},
          'toId' : '',
          'formId' : '',
          'friend_name' : friendName,
          'sender_name' : senderName,
        }).then((value){
          chatDocid = value.id;
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg) async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocid).update({
        'created_on' : FieldValue.serverTimestamp(),
        'last_msg' : msg,
        'toId' : friendId,
        'formId' : currentID,
      });

      chats.doc(chatDocid).collection(messagesCollection).doc().set({
        'created_on' : FieldValue.serverTimestamp(),
        'msg' : msg,
        'uid' : currentID,
      });
    }
  }

}