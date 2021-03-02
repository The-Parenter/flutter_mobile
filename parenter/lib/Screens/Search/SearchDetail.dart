import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Screens/Search/ComfirmBookingScreen.dart';
import 'package:parenter/Screens/Search/ReviewsScreen.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SearchDetail extends StatefulWidget {
  static final routeName = '/SearchDetail';
  final int searchType;
  SearchDetail(this.searchType);

  @override
  _SearchDetailState createState() => _SearchDetailState();
}

class _SearchDetailState extends State<SearchDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child: Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Global.currentUser.isInFavourite(Global.bookingSP.id,false)
                      ?InkWell(
                    onTap: (){
                      _favouriteRequest(context,true);
                    },
                      child: Icon(Icons.favorite,size: 30,color: AppColors.appPinkColor,)
                  )
                      :
                  InkWell(
                      onTap: (){
                        _favouriteRequest(context,false);
                      },
                      child: Icon(Icons.favorite_border,size: 30,color: AppColors.appPinkColor,)
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  (widget.searchType == 0 || widget.searchType == 2)
                      ?
                    '${Global.bookingSP.getFullName()}':'${Global.bookingSP.businessName}',
                    style: TextStyle(
                        color: AppColors.appBottomNabColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500),
                  ),

                ],
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
                            .pushNamed(ReviewScreen.routeName,arguments: Global.bookingSP.id);
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
                              '${Global.bookingSP.avgRating}',
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
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Timings',
                          style: TextStyle(
                              color: AppColors.colorSecondaryLightText,
                              fontSize: 15),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (widget.searchType == 0 || widget.searchType == 2)
                              ?
                          '${Global.bookingSP.getWorkingTime()}':"Standard Working Hours",
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
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Availability Days',
                      style: TextStyle(
                          color: AppColors.colorSecondaryLightText,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      (widget.searchType == 0 || widget.searchType == 2)
                          ?
                      '${Global.bookingSP.getWorkingDaysTitle()}':'${Global.bookingSP.getWorkingDaysTitle()}',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
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
                          this.widget.searchType == 0 ? '${Global.bookingSP.getExtraServices()}' : '${Global.bookingSP.petCareServiceType}',
                          style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                ),
                    ),
                  )
                   : Row(
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
                          '${Global.bookingSP.postalAddress}',
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
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Detail',
                      style: TextStyle(
                          color: AppColors.colorSecondaryLightText,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${Global.bookingSP.additionalDetails}',
                      style: TextStyle(
                          color: AppColors.textColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),

                    ( this.widget.searchType == 1 || this.widget.searchType == 3)
                        ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                      height: 100,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Global.bookingSP.picturesArray.length,
                          itemBuilder: (BuildContext context, index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 100,
                                child: Image.network(Global.bookingSP.picturesArray[index],fit: BoxFit.fill,),
                              ),
                            );
                          },
                      ),
                    ),
                        ):Container(width: 1,height: 1,),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(ConfirmBookingScreen.routeName,arguments: widget.searchType);
                        },
                        color: AppColors.appBottomNabColor,
                        child: Text(
                          'Book Now',
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
  }

  void _favouriteRequest(BuildContext context,bool isRemove) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['serviceProviderId'] = Global.userId;
        parameters['parentId'] = Global.bookingSP.id;
        HTTPManager().addFavourite(parameters,isRemove).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            if (isRemove) {
              showAlertDialog(
                  context, 'Success', response['responseMessage'], false, null);
                  Global.currentUser.isInFavourite(Global.bookingSP.id, true);
            }else{
              showAlertDialog(
                  context, 'Success', response['responseMessage'], false, null);
              Global.currentUser.favourtiesIds.add(Global.bookingSP.id);

            }
            setState(() {

            });

          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      }else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _favouriteRequest(context,isRemove);
            });
      }
    });
  }
}
