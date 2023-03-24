import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceappgetx/consts/consts.dart';
import 'package:ecommerceappgetx/controllers/chats_controller.dart';
import 'package:ecommerceappgetx/services/firestore_services.dart';
import 'package:ecommerceappgetx/views/chat_screen/components/sender_bubble.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chatsController = Get.put(ChatsController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "${chatsController.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Obx(
            () =>  chatsController.isLoading.value ? const Center(child: CircularProgressIndicator(),)  : Expanded(child: StreamBuilder(
                stream: FirestoreServices.getChatMessges(chatsController.chatDocid.toString()),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if(!snapshot.hasData){
                      return const Center(child: CircularProgressIndicator(),);
                    }else if(snapshot.data!.docs.isEmpty){
                      return Center(
                        child: "Send a message...".text.color(darkFontGrey).make(),
                      );
                    }else{
                      return ListView(
                        children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                          var data = snapshot.data!.docs[index];
                          return Align(
                            alignment: data['uid'] == currentUser!.uid ? Alignment.centerRight : Alignment.centerLeft,
                              child: senderBubble(data)
                          );
                        }).toList(),
                      );
                    }
                    //return Container();
                  }
              )),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: chatsController.messageController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: textfieldGrey
                        )
                    ),
                    hintText: "Type a message...",
                  ),
                )),
                IconButton(onPressed: (){
                  chatsController.sendMsg(chatsController.messageController.text);
                  chatsController.messageController.clear();
                }, icon: const Icon(Icons.send, color: redColor,))
              ],
            ).box.height(80).margin(EdgeInsets.only(bottom: 8)).padding(const EdgeInsets.all(12)).make(),
          ],
        ),
      ),
    );
  }
}
