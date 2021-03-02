import 'package:flutter/material.dart';
import 'package:parenter/Screens/Search/ComfirmBookingScreen.dart';
import 'package:parenter/Screens/Search/ReviewsScreen.dart';
import 'package:parenter/common/Constants.dart';

class BookingDetail extends StatefulWidget {
  static final routeName = '/BookingDetail';
  final int searchType = 0;

  @override
  _BookingDetailState createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            //height: 450 + (1.0 * 180.0),
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.keyboard_backspace),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Details',
                        style:
                        TextStyle(fontSize: 18, color: AppColors.textColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Molly Garner',
                  style: TextStyle(
                      color: AppColors.appBottomNabColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500),
                ),

                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ReviewScreen.routeName);
                        },
                        child: Column(
                          children: [
                            Text(
                              'Ratings & Reviews',
                              style: TextStyle(
                                  color: AppColors.colorSecondaryLightText,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              Icon(
                                Icons.star,
                                color: AppColors.appPinkColor,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                '3.4',
                                style: TextStyle(
                                    color: AppColors.appPinkColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),

                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ReviewScreen.routeName);
                        },
                        child: Column(
                          children: [
                            Text(
                              'Booking Date',
                              style: TextStyle(
                                  color: AppColors.colorSecondaryLightText,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [

                              Text(
                                '12-01-2021',
                                style: TextStyle(
                                    color: AppColors.textColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]),

                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Booking Time',
                            style: TextStyle(
                                color: AppColors.colorSecondaryLightText,
                                fontSize: 15),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '18:00 - 22:00',
                            style: TextStyle(
                                color: AppColors.textColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                this.widget.searchType == 0 || this.widget.searchType == 2
                    ?   Container(width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top:1.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          this.widget.searchType == 0 ?  'Extra Services : ':'Care Type : ',
                          style: TextStyle(
                              color: AppColors.colorSecondaryLightText,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          this.widget.searchType == 0 ? 'Cooking, Cleaning' : 'Dog Walker',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    'Address',
                                    style: TextStyle(
                                        color: AppColors.colorSecondaryLightText,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '77 Main St, Toronto, ON M4E 2V6, Canada 77 Main St, Toronto, ON M4E 2V6, Canada',
                                    style: TextStyle(
                                        color: AppColors.textColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                )
                    :  Container(height: 1,),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 225,
                  child:  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Card(
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
//                                  SizedBox(
//                                    width: 12.0,
//                                  ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: AppColors.appPinkColor,
                                              ),
                                              SizedBox(width: 8,),
                                              Text('Special Needs')
                                              
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Martha Adams',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: AppColors.textColor),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    'Daughter',
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
                                                    '4 years old',
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
                                          SizedBox(height: 12,),
                                        Container(
                                          width: double.infinity,
                                          child: Text('Allergies: Peanut butter and cats',style: TextStyle(
                                            color: AppColors
                                                .colorSecondaryText,
                                            fontSize: 12.0,
                                          ),),
                                        ),
                                          SizedBox(height: 12,),
                                          Container(
                                            width: double.infinity,
                                            child: Text('Sleep schedule: Sleeps at noon',style: TextStyle(
                                              color: AppColors
                                                  .colorSecondaryText,
                                              fontSize: 12.0,
                                            ),),
                                          ),
                                          SizedBox(height: 12,),
                                          Container(
                                            width: double.infinity,
                                            child: Text('Food: Milk and Coco',style: TextStyle(
                                              color: AppColors
                                                  .colorSecondaryText,
                                              fontSize: 12.0,
                                            ),),
                                          ),
                                          SizedBox(height: 12,),
                                          Container(
                                            width: double.infinity,
                                            child: Text('Languages: English',style: TextStyle(
                                              color: AppColors
                                                  .colorSecondaryText,
                                              fontSize: 12.0,
                                            ),),
                                          ),
                                          SizedBox(height: 12,),
                                          Container(
                                            width: double.infinity,
                                            child: Text('Additional: She tries to jump from stairs',style: TextStyle(
                                              color: AppColors
                                                  .colorSecondaryText,
                                              fontSize: 12.0,
                                            ),),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 1,
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
