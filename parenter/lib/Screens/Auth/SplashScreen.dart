import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/SPManager.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/Screens/Auth/HomeScreen.dart';
import 'package:parenter/Screens/Auth/LoginScreen.dart';
import 'package:parenter/Screens/Home/BottomTabsScreen.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showChoice = false;
  bool isLoading = false;


  @override
  void initState() {
    // TODO: implement initState
    isLoading = true;
    super.initState();
    getUserData();
    getSeedData();
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        showChoice = true;
      });
    });
  }

  void hideLoader(){
    isLoading = false;
    setState(() {

    });
  }

  void getUserData()async{
    var token = await SharedPreferenceManager().getUserToken();
    if (token != null && token != ""){
      Global.token = token;
      var id = await SharedPreferenceManager().getUserId();
      {
        Global.userId = id;
        getUserById(id);
      }
    }else{
      hideLoader();
    }
  }

  void getUserById(String id){
    HTTPManager().getUserById(id).then((value) async  {
      var isParent = await SharedPreferenceManager().getUserType();
      {
        final response = value;
        if (response['responseCode'] == "01") {
          if (isParent == true){
            var user = UserViewModel.api(response['data']);
            Global.currentUser = user;
            Global.userType = UserType.Parent;
          }else{

              var user = ServiceProviderRegisterModel.api(response['data']);
              Global.currentServiceProvider = user;
              Global.userType = UserType.ServiceProvider;


          }
          Navigator.of(context).pushNamedAndRemoveUntil(
              BottomTabsScreen.routeName, (route) => false);
        } else {
          hideLoader();
        }



      }
    });
  }

  void getSeedData(){
    HTTPManager().getSeedData().then((value)  {
      Global.seedData = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? ActivityIndicator() :
            Stack
              (children: !showChoice
                ? [Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom:60.0),
                child: SizedBox(
                  height: 300,
                  width: 200,
                  child: Image(
                    image: AssetImage(
                      'resources/images/splash.png',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),]
                :[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom:60.0),
                    child: SizedBox(
                      height: 300,
                      width: 200,
                      child: Image(
                        image: AssetImage(
                          'resources/images/splash.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),


                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Color.fromRGBO(57, 61, 85, 1).withAlpha(230),
                    ),



                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      AppStrings.SELECT_ROLE,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          child: Padding(
                            padding: EdgeInsets.all(32),
                            child: Column(children: [
                              InkWell(
                                onTap: () {
                                  Global.userType = UserType.Parent;
                                  _navigateToLogin();
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image(
                                        image: AssetImage(
                                          'resources/images/parent.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Text(AppStrings.PARENT,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              InkWell(
                                onTap: () {
                                  Global.userType = UserType.ServiceProvider;
                                  _navigateToLogin();
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image(
                                        image: AssetImage(
                                          'resources/images/service.png',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Text(AppStrings.SERVICE_PROVIDER,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        )),
                  ],
                )
              ])

    );
  }

  _navigateToLogin() {
//    if (route == LoginScreen.routeName.routeName) {
//      Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false,
//          arguments: SearchArguments(isFromProfile: false));
//    } else {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    //  }
  }
}
