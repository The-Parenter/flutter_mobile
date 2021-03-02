 import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/Chat/ConversationViewModel.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/Widgets/ChatBubble.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';


var Sample = ["dagkfhdk","fksjhsafkdhaskdfhksah kshdkfhsakd khaskdfhkasd kksdafhsadkf ", "ksadhjfksadh khsdkfhaksd ioewryiq sdhkafhksad ksdhafk sakdhfasdkh ksahdf as","HEllom","sdkafjhkj 8weyiruyh  kjhasdfk hsnad","ok"];

class ChatDetailScreen extends StatefulWidget {
  static String routeName = '/ChatDetailScreen';

  final ConversationViewModel conversation;
  ChatDetailScreen(this.conversation);
  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {

  TextEditingController messageController = TextEditingController();

  ConversationListViewModel conversations = ConversationListViewModel();
  bool isLoading = false;
  void getConversations() {
    HTTPManager()
        .getAllMessages(this.widget.conversation.recevierUserId)
        .then((val) {
      this.conversations = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getConversations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appPinkColor,
        title: Text("${this.widget.conversation.recevierUserName}"),
      ),
      backgroundColor: AppColors.appBGColor,
      body:this.isLoading
          ?  ActivityIndicator()
          : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
            //  color: Colors.blueAccent,
              height: MediaQuery.of(context).size.height - 190,
              child: ListView.builder(
                itemCount: this.conversations.conversations.length,
                itemBuilder: (BuildContext context, int index){
                  return ChatBubble(message: this.conversations.conversations[index].message,
                      time:this.conversations.conversations[index].createdDate
                      ,delivered: false,isMe: this.conversations.conversations[index].senderUserId == Global.userId);
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 70,
                 // color: Colors.orange,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 60,
                        //color: Colors.white,
                        child: appTextField('Type message here', Icon(Icons.camera_alt,size: 0,),controller: this.messageController),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: InkWell(
                          onTap: (){
                            _validateAndSendRequest(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.appPinkColor,
                              borderRadius: BorderRadius.all(Radius.circular(25))
                            ),
                            //color: Colors.white,
                            child: Center(
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                      
                    ],
                  ),
                )
              ],
            )
          ],

        ),
      ),
    );
  }


  void _validateAndSendRequest(BuildContext context){
    if (messageController.text.isEmpty ) {
      return;
    }
    _sendMessageRequest(context);

  }

  void addNewMessage() {
    var message = this.widget.conversation;
    message.message = this.messageController.text;
    message.date = DateTime.now();
    message.createdDate = "now";
    message.timeDifference = message.calculateTimeDifference();
  this.conversations.conversations.add(message);
  setState(() {

  });
  }

  void _sendMessageRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
       // progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['SenderUserId'] = Global.userId;
        parameters['RecevierUserId'] = this.widget.conversation.recevierUserId;
        parameters['Message'] = this.messageController.text;
        addNewMessage();
        this.messageController.text = "";
        FocusScope.of(context).unfocus();
        HTTPManager().addMessage(parameters).then((onValue) {
          final response = onValue;
          if (response['responseCode'] == "01") {
            this.getConversations();
           // showAlertDialog(context, 'Success', response['responseMessage'],false, null,closeMainScreen: true);
          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      } else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendMessageRequest(context);
            });
      }
    });
  }
}
