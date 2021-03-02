import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/Booking/BookingModel.dart';
import 'package:parenter/Screens/Home/booking/BookingDtailScreen.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PendingBookings extends StatefulWidget {
  final List<BookingModel> bookings;
  PendingBookings(this.bookings);
  @override
  _PendingBookingsState createState() => _PendingBookingsState();
}

class _PendingBookingsState extends State<PendingBookings> {
  ProgressDialog progressDialog;

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Please wait...',
      progressWidget: CircularProgressIndicator(
        backgroundColor: AppColors.appPinkColor,
      ),
    );
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: ListView.builder(
        itemCount: widget.bookings.length,

        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: InkWell(

              child: Card(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
//                            Image(
//                              width: 70,
//                              height: 70,
//                              image: AssetImage(
//                                'resources/images/avatar_placeholder.png',
//                              ),
//                            ),
                              SizedBox(
                                width: 12.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width - 82 ,
                                    child: Text(
                                      Global.userType == UserType.Parent
                                          ? widget.bookings[index].serviceProviderFirstName : widget.bookings[index].parentFirstName ,
                                      style: TextStyle(
                                          fontSize: 16, color: AppColors.textColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    Global.userType == UserType.Parent ?  'Nany'
                                        : Global.spType.index < 2 ? "${widget.bookings[index].childs.length} Children":"${widget.bookings[index].pets.length} Pets" ,
                                    style: TextStyle(
                                      color: AppColors.colorSecondaryText,
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
//                        FlatButton(
//                          onPressed: () {},
//                          color: AppColors.appBottomNabColor,
//                          child: Text(
//                            'Message',
//                            style: TextStyle(color: AppColors.colorWhite),
//                          ),
//                          shape: RoundedRectangleBorder(
//                            borderRadius: BorderRadius.circular(7.0),
//                            side: BorderSide(
//                              width: 0,
//                              style: BorderStyle.none,
//                            ),
//                          ),
//                        ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:[

                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: AppColors.colorPrimaryText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "${widget.bookings[index].bookingDate}",
                                    style:
                                    TextStyle(color: AppColors.colorPrimaryText),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8,),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: AppColors.colorPrimaryText,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${widget.bookings[index].timingsFrom} - ${widget.bookings[index].timingsTo}',
                                    style:
                                    TextStyle(color: AppColors.colorPrimaryText),
                                  ),
                                ],
                              ),
                  ]
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$120',
                                style: TextStyle(
                                    color: AppColors.colorSecondaryText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 28),
                              ),
                              Text(
                                '',
                                style: TextStyle(
                                    color: AppColors.colorSecondaryText,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.5,
                        color: AppColors.colorSecondaryText,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlatButton(
                            onPressed: () {
                              var st = Global.userType == UserType.Parent ? AppStrings.parentCancelled : AppStrings.rejected;
                              this._changeBookingStatus(context, st, widget.bookings[index].id);
                            },
                            color: Colors.transparent,
                            child: Text(
                             Global.userType == UserType.Parent ?  'Cancel' : 'Reject',
                              style:
                                  TextStyle(color: AppColors.appBottomNabColor),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              side: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: AppColors.appBottomNabColor,
                              ),
                            ),
                          ),
                        SizedBox(
                          width: 15.0,
                        ),
                          Global.userType == UserType.Parent
                              ?Container(height: 1,):
                        FlatButton(
                          onPressed: () {
                            this._changeBookingStatus(context, AppStrings.accepted, widget.bookings[index].id);
                          },
                          color: AppColors.appBottomNabColor,
                          child: Text(
                            'Accept',
                            style: TextStyle(color: AppColors.colorWhite),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _changeBookingStatus(BuildContext context,String status,String id) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, String> parameters = Map();
        parameters['bookingID'] = id;
        parameters['status'] = status;
        parameters['statusUpdatedBy'] = Global.userId;

        HTTPManager().changeBookingStatus(id,status,Global.userId).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            showAlertDialog(context, 'Success', response['responseMessage'], false, null);

          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      } else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _changeBookingStatus(context,status,id);
            });
      }
    });
  }


}
