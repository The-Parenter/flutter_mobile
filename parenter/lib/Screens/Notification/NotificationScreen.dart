import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Models/Notifications/NotificationModel.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class NotificationScreen extends StatefulWidget {
  static final routeName = '/NotificationScreen';

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NotificationListModel notificationList = NotificationListModel();
  bool isLoading = false;
  void getAllNotifications() {
    HTTPManager()
        .getAllNotifications(Global.currentUser.id)
        .then((val) {
      this.notificationList = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getAllNotifications();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child: Stack(
          children: [
//            Container(
//              height: 200,
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.only(
//                    bottomRight: Radius.circular(120),
//                    bottomLeft: Radius.circular(120)),
//                color: AppColors.colorLightYellow,
//              ),
//            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Notifications',
                        style:
                        TextStyle(fontSize: 24, color: AppColors.textColor),
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
                    :Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    child: ListView.builder(
                      itemCount: notificationList.notifications.length,
                      itemBuilder: (BuildContext context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 2.0),
                          child: Container(
                            decoration: BoxDecoration(
                            ),
//                            elevation: 0.0,
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(5.0),
//                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal:0.0,vertical: 8),
                              child: Row(
                                children: [
//                                  Image(
//                                    width: 70,
//                                    height: 70,
//                                    image: AssetImage(
//                                      'resources/images/avatar_placeholder.png',
//                                    ),
//                                  ),
                                  SizedBox(
                                    width: 12.0,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:double.infinity,
                                          child: Text(
                                            '${notificationList.notifications[index].notificationBody}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppColors.textColor),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right:8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                '${notificationList.notifications[index].fullName}',
                                                style: TextStyle(
                                                  color: AppColors
                                                      .colorSecondaryText,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                              Text(
                                                '${notificationList.notifications[index].timeDifference}',
                                                style: TextStyle(
                                                  color: AppColors
                                                      .colorSecondaryText,
                                                  fontSize: 16.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Divider(height: 1,color: Colors.grey,)
                                      ],
                                    ),
                                  ),
                                ],
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
          ],
        ),
      ),
    );
  }
}
