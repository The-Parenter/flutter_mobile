import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/Booking/BookingModel.dart';
import 'package:parenter/Screens/Home/booking/BookingDtailScreen.dart';
import 'package:parenter/Screens/Home/booking/TipScreen.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CompletedBookings extends StatefulWidget {
  final List<BookingModel> bookings;
  CompletedBookings(this.bookings);
  @override
  _CompletedBookingsState createState() => _CompletedBookingsState();
}

class _CompletedBookingsState extends State<CompletedBookings> {
  ProgressDialog progressDialog;
  TextEditingController reviewController = TextEditingController();
  double rating = 0;

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
              onTap: (){
              },
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
                                    width: MediaQuery.of(context).size.width - 182 ,
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
//                          Global.userType == UserType.Parent ?
//                          FlatButton(
//                            onPressed: () {},
//                            color: AppColors.appBottomNabColor,
//                            child: Text(
//                              'Message',
//                              style: TextStyle(color: AppColors.colorWhite),
//                            ),
//                            shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(7.0),
//                              side: BorderSide(
//                                width: 0,
//                                style: BorderStyle.none,
//                              ),
//                            ),
//                          ):Container(height: 1,width: 1,),
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
                              _settingModalBottomSheet(context,widget.bookings[index]);
                            },
                            color: AppColors.appBottomNabColor,
                            child: Text(
                              'Rate & Review',
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
                          Global.userType == UserType.Parent ?   Padding(
                            padding: const EdgeInsets.only(left:16.0),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(TipScreen.routeName);
                              },
                              color: AppColors.appBottomNabColor,
                              child: Text(
                                'Pay a Tip',
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
                          ) : Container(width: 0,height: 1,),

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

  void _settingModalBottomSheet(context,BookingModel booking) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext bc) {
          return SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 16.0, bottom: MediaQuery.of(context).viewInsets.bottom + 16),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: new Wrap(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rate & Review',
                          style:
                              TextStyle(color: AppColors.textColor, fontSize: 24.0),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.clear,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20.0,
                          ),
//                      Image(
//                        width: 120,
//                        height: 120,
//                        image: AssetImage(
//                          'resources/images/avatar_placeholder.png',
//                        ),
//                      ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            Global.userType == UserType.Parent
                                ?booking.serviceProviderFirstName : booking.parentFirstName ,

                            style: TextStyle(
                                color: AppColors.appBottomNabColor, fontSize: 24.0),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            Global.userType == UserType.Parent
                                ?booking.extraServices : "",
                            style: TextStyle(
                                color: AppColors.colorSecondaryText,
                                fontSize: 16.0),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          RatingBar.builder(
                            initialRating: 0,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              this.rating = rating;
                              print(rating);
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: reviewController,
                            maxLines: 6,
                            decoration: InputDecoration(
                                border: new OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                filled: true,
                                contentPadding: EdgeInsets.all(10.0),
                                hintText: 'Type your review here',
                                hintStyle: TextStyle(
                                  color: AppColors.colorSecondaryText,
                                ),
                                fillColor: AppColors.appBGColor),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            child: FlatButton(
                              onPressed: () {
                                _validateAndSendRequest(context,booking);
                              },
                              color: AppColors.appBottomNabColor,
                              child: Text(
                                'Rate',
                                style: TextStyle(
                                    color: AppColors.colorWhite, fontSize: 18),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                side: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
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
          );
        });
  }

  void _validateAndSendRequest(BuildContext context,BookingModel booking){
    if (reviewController.text.isEmpty ||  rating == 0) {
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
      return;
    }
    _sendRateRequest(context,booking);
  }
  void _sendRateRequest(BuildContext context,BookingModel booking) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['UserId'] = Global.userId;
        parameters['RatedUserId'] = Global.userType == UserType.Parent ? "${booking.serviceProviderId}":"${booking.parentId}";
        parameters['RatedUserType'] = Global.userType == UserType.Parent ? "ServiceProvider":"Parent";
        parameters['Rating'] = this.rating;
        parameters['Review'] = this.reviewController.text;
        HTTPManager().addReview(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            this.reviewController.text = "";
            this.rating = 0;
            showAlertDialog(context, 'Success', AppStrings.RATING_ADD_MESSAGE, false, (){
              Navigator.of(context).pop();
            });
          } else {
            showAlertDialog(context, 'Error', response['responseMessage'] ?? "An Error has occured", false, null);
          }
        });
      } else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendRateRequest(context,booking);
            });
      }
    });
  }


}
