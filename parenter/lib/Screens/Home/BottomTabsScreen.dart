import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:parenter/Screens/Auth/HomeScreen.dart';
import 'package:parenter/Screens/Home/ChatScreen.dart';
import 'package:parenter/Screens/Home/InfoScreen.dart';
import 'package:parenter/Screens/Home/MyBookingScreen.dart';
import 'package:parenter/Screens/Notification/NotificationScreen.dart';
import 'package:parenter/Screens/Profile/ProfileScreen.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:parenter/firebase/FirestoreDB.dart';
import 'package:parenter/firebase/TrackRouteModel.dart';

class BottomTabsScreen extends StatefulWidget {
  static final routeName = '/BottomTabsScreen';

  @override
  _BottomTabsScreenState createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentPageIndex = 0;
  List<Widget> widgetsList = List();
  Timer addTimer;

  var curentIndex = 0;
  @override
  void initState() {
    super.initState();
    if (Global.userType == UserType.Parent) {
      widgetsList.add(HomeScreen());
    }else{
      addTimer = Timer.periodic(Duration(seconds: 2), (Timer t) => addRouteToFirebase());
    }
    widgetsList.add(MyBookingScreen());
    widgetsList.add(ChatScreen());
    widgetsList.add(NotificationScreen());
    widgetsList.add(ProfileScreen());
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {

  }

  void addRouteToFirebase() async{
    var route = TrackRouteModel();
    var cloc = await locateUser();

    route.id = Global.currentServiceProvider.id;
    route.serviceProviderId = Global.currentServiceProvider.id;
    route.lat = "${cloc.latitude}";
    route.long = "${cloc.longitude}";
    curentIndex += 1;
    var result = await FirestoreDB.addRoute(route);
    if (result > 0){
      print("added SuccessFully");
    }else{
      print("added Failed");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.colorWhite,
      body: widgetsList[currentPageIndex],
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
            color: AppColors.appBottomNabColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        child: Row(
          children: Global.userType == UserType.Parent ?
          [

            Expanded(
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPageIndex = 0;
                    });
                  }
                },
                child: Container(
                    child: Icon(
                      currentPageIndex == 0 ? Icons.home : Icons.home_outlined,
                      color: Colors.white,
                      size: 30,
                    )
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPageIndex = 1;
                    });
                  }
                },
                child: Container(
                    child: Icon(
                      currentPageIndex == 1 ? Icons.book : Icons.book_outlined,
                      color: Colors.white,
                      size: 30,
                    )
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPageIndex = 2;
                    });
                  }
                },
                child: Container(
                    child: Icon(
                      currentPageIndex == 2 ? Icons.chat_bubble : Icons.chat_bubble_outline,
                      color: Colors.white,
                      size: 30,
                    )
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPageIndex = 3;
                    });
                  }
                },
                child: Container(
                  child: Icon(
                    currentPageIndex == 3 ? Icons.notifications: Icons.notifications_none,
                    color: Colors.white,
                    size: 30,
                  )
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPageIndex = 4;
                    });
                  }
                },
                child: Container(
                    child: Icon(
                      currentPageIndex == 4 ? Icons.person: Icons.person_outline,
                      color: Colors.white,
                      size: 30,
                    )
                ),
              ),
            ),
          ]:[
            _buildBottomNavIcon('resources/images/icon_booking_bordered.png',
                'resources/images/icon_booking_solid.png', 0),
            _buildBottomNavIcon('resources/images/icon_chat_bordered.png',
                'resources/images/icon_chat_solid.png', 1),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPageIndex = 2;
                    });
                  }
                },
                child: Container(
                    child: Icon(
                      currentPageIndex == 2 ? Icons.notifications: Icons.notifications_none,
                      color: Colors.white,
                      size: 30,
                    )
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (mounted) {
                    setState(() {
                      currentPageIndex = 3;
                    });
                  }
                },
                child: Container(
                    child: Icon(
                      currentPageIndex == 3 ? Icons.person: Icons.person_outline,
                      color: Colors.white,
                      size: 30,
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBottomNavIcon(String unselectedImage, String selectedImage, int index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (mounted) {
            setState(() {
              currentPageIndex = index;
            });
          }
        },
        child: Container(
          child: Image(
            width: 20,
            height: 20,
            image: AssetImage(
              currentPageIndex == index ? selectedImage : unselectedImage,
            ),
          ),
        ),
      ),
    );
  }
}
