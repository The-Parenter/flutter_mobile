import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/User/ChildPetViewModel.dart';
import 'package:parenter/Widgets/AvailabilityWIdget.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ConfirmBookingScreen extends StatefulWidget {
  static final String routeName = '/ConfirmBookingScreen';
  final int searchType;
  ConfirmBookingScreen(this.searchType);
  @override
  _ConfirmBookingScreenState createState() => _ConfirmBookingScreenState();
}

class _ConfirmBookingScreenState extends State<ConfirmBookingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool childSelected = false;
  CalendarController _controller;
  bool isForPet = false;
  List<ChildPetViewModel> childSource;
  ProgressDialog progressDialog;
  DateTime selectedDate = DateTime.now();
  var timingsFrom = "";
  var timingsTo = "";
  var fromTime = DateTime.now().add(Duration(minutes: 10));
  var toTime = DateTime.now().add(Duration(minutes: 70));
  var isCooking = false;
  var isCleaning = false;
  var isSpecial = false;



  @override
  void initState() {
    super.initState();
    this.isForPet = this.widget.searchType  >= 2;
    this.childSource = isForPet ? Global.currentUser.pets : Global.currentUser.childs;
    _controller = CalendarController();
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
      backgroundColor: AppColors.appBGColor,
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.keyboard_backspace),
                      ),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TableCalendar(
                        onDaySelected: (date,list1,list2){
                          this.selectedDate = date;
                        },
                        startDay: DateTime.now(),
                        endDay: DateTime.now().add(Duration(days: 30)),
                        initialCalendarFormat: CalendarFormat.month,
                        calendarStyle: CalendarStyle(
                            todayColor: AppColors.appPinkColor,
                            selectedColor: AppColors.textColor,
                            todayStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: AppColors.appPinkColor)),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.brown,
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonShowsNext: false,
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        builders: CalendarBuilders(
                          selectedDayBuilder: (context, date, events) =>
                              Container(
                                  margin: const EdgeInsets.all(5.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Text(
                                    date.day.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )),
                          todayDayBuilder: (context, date, events) => Container(
                              margin: const EdgeInsets.all(5.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.appPinkColor,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        calendarController: _controller,
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        color: AppColors.colorWhite,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Timings From',
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),

                                        Container
                                          (
                                            width:150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color: AppColors.appPinkColor,width: 1),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:8.0,bottom: 6.0),
                                              child:  BasicTimeField(true,(value){
                                                final f = new DateFormat('HH:mm');
                                                fromTime = value;
                                                timingsFrom = getTimeOnlyFromDate(value);
                                              }),
                                            )
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Timings To',
                                          style: TextStyle(
                                              color: AppColors.textColor,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container
                                          (
                                            width:150,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color: AppColors.appPinkColor,width: 1),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left:8.0,bottom: 6.0),
                                              child:  BasicTimeField(true,(value){
                                                final f = new DateFormat('HH:mm');
                                                toTime = value;
                                                timingsTo = getTimeOnlyFromDate(value);

                                              }),
                                            )
                                        ),
                                      ],
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height:widget.searchType == 0 ? 20:0,
                              ),

                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children:
                                 widget.searchType == 0 ?
                                 [
                                   Text(
                                     'Select Extra Services',
                                     style: TextStyle(
                                         color: AppColors.textColor, fontSize: 17),
                                   ),
                                   Container(
                                     height: 12,
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(right:8.0),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         Row(
                                           children: [
                                             Checkbox(
                                                 value: isSpecial, onChanged: (value){
                                               setState(() {
                                                 isSpecial = value;
                                               });
                                             }),
                                             Text('Special Needs'),
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Checkbox(
                                                 value: isCleaning, onChanged: (value){
                                               setState(() {
                                                 isCleaning = value;
                                               });
                                             }),
                                             Text('Cleaning'),
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Checkbox(
                                                 value: isCooking, onChanged: (value){
                                                   setState(() {
                                                     isCooking = value;
                                                   });
                                             }),
                                             Text('Cooking'),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 ]:[]
                             ),

                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                widget.searchType <2  ?'Select Child':'Select Pet',
                                style: TextStyle(
                                    color: AppColors.textColor, fontSize: 17),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children:
                                childSource.asMap().entries.map((e) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical:16.0),
                                    child: InkWell(
                                      onTap:(){
                                        setState(() {
                                          e.value.isSelected = !e.value.isSelected;
                                        });
                                        },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              e.value.name,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: AppColors.textColor),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              '${e.value.age} years old',
                                              style: TextStyle(
                                                color: AppColors.colorSecondaryText,
                                                fontSize: 16.0,
                                              ),
                                            )
                                          ],
                                        ),
                                        Icon(
                                           Icons.check_circle ,
                                          color: e.value.isSelected ? Colors.green:Colors.grey,
                                          size: 20,
                                        )
                                      ],
                                ),
                                    ),
                                  );
                                }).toList()
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                width: double.infinity,
                                height: 50,
                                child: FlatButton(
                                  onPressed: () {
                                   _validateAndSendRequest(context);
                                  },
                                  color: AppColors.appBottomNabColor,
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: AppColors.colorWhite,
                                        fontSize: 18),
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
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDoneBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
            child: new Wrap(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Booking Summary',
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 22.0),
                    ),
//                    InkWell(
//                      onTap: () {
//                        Navigator.of(context).pop();
//                      },
//                      child: Icon(
//                        Icons.clear,
//                        size: 30,
//                      ),
//                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.0,
                      ),
                      Image(
                        width: 120,
                        height: 120,
                        image: AssetImage(
                          'resources/images/icon_done.png',
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booking Date',
                            style: TextStyle(
                                color: AppColors.textColor, fontSize: 14),
                          ),
                          Text(
                            '${getDateOnlyFromDate(this.selectedDate)}',
                            style: TextStyle(
                                color: AppColors.colorSecondaryLightText,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.3,
                        color: AppColors.colorSecondaryText,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Booking Time',
                            style: TextStyle(
                                color: AppColors.textColor, fontSize: 14),
                          ),
                          Text(
                            '${this.timingsFrom} - ${this.timingsTo}',
                            style: TextStyle(
                                color: AppColors.colorSecondaryLightText,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.3,
                        color: AppColors.colorSecondaryText,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${SUMMARY_NAMES[widget.searchType]}',
                            style: TextStyle(
                                color: AppColors.textColor, fontSize: 14),
                          ),
                          Text(
                            '${Global.bookingSP.getFullName()}',
                            style: TextStyle(
                                color: AppColors.colorSecondaryLightText,
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.3,
                        color: AppColors.colorSecondaryText,
                      ),
                      Column(
                        children: this.widget.searchType == 0 || this.widget.searchType == 2
                            ? [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                this.widget.searchType == 0 ?  'Extra Services':'Care Type',
                                style: TextStyle(
                                    color: AppColors.textColor, fontSize: 14),
                              ),
                              Text(
                                this.widget.searchType == 0 ? _getExtraServices() : Global.bookingSP.petCareServiceType,
                                style: TextStyle(
                                    color: AppColors.colorSecondaryLightText,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            height: 0.3,
                            color: AppColors.colorSecondaryText,
                          ),
                        ]:[],
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          color: AppColors.appBottomNabColor,
                          child: Text(
                            'Done',
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
          );
        });
  }


  void _validateAndSendRequest(BuildContext context){
    if (this.timingsFrom.isEmpty || this.timingsFrom.isEmpty){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
      return;
    }
    if (this.childSource.length == 0){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, this.isForPet ?AppStrings.ADD_PETS_MESSAGE : AppStrings.ADD_CHILDS_MESSAGE, false, (){});
      return;
    }
    var childAdded = false;
    for (var each in this.childSource){
      if (each.isSelected){
        childAdded = true;
      }
    }
    if (!childAdded){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, this.isForPet ?AppStrings.SELECT_PETS_MESSAGE : AppStrings.SELECT_CHILDS_MESSAGE, false, (){});
      return;
    }

    if (!this.isValidDateTime()){
      return;
    }
    _sendSignUpRequest(context);

  }

  bool isValidDateTime(){
    var result = false;
    var fTime = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,fromTime.hour,fromTime.minute);
    var tTime = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,toTime.hour,toTime.minute);

    if (selectedDate.isAfter(DateTime.now())){
      result = true;
    }else{
      if (fTime.isAfter(DateTime.now().add(Duration(minutes: 10)))){
        result = true;
      }else{
        result = false;
        showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FROM_TIME_ERROR, false, (){});
      }

      if (result){

        if (tTime.isAfter(fTime)){
          result = true;
        }else{
          result = false;
          showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.TO_TIME_ERROR, false, (){});
        }
      }

    }
    return result;
  }

  List<Map<String, dynamic>> getParamDict(List<ChildPetViewModel> list,bool isPet){
    var result =  List<Map<String, dynamic>>();
    if (isPet){
      if (this.isForPet) {
        for (var each in list) {
          var dict = Map<String, dynamic>();
          dict['Name'] = each.name;
          dict['Type'] = each.type;
          dict['Age'] = each.age;
          dict['Gender'] = each.gender;
          result.add(dict);
        }
        return result;
      }
    }
    else{
      if (!this.isForPet) {
        for (var each in list) {
          var dict = Map<String, dynamic>();
          dict['Name'] = each.name;
          dict['Age'] = each.age;
          dict['Gender'] = each.gender; //each.name;
          result.add(dict);
        }
        return result;
      }
    }
  }

  String _getExtraServices(){
    var result = "";
    if (this.isCooking){
      result += "Cooking";
    }
    if (this.isCleaning){
      result += "Cleaning";
    }
    if (this.isSpecial){
      result += "Special Needs";
    }
    return result;
  }

  void _sendSignUpRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['ParentId'] = Global.userId;
        parameters['ServiceProviderId'] = Global.bookingSP.id;
        parameters['BookingDate'] = getDateOnlyFromDate(this.selectedDate);
        parameters['PostalAddress'] = Global.currentUser.address;
        parameters['TimingsFrom'] = this.timingsFrom;
        parameters['TimingsTo'] = this.timingsTo;
      //  parameters['extraServices'] = this._getExtraServices();
        parameters['PetCareServiceType'] = Global.bookingSP.petCareServiceType;
        parameters['ListChildren'] = getParamDict(Global.currentUser.childs,false);
        parameters['ListPets'] =  getParamDict(Global.currentUser.pets,true);
        HTTPManager().addBooking(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            showDoneBottomSheet(context);

          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      }else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendSignUpRequest(context);
            });
      }
    });
  }


}
