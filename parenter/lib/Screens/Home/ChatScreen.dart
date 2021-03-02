import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Models/Chat/ConversationViewModel.dart';
import 'package:parenter/Screens/Home/ChatDetailScreen.dart';
import 'package:parenter/Screens/Notification/NotificationScreen.dart';
import 'package:parenter/Screens/Search/SearchScreen.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ConversationListViewModel conversations = ConversationListViewModel();
  bool isLoading = false;
  void getConversations() {
    HTTPManager()
        .getConversations(Global.currentUser.id)
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
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body:  Stack(
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                  color: AppColors.appPinkColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
            ),
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Messages',
                          style:
                              TextStyle(fontSize: 24, color: Colors.white),
                        ),
//                      Row(
//                        children: [
//                          InkWell(
//                            child: Icon(
//                              Icons.search,
//                              size: 30,
//                            ),
//                            onTap: () {
//                              Navigator.of(context)
//                                  .pushNamed(SearchScreen.routeName);
//                            },
//                          ),
//                          SizedBox(
//                            width: 16,
//                          ),
//                          InkWell(
//                            child: Icon(
//                              Icons.open_in_new,
//                              size: 30,
//                            ),
//                            onTap: () {
//                              Navigator.of(context)
//                                  .pushNamed(NotificationScreen.routeName);
//                            },
//                          ),
//                        ],
//                        mainAxisAlignment: MainAxisAlignment.end,
//                      ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  this.isLoading
                      ? Expanded(child: ActivityIndicator())
                      :
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: ListView.builder(
                        itemCount: this.conversations.conversations.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: (){
                              Navigator.of(context).pushNamed(ChatDetailScreen.routeName,arguments: this.conversations.conversations[index]);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Card(
                                elevation: 0.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    children: [
//                                  Image(
//                                    width: 70,
//                                    height: 70,
//                                    image: AssetImage(
//                                      'resources/images/avatar_placeholder.png',
//                                    ),
//                                  ),
//                                  SizedBox(
//                                    width: 12.0,
//                                  ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${this.conversations.conversations[index].recevierUserName}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: AppColors.textColor),
                                                ),
                                                Text(
                                                  '${this.conversations.conversations[index].timeDifference}',
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .colorSecondaryText,
                                                    fontSize: 10.0,
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  '${this.conversations.conversations[index].message}',
                                                  style: TextStyle(
                                                    color: AppColors
                                                        .colorSecondaryText,
                                                    fontSize: 12.0,
                                                  ),
                                                ),

                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
     // ),
    );
  }
}
