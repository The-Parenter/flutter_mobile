import 'package:flutter/material.dart';
import 'package:parenter/Screens/Home/InfoScreen.dart';
import 'package:parenter/Screens/Search/SearchScreen.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.colorWhite,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 190,
              padding: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("resources/images/appbar_background.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 24.0),
                            child: Icon(
                              Icons.info_outline,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(InfoScreen.routeName);
                          },
                        ),
//                        SizedBox(
//                          width: 16,
//                        ),
//                        InkWell(
//                          child: Icon(
//                            Icons.notifications_none,
//                            size: 30,
//                          ),
//                          onTap: () {
//                            Navigator.of(context)
//                                .pushNamed(NotificationScreen.routeName);
//                          },
//                        ),

                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 10.0, bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello,',
                          style: TextStyle(
                              color: AppColors.colorSecondaryText,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          '${Global.currentUser.firstName}',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'What would you like to do today?',
                          style: TextStyle(
                              color: AppColors.colorSecondaryText,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCard('resources/images/icon_girl.png', 'Child Care',
                          AppColors.colorRed, () {}, 0),
                      _buildCard(
                          'resources/images/icon_city.png',
                          'Day Care',
                          AppColors.colorGreen,
                          () {},
                          1),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCard(
                          'resources/images/petCare.png',
                          'Pet Care',
                          Colors.blueAccent,
                          () {},
                          2),
                      _buildCard(
                          'resources/images/icon_kennel.png',
                          'Pet Boarding',
                          AppColors.appBottomNabColor,

                          () {},
                          3),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildCard(
      String image, String title, Color color, Function onClick, int type) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(SearchScreen.routeName, arguments: type);
      },
      child: Column(
        children: [
          Card(

           // color: color,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(35.0),
//            ),
            elevation: 0.0,
            child: Container(
              width: (MediaQuery.of(context).size.width / 2) - 45,
              height: (MediaQuery.of(context).size.width / 2) - 45,
              child: Image(
//                width: 90,
//                height: 90,
                image: AssetImage(
                  image,
                ),
              ),
            ),
          ),
//          SizedBox(
//            height: 10,
//          ),
          Text(
            title,
            style: TextStyle(
                color: AppColors.colorPrimaryText,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
