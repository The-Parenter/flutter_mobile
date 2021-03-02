import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Models/Payment/PaymentModel.dart';
import 'package:parenter/Screens/Search/SearchDetail.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
class PaymentsScreen extends StatefulWidget {
  static String routeName = '/PaymentsScreen';

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}
class _PaymentsScreenState extends State<PaymentsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PaymentListModel paymentList = PaymentListModel();
  bool isLoading = false;
  void getPayments() {
    HTTPManager()
        .getAllPayments(Global.currentUser.id)
        .then((val) {
      this.paymentList = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getPayments();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
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
                    'Payments',
                    style:
                    TextStyle(fontSize: 24, color: AppColors.textColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            this.isLoading
                ? Expanded(child: ActivityIndicator())
                :
            SingleChildScrollView(
              child: Container(
                height: (45.0 + (100 * 2)) + (45.0 + (100 * 2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: ListView.builder(
                          itemCount: paymentList.payments.length,
                          itemBuilder: (BuildContext context, index) {
                            return InkWell(
                              onTap: (){
                                //Navigator.of(context).pushNamed(SearchDetail.routeName);
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
                                                      Global.userType == UserType.Parent
                                                          ?
                                                      '${this.paymentList.payments[index].serviceProviderName}':
                                                     '${this.paymentList.payments[index].parentName}'
                                                         ,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: AppColors.textColor),
                                                    ),
                                                  ]
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children:[
                                                    Row(
                                                      children:[
                                                        Icon(
                                                          Icons.calendar_today_outlined,
                                                          color: Colors.grey,
                                                          size: 16,
                                                        ),
                                                        SizedBox(width: 8,),
                                                        Text(
                                                            '${this.paymentList.payments[index].bookingDate}',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                      ),
                                          ]
                                                    ),
                                                    Row(
                                                        children:[
                                                          Icon(
                                                            Icons.timer_sharp,
                                                            color: Colors.grey,
                                                            size: 16,
                                                          ),
                                                          SizedBox(width: 8,),
                                                          Text(
                                                            '${this.paymentList.payments[index].timingsFrom} - ${this.paymentList.payments[index].timingsTo}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.grey),
                                                          ),
                                                        ]
                                                    ),

                                                  ]
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children:[
                                                    Row(
                                                        children:[
                                                          Icon(
                                                            Icons.miscellaneous_services,
                                                            color: Colors.grey,
                                                            size: 16,
                                                          ),
                                                          SizedBox(width: 8,),
                                                          Text(
                                                            '${this.paymentList.payments[index].getExtraText()}',
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors.grey),
                                                          ),
                                                        ]
                                                    ),
                                                    Row(
                                                        children:[

                                                          Text(
                                                            'CAD ${this.paymentList.payments[index].amount}',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors.grey),
                                                          ),
                                                        ]
                                                    ),
                                                  ]
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
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
