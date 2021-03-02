import 'package:flutter/material.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class FamilyInfoScreenView extends StatefulWidget {
  static String routeName = '/FamilyInfoScreenView';

  @override
  _FamilyInfoScreenViewState createState() => _FamilyInfoScreenViewState();
}

class _FamilyInfoScreenViewState extends State<FamilyInfoScreenView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(

        child:
            SingleChildScrollView(
              child: Container(
                height: (90.0 * Global.currentUser.pets.length) + (170.0 * Global.currentUser.childs.length) + 176,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            'Family Profile',
                            style:
                            TextStyle(fontSize: 24, color: AppColors.textColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      //height:  700,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '  Children',
                                style:
                                TextStyle(fontSize: 24, color: AppColors.appPinkColor,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 170.0 * Global.currentUser.childs.length,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                child: ListView.builder(
                                 physics:NeverScrollableScrollPhysics() ,
                                  itemCount: Global.currentUser.childs.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
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
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children:[
                                                        Text(
                                                        '${Global.currentUser.childs[index].name}',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color: AppColors.textColor),
                                                      ),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              '${Global.currentUser.childs[index].gender}',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .colorSecondaryText,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8.0,
                                                            ),
                                                            Container(
                                                              height: 8,
                                                              width: 8,
                                                              decoration: BoxDecoration(
                                                                  color: Colors.grey,
                                                                  borderRadius: BorderRadius.all(Radius.circular(5))
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 8.0,
                                                            ),
                                                            Text(
                                                              '${Global.currentUser.childs[index].age} years Old',
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .colorSecondaryText,
                                                                fontSize: 12.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  ]
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),

                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Allergies :',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),

                                                        Text(
                                                          '${Global.currentUser.childs[index].allergies}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Sleep Schedule :',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),

                                                        Text(
                                                          '${Global.currentUser.childs[index].sleepSchedule}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Foods :',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),

                                                        Text(
                                                          '${Global.currentUser.childs[index].food}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Languages :',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),

                                                        Text(
                                                          '${Global.currentUser.childs[index].language}',
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
                                    );
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '  Pets',
                                style:
                                TextStyle(fontSize: 24, color: AppColors.appPinkColor,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              height: 90.0 * Global.currentUser.pets.length,
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                child: ListView.builder(
                                  itemCount: Global.currentUser.pets.length,

                                  physics:NeverScrollableScrollPhysics() ,

                                  itemBuilder: (BuildContext context, index) {
                                    return Padding(
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
                                              SizedBox(
                                                width: 12.0,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${Global.currentUser.pets[index].name}',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: AppColors.textColor),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          '${Global.currentUser.pets[index].gender} ${Global.currentUser.pets[index].type}',
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .colorSecondaryText,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Container(
                                                          height: 8,
                                                          width: 8,
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey,
                                                              borderRadius: BorderRadius.all(Radius.circular(5))
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8.0,
                                                        ),
                                                        Text(
                                                          '${Global.currentUser.pets[index].age} years old',
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
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),


                  ],
                ),
              ),
            ),
      ),
    );
  }
}
