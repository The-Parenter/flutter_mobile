import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/User/AgeModel.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Screens/Home/BottomTabsScreen.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/AvailabilityWIdget.dart';
import 'package:parenter/Widgets/FormImagePicker.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_maps_webservice/places.dart';

import 'ParentSignup.dart';

class DayCare extends StatefulWidget {
  @override
  _DayCareState createState() => _DayCareState();
}

class _DayCareState extends State<DayCare> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Mode _mode = Mode.overlay;
  ProgressDialog progressDialog;
  Map<DateTime,List<String>> selectedDays = Map<DateTime,List<String>>();
  var registerSP = ServiceProviderRegisterModel();

  TextEditingController bNameController = TextEditingController();
  TextEditingController bNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();

  int DayCareRadioValue = 0;
  Map<String, dynamic> parameters = Map();

  List<PickedFile> files = [];
  CalendarController _controller;

  final picker = ImagePicker();


  Widget ageCheckBox(BuildContext context,int index){

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
            activeColor: AppColors.appPinkColor,

            value: DAY_CARE_AGE_CONSTANTS[index].isSelected, onChanged: (value){
          setState(() {
            DAY_CARE_AGE_CONSTANTS[index].isSelected = value;
          });
        }),
        Text('${DAY_CARE_AGE_CONSTANTS[index].title}'),
      ],
    );

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//                Center(
//                  child: Padding(
//                    padding: const EdgeInsets.only(top:0.0),
//                    child: SizedBox(
//                      height: 90,
//                      width: 90,
//                      child: Image(
//                        image: AssetImage(
//                          'resources/images/logo.png',
//                        ),
//                        fit: BoxFit.fill,
//                      ),
//                    ),
//
//                  ),
//                ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  AppStrings.SIGNUP,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.black),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Center(
                child: Text(
                  AppStrings.REGISTER_YOURSELF,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: new Text(
                        'Are you a registered business?',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Radio(
                          activeColor: AppColors.appPinkColor,

                          value: 0,
                          groupValue: DayCareRadioValue,
                          onChanged: _handleDayCareValueChange,
                        ),
                        new Text(
                          'Yes',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          activeColor: AppColors.appPinkColor,

                          value: 1,
                          groupValue: DayCareRadioValue,
                          onChanged: _handleDayCareValueChange,
                        ),
                        new Text(
                          'No',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 8,
              ),
              appTextField(
                'Business Name *',
                Icon(
                  Icons.person_outline,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                controller: bNameController,
              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                'Business Number *',
                Icon(
                  Icons.confirmation_number,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                controller: bNumberController,

              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                'Email Address *',
                Icon(
                  Icons.mail_outline,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                controller: emailController,

              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                'Phone *',
                Icon(
                  Icons.phone,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                keyBoardType: TextInputType.numberWithOptions(),
                controller: phoneController,
                isPhoneFormat:true,


              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                  'Apartment/Unit (Optional)',
                  Icon(
                    Icons.apartment,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: apartmentController
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () async{

                  _handlePressButton();
                },
                child: appTextField(
                    'Postal Address *',
                    Icon(
                      Icons.pin_drop,
                      size: 25,
                      color: AppColors.appPinkColor,
                    ),
                    isEnable: false,
                    controller: this.addressController,
                    keyBoardType: TextInputType.streetAddress
                ),
              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                  'Password *',
                  Icon(
                    Icons.lock_outline,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: passwordController,

                  isPassword: true),
              SizedBox(
                height: 16,
              ),
              appTextField(
                  'Confirm Password *',
                  Icon(
                    Icons.lock_outline,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: confirmController,

                  isPassword: true),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
              appTextField(
                'Languages Spoken *',
                Icon(
                  Icons.map,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                controller: languageController,

              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.appPinkColor, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: TextField(
                      controller: additionalController,
                      style: TextStyle(fontSize: 12),
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Any Additional Information",
                          border: InputBorder.none),
                      maxLines: 8,
                    ),
                  ),
                ),
              ),
              //   SizedBox(height: 8,),
              SizedBox(
                height: 24,
              ),
              new Text(
                '      Please select age groups',
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ageCheckBox(context, 0),
                        ageCheckBox(context, 1),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ageCheckBox(context, 2),
                        ageCheckBox(context, 3),

                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ageCheckBox(context, 4),
                        //ageCheckBox(context, 1),

                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              new Text(
                '      Please Tap on your available days',
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              TableCalendar(
                events: selectedDays ,
                onDaySelected: (date,events,list){
                  setSelectedDates(date);
                },

                startDay: DateTime.now(),
                // endDay: DateTime.now().add(Duration(days: 30)),
                initialCalendarFormat: CalendarFormat.month,
                calendarStyle: CalendarStyle(
                    todayColor: AppColors.appBottomNabColor,
                    selectedColor: AppColors.textColor,
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                        color: Colors.white)),
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
              SizedBox(
                height: 20,
              ),




              new Text(
                '   Add Images',
                textAlign: TextAlign.left,
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              FormImagePicker(files, (index){
                removeFile(index);
              }),
              SizedBox(
                height: 24,
              ),
              InkWell(
                  onTap: () {
                      Global.spType = ServiceProviderType.DayCare;
                      _validateAndSendRequest(context);

//                      Navigator.of(context).pushNamedAndRemoveUntil(
//                          BottomTabsScreen.routeName, (route) => false);
                  },
                  child: AppButton(
                    btnTitle: AppStrings.REGISTER,
                  )),
              SizedBox(
                height: 48,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.ALREADY_HAVE,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(fontSize: 12),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppStrings.SIGNIN,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 12, color: AppColors.appPinkColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }



  void _handleDayCareValueChange(int value) {
    setState(() {
      DayCareRadioValue = value;
    });
  }
  removeFile(int index) {
    setState(() {
      this.files.removeAt(index);
    });
  }
  void _validateAndSendRequest(BuildContext context){
    var msg = "";
    if (languageController.text.isEmpty){ msg = ValidationMessages.languages;}
    if (addressController.text.isEmpty){ msg = ValidationMessages.address;}
    if (confirmController.text.isEmpty){ msg = ValidationMessages.confirmPassword;}
    if (passwordController.text.isEmpty){ msg = ValidationMessages.password;}
    if (emailController.text.isEmpty){ msg = ValidationMessages.email;}
    if (phoneController.text.isEmpty){ msg = ValidationMessages.phone;}
    if (bNameController.text.isEmpty){ msg = ValidationMessages.lastName;}
    if (bNumberController.text.isEmpty){ msg = ValidationMessages.firstName;}

    if (msg.isNotEmpty) {
      showAlertDialog(
          context, AppStrings.VALIDATION_FAILED, msg,
          false, () {});
      return;
    }

    if (!isValidEmail(emailController.text)){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.VALID_EMAIL_MESSAGE, false, (){});
      return;
    }
    if (passwordController.text != confirmController.text){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.PASSWORD_MISMATCH_MESSAGE, false, (){});
      return;
    }



    registerSP.businessName = bNameController.text;
    registerSP.businessNumber = bNumberController.text;
    registerSP.phone = phoneController.text;
    registerSP.emailAddress = emailController.text;
    registerSP.password = passwordController.text;
    registerSP.languages = languageController.text;
    registerSP.additionalDetails = additionalController.text;
    registerSP.apartmentNo = apartmentController.text;


    _sendSignUpRequest(context);
  }

  List<Map<String, dynamic>> getWorkingHoursParamDict(){
    var result =  List<Map<String, dynamic>>();
    for (var each in selectedDays.keys){
      var dict = Map<String, dynamic>();
      dict['SlotDate'] = getDateOnlyFromDate(each);
      result.add(dict);
    }
    return result;
  }
  List<String> getAgeGroupsText(){
    var result =  List<String>();
    for (var each in DAY_CARE_AGE_CONSTANTS){
      if (each.isSelected){
        result.add(each.title);
      }
    }
    return result;
  }

  Future<List<String>> getImagesArray() async{
    var result =  List<String>();
    for (var i = 0; i<files.length; i++){
      await getBase64FromFile(files[i]).then((value) {
        result.add(value);
        if (result.length == files.length){
          parameters['ArrPictures'] = result;
          return result;
        }
      });
    }
  }

  void _sendSignUpRequest(BuildContext context) {
    check().then((internet) async  {
      if (internet != null && internet) {
          progressDialog.show();
        parameters['ServiceProviderType'] = SEARCH_TYPES[1];
        parameters['BusinessName'] = registerSP.businessName;
        parameters['BusinessNumber'] = registerSP.businessNumber;
        parameters['EmailAddress'] = registerSP.emailAddress;
        parameters['PostalAddress'] = registerSP.postalAddress;
        parameters['Password'] = registerSP.password;
        parameters['Phone'] = registerSP.phone;
        parameters['Longitude'] = registerSP.longitude;
        parameters['Latitude'] = registerSP.latitude;
        parameters['LanguagesSpoken'] = registerSP.languages;
        parameters['AdditionalDetails'] = registerSP.additionalDetails;
        parameters['ListOperationalHours'] = getWorkingHoursParamDict();
        parameters['AdditionalDetails'] = registerSP.additionalDetails;
        parameters['Status'] = "Inactive";
        parameters["UnitNo"] = registerSP.apartmentNo;
        parameters["Age"] = this.getAgeGroupsText();

          // getImagesArray().then((value) {
        //   if (value != null) {
          await getImagesArray().then((value) {

        HTTPManager().registerServiceProvider(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            var user = ServiceProviderRegisterModel.api(response['data']);
            Global.currentServiceProvider = user;
            showAlertDialog(
                context, 'Success', AppStrings.ACCOUNT_BEING_VERIFIED, false, (){

            },closeMainScreen: true);
          } else {
            showAlertDialog(
                context, 'Error', response['responseMessage'], false, null);
          }
        });
        });
        //  }
        //  });



      }else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendSignUpRequest(context);
            });
      }
    });
  }

  void setSelectedDates(DateTime selectedDate){
    var dateString = formatDateAndReturnString(selectedDate);

    if (selectedDays[selectedDate] == null){
      selectedDays[selectedDate] = [""];
    }else{
      selectedDays.remove(selectedDate);
    }

    setState(() {

    });
  }



  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "ca")],
    );

    displayPrediction(p);
  }
  void onError(PlacesAutocompleteResponse response) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      var lat = detail.result.geometry.location.lat;
      var long = detail.result.geometry.location.lng;

      var address  =detail.result.formattedAddress;
      registerSP.postalAddress = address;
      registerSP.latitude = '$lat';
      registerSP.longitude = '$long';
      print(lat);
      print(long);
      print(address);

      setState(() {
        addressController.text = address;
      });
    }
  }
}
