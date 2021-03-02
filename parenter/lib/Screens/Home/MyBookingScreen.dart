import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Models/Booking/BookingModel.dart';
import 'package:parenter/Screens/Home/booking/CompletedBookings.dart';
import 'package:parenter/Screens/Home/booking/PendingBookings.dart';
import 'package:parenter/Screens/Home/booking/ScheduledBookings.dart';
import 'package:parenter/Screens/Notification/NotificationScreen.dart';
import 'package:parenter/Screens/Search/SearchScreen.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class MyBookingScreen extends StatefulWidget {
  @override
  _MyBookingScreenState createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TabController _tabController;
  BookingListModel bookingList = BookingListModel();
  bool isLoading = false;
  void getBookings() {
    HTTPManager()
        .getBookings(Global.currentUser.id)
        .then((val) {
      this.bookingList = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }
  @override
  void initState() {
     isLoading = true;
    _tabController = new TabController(length: 3, vsync: this);
     getBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.appBGColor,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'My Bookings',
                      style:
                          TextStyle(fontSize: 24, color: AppColors.textColor),
                    ),
//                    Row(
//                      children: [
//                        InkWell(
//                          child: Icon(
//                            Icons.search,
//                            size: 30,
//                          ),
//                          onTap: () {
//                            Navigator.of(context)
//                                .pushNamed(SearchScreen.routeName);
//                          },
//                        ),
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
//                      ],
//                      mainAxisAlignment: MainAxisAlignment.end,
//                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              this.isLoading
                  ?  Expanded(child: ActivityIndicator())
                  :
              Container(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(right: 40.0, left: 16.0),
                    unselectedLabelColor: AppColors.colorSecondaryText,
                    labelColor: AppColors.appBottomNabColor,
                    labelStyle: TextStyle(
                      fontSize: 19,
                    ),
                    unselectedLabelStyle: TextStyle(fontSize: 16),
                    indicatorColor: Colors.transparent,
                    tabs: [
                      Tab(text: 'Pending'),
                      Tab(
                        text: 'Confirmed',
                      ),
                      Tab(
                        text: 'Completed',
                      )
                    ],
                    controller: _tabController,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    PendingBookings(bookingList.pendingBookings),
                    ScheduledBookings(bookingList.confirmedBookings),
                    CompletedBookings(bookingList.completedBookings),
                  ],
                  controller: _tabController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
