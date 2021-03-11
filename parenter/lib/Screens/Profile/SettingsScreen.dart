
import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/API/Urls.dart';
import 'package:parenter/Helper/SPManager.dart';
import 'package:parenter/Screens/Profile/ChangePasswordScreen.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = '/SettingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool emailNotification = false;
  bool mobileNotification = false;


  @override
  void initState()  {
    // TODO: implement initState

    super.initState();
   this.getNotificationSetting();
  }
  getNotificationSetting()async{
    await SharedPreferenceManager().getNotificationSettings();
    this.emailNotification = SharedPreferenceManager.emailNotification;
    this.mobileNotification = SharedPreferenceManager.mobileNotification;
    setState(() {

    });
  }

  Widget _cardWithIconAndText(BuildContext context, Widget icon, String text,{bool showSwitch = false,bool switchValue = false,Function onChange}) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                icon,
                SizedBox(
                  width: 16,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
            showSwitch ?
            Switch(value: switchValue, onChanged: (value){
              onChange(value);
            },activeColor: AppColors.appPinkColor,):Container(height: 1,width: 1,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body:  Stack(
        children: [
//          Container(
//            height: 230,
//            decoration: BoxDecoration(
//                color: AppColors.appPinkColor,
//                borderRadius: BorderRadius.only(
//                    bottomLeft: Radius.circular(50),
//                    bottomRight: Radius.circular(50))),
//          ),
          Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:16.0,left: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                          Icons.keyboard_backspace
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 0, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Settings',
                        style:
                        TextStyle(fontSize: 24, color: AppColors.appPinkColor),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context)
                        .pushNamed(ChangePasswordScreen.routeName);
                  },

                  child: _cardWithIconAndText(
                      context,
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius:
                            BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.white,
                        ),
                      ),
                      "Change Password"),
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context)
                        .pushNamed(SettingsScreen.routeName);
                  },

                  child: _cardWithIconAndText(
                      context,
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius:
                            BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                      "Email Notifications",showSwitch: true,switchValue: emailNotification,onChange: (value){
                    setState(() {
                      emailNotification = value;
                    });
                    var url = ApplicationURLs.NOTIFICATION_SETTING_URL + Global.userId + "status=" + "${mobileNotification}" + "notificationType=" + "push";
                    HTTPManager().setNotificationsSettings(url);
                  }),
                ),

                InkWell(
                  onTap: (){
                    Navigator.of(context)
                        .pushNamed(SettingsScreen.routeName);
                  },

                  child: _cardWithIconAndText(
                      context,
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius:
                            BorderRadius.all(Radius.circular(8))),
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                      "Mobile Notifications",showSwitch: true,switchValue: mobileNotification,onChange: (value){
                    setState(() {
                      mobileNotification = value;
                    });
                    var url = ApplicationURLs.NOTIFICATION_SETTING_URL + Global.userId + "status=" + "${emailNotification}" + "notificationType=" + "email";
                    HTTPManager().setNotificationsSettings(url).then((value) async{
                      if (value){
                        SharedPreferenceManager.emailNotification = this.emailNotification;
                        SharedPreferenceManager.mobileNotification = this.mobileNotification;
                        await SharedPreferenceManager().saveNotificationSettings();

                      }
                    });
                      }),
                ),

              ],
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
