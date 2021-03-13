
import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/ServiceProvider/FilterModel.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Screens/Search/MapVIewScreen.dart';
import 'package:parenter/Screens/Search/SearchDetail.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/Widgets/AvailabilityWIdget.dart';
import 'package:parenter/Widgets/FilterSheet.dart';
import 'package:parenter/Widgets/SortSheet.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = '/SearchScreen';
  final int searchType;

  SearchScreen(this.searchType);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController _controller;
  int selectedTab = 0;
  ServiceProviderRegisterListMode providers = ServiceProviderRegisterListMode();
  ProgressDialog progressDialog;


  bool isLoading = false;


  String _getAppbarTitle() {
    if (widget.searchType == 0) {
      return 'Book a Child Care';
    } else if (widget.searchType == 1) {
      return 'Book a Day Care';
    } else if (widget.searchType == 2) {
      return 'Book a Pet Care';
    } else {
      return "Search Pet Boarding";
    }
  }

  String _getSearchHint() {
    if (widget.searchType == 0) {
      return '"ChildCare"';
    } else if (widget.searchType == 1) {
      return '"DayCare"';
    } else if (widget.searchType == 2) {
      return '"PetCare"';
    } else {
      return '"PetBoarding"';
    }
  }

  void getServiceProvider() {
    HTTPManager()
        .getServiceProviderByType(SEARCH_TYPES[widget.searchType])
        .then((val) {
      this.providers = val;

      setState(() {
        this.isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getServiceProvider();
    super.initState();
  }

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
          padding: EdgeInsets.only(top: 10, left: 8.0, right: 8.0),
          child: Column(
            children: [
              Container(
                child: Stack(
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
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        _getAppbarTitle(),
                        style:
                        TextStyle(fontSize: 18, color: AppColors.textColor),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        children: [
                          InkWell(
                            child: Icon(
                              Icons.filter_list,
                            ),
                            onTap: () {
                              _showFilterBottomSheet(context);
                            },
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.swap_vert,
                            ),
                            onTap: () {
                              _showSortBottomSheet(context);
                            },
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.end,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                maxLines: 1,
                decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                    hintText: 'Search ${_getSearchHint()}',
                    hintStyle: TextStyle(
                      color: AppColors.colorSecondaryText,
                    ),
                    fillColor: AppColors.colorWhite),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 0.3,
                color: AppColors.colorSecondaryText,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.colorSecondaryLightText,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: AppColors.colorWhite),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                selectedTab = 0;
                              });
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: selectedTab == 0
                                  ? AppColors.colorSecondaryLightText
                                  : AppColors.colorWhite,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8)),
                            ),
                            child: Center(
                                child: Text(
                                  'List View',
                                  style: TextStyle(
                                      color: selectedTab == 0
                                          ? AppColors.colorWhite
                                          : AppColors.colorSecondaryText,
                                      fontSize: 16),
                                )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(MapScreen.routeName,
                                arguments: widget.searchType);

//                            if (mounted) {
//                              setState(() {
//                                selectedTab = 1;
//                              });
//                            }
                          },
                          child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: selectedTab == 1
                                    ? AppColors.colorSecondaryLightText
                                    : AppColors.colorWhite,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8)),
                              ),
                              child: Center(
                                child: Text(
                                  'Map View',
                                  style: TextStyle(
                                      color: selectedTab == 1
                                          ? AppColors.colorWhite
                                          : AppColors.colorSecondaryText,
                                      fontSize: 16),
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              this.isLoading
                  ? ActivityIndicator()
                  :
              Expanded(
                child: ListView.builder(
                  itemCount: this.providers.values.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        Global.bookingSP = this.providers.values[index];
                        Navigator.of(context).pushNamed(SearchDetail.routeName,
                            arguments: widget.searchType);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Card(
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      widget.searchType == 0 ||
                                          widget.searchType == 2 ?
                                      '${this.providers.values[index]
                                          .getFullName()}' : '${this.providers
                                          .values[index].businessName}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.textColor),
                                    ),

                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text('${this.providers.values[index]
                                            .avgRating}')
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Text(
                                      widget.searchType == 0 ||
                                          widget.searchType == 2
                                          ?
                                      '${this.providers.values[index]
                                          .getWorkingDaysTitle()}'
                                          : "Available Multiple Days",
                                      style: TextStyle(
                                        color: AppColors.colorSecondaryText,
                                        fontSize: 10.0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          color: Colors.black,
                                          size: 15,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          widget.searchType == 0 ||
                                              widget.searchType == 2
                                              ?
                                          '${this.providers.values[index]
                                              .getWorkingTime()}'
                                              : "Standard Working Hours",
                                          style: Theme
                                              .of(context)
                                              .textTheme
                                              .bodyText1
                                              .copyWith(fontSize: 10),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                (this.widget.searchType == 0 ||
                                    this.widget.searchType == 2)
                                    ?
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        this.widget.searchType == 0
                                            ? 'Extra Services : '
                                            : 'Care Type : ',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 16),
                                      ),
                                      Text(
                                        this.widget.searchType == 0 ? '${this
                                            .providers.values[index]
                                            .getExtraServices()}' : '${this
                                            .providers.values[index]
                                            .petCareServiceType}',
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(fontSize: 13),
                                      )
                                    ],
                                  ),
                                ) : Container(height: 1,),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(

            builder: (BuildContext context, StateSetter setState) => BottomFilterSheet(widget.searchType,(filters){
              Navigator.of(context).pop();
              _sendFilterRequest(context,filters);
            })
          );
        });
  }

  void _showSortBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext bc) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) => SortOptionsSheet((sortText){
              Navigator.of(context).pop();
              sortProviders(sortText);
            })
          );
        });
  }

  void sortProviders(String sortText){
    this.providers.sortServiceProviders(sortText);
//    Future.delayed(Duration(seconds: 2)).then((_){
//      isLoading = false;
//      setState((){
//      });
//    });
//    isLoading = true;
    setState((){
    });
  }

  void _sendFilterRequest(BuildContext context,FilterModel filters) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['ServiceType'] = SEARCH_TYPES[this.widget.searchType];
        parameters['PetCareServiceType'] = this.widget.searchType == 2 ? filters.petCareType : null;
        parameters['Day'] = filters.day;
        parameters['TimingsFrom'] = filters.timeFrom;
        parameters['TimingsTo'] = filters.timeT0;
        parameters['ParentLatitude'] = "";
        parameters['ParentLongitude'] = "";
        parameters['Radius'] =  filters.radius;
        HTTPManager().getServiceProviderByFilter(parameters).then((onValue) {
          progressDialog.hide();
          showAlertDialog(context, '', "No Service Provider Found using these filters", false, null);

          if (onValue == null){
            showAlertDialog(context, '', "No Service Provider Found using these filters", false, null);

          }else {
            final response = onValue;
            this.providers = onValue;
            setState(() {

            });
          }
        });
      }else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendFilterRequest(context,filters);
            });
      }
    });
  }

}
  
