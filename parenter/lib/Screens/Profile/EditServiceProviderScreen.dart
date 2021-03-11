import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/User/AgeModel.dart';
import 'package:parenter/Models/User/ChildPetViewModel.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/Screens/Auth/ChildCareSignUpScreen.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/AvailabilityWIdget.dart';
import 'package:parenter/Widgets/FormImagePicker.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

class EditServiceProviderScreen extends StatefulWidget {
  static String routeName = '/EditServiceProviderScreen';


  @override
  _EditServiceProviderScreenState createState() => _EditServiceProviderScreenState();
}

class _EditServiceProviderScreenState extends State<EditServiceProviderScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Mode _mode = Mode.overlay;
  ProgressDialog progressDialog;

  int licensRadioValue = 0;
  int ageRadioValue = 0;
  File educationImage;
  File firstAidImage;
  File backGroundImage;

  bool isSpecial = false;
  bool isClean = false;
  bool isCooking = false;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController additionalController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController bNameController = TextEditingController();
  TextEditingController bNumberController = TextEditingController();

  List<String> extraServices = List<String>();
  Map<DateTime,List<String>> selectedDays = Map<DateTime,List<String>>();

  var registerSP = ServiceProviderRegisterModel();
  var spData = ServiceProviderRegisterModel();
  List<PickedFile> files = [];
  CalendarController _calendarcontroller;

  var spIndex = -1;



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

    if (Global.spType == ServiceProviderType.CareGiver){
      spIndex = 0;
      spIndex = 2;
    }else if (Global.spType == ServiceProviderType.PetCare){
      spIndex = 1;
    }else if (Global.spType == ServiceProviderType.DayCare){
      spIndex = 2;
    }else if (Global.spType == ServiceProviderType.Kennel){
      spIndex = 3;
    }


      this.spData = Global.currentServiceProvider;
      setSPData();
      setState(() {
      });
    }
  void setSPData(){
    fNameController.text = spData.firstName;
    lNameController.text = spData.lastName;
    emailController.text = spData.emailAddress;
    phoneController.text = spData.phone;
    addressController.text = spData.postalAddress;
    educationController.text = spData.educationLevel;
    apartmentController.text = spData.apartmentNo;
    experienceController.text = spData.experienceDetail;
    languageController.text = spData.languages;
    bNameController.text = spData.businessName;
    bNumberController.text = spData.businessNumber;

    for (var each in spData.extraServices){
      if (each.toLowerCase().contains("special")){
        this.isSpecial = true;
      }else if (each.toLowerCase().contains("cook")){
        this.isCooking = true;
      }else if (each.toLowerCase().contains("clean")){
        this.isClean = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: '',
      progressWidget: CircularProgressIndicator(
        backgroundColor: AppColors.appPinkColor,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left:16.0),
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
                  'Edit Profile',
                  style:
                  TextStyle(fontSize: 24, color: AppColors.appPinkColor),
                ),
              ],
            ),
          ),
                SizedBox(
                  height: 24,
                ),

                Column(
                  children: spIndex < 2 ?
                  [
                    appTextField(
                        'First Name *',
                        Icon(
                          Icons.person_outline,
                          size: 25,
                          color: AppColors.appPinkColor,
                        ),
                        controller: this.fNameController
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    appTextField(
                        'Last Name *',
                        Icon(
                          Icons.person_outline,
                          size: 25,
                          color: AppColors.appPinkColor,
                        ),
                        controller: this.lNameController

                    ),
                  ]:[   appTextField(
                      'Business Name *',
                      Icon(
                        Icons.person_outline,
                        size: 25,
                        color: AppColors.appPinkColor,
                      ),
                      controller: this.bNameController
                  ),
                    SizedBox(
                      height: 16,
                    ),
                    appTextField(
                        'Business Number *',
                        Icon(
                          Icons.person_outline,
                          size: 25,
                          color: AppColors.appPinkColor,
                        ),
                        controller: this.bNumberController

                    ),],
                ),
                SizedBox(
                  height: 16,
                ),
                appTextField(
                  'Phone Number *',
                  Icon(
                    Icons.phone,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: this.phoneController,
                  keyBoardType: TextInputType.numberWithOptions(),
                  isPhoneFormat:true,


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
                    controller: emailController
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
                      'Address *',
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
                    'Languages Spoken *',
                    Icon(
                      Icons.map,
                      size: 25,
                      color: AppColors.appPinkColor,
                    ),
                    controller: languageController

                ),
                SizedBox(
                  height: 16,
                ),
                appTextField(
                  'Highest level of Education *',
                  Icon(
                    Icons.book,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: this.educationController,
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
                        controller: experienceController,
                        style: TextStyle(fontSize: 12),
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            hintText:
                            "Tell us about your experience as a caregiver *",
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                  ),
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
                this.spIndex == 0 ?
                Padding(
                  padding: const EdgeInsets.only(left:24.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
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
                          padding: const EdgeInsets.only(right:0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.appPinkColor,
                                      value: this.isSpecial, onChanged: (value){
                                    setState(() {
                                      this.isSpecial = value;
                                    });
                                  }),
                                  Text('Special Needs'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.appPinkColor,

                                      value: this.isClean, onChanged: (value){
                                    setState(() {
                                      this.isClean = value;
                                    });
                                  }),
                                  Text('Cleaning'),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                      activeColor: AppColors.appPinkColor,

                                      value: this.isCooking, onChanged: (value){
                                    setState(() {
                                      this.isCooking = value;
                                    });
                                  }),
                                  Text('Cooking'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
                ):Container(height: 1,width: 1,),
                SizedBox(
                  height: 24,
                ),

                    Column(
                      children: spIndex < 2 ? [
                        new Text(
                          '      Your availability?',
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                        AvailabilityWidget((workingDays){
                          registerSP.workingDays = workingDays;
                          print(workingDays[0]);
                        },data: spData.workingDays,),

                      ]
                          :[
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
                          calendarController: _calendarcontroller,
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
                        }),],
                    ),


                SizedBox(
                  height: 24,
                ),
                InkWell(
                    onTap: () {
                      Global.spType = ServiceProviderType.CareGiver;
                      _validateAndSendRequest(context);
//                    Navigator.of(context).pushNamedAndRemoveUntil(
//                        BottomTabsScreen.routeName, (route) => false);

                    },
                    child: AppButton(
                      btnTitle: AppStrings.UPDATE,
                    )),

                SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      licensRadioValue = value;
    });
  }

  void _handleRadioValueChange2(int value) {
    setState(() {
      ageRadioValue = value;
    });
  }


  void _validateAndSendRequest(BuildContext context) async{
    var msg = "";
    if (experienceController.text.isEmpty){ msg = ValidationMessages.experience;}
    if (this.spIndex == 0) {
      if (educationController.text.isEmpty) {
        msg = ValidationMessages.education;
      }
    }
    if (languageController.text.isEmpty){ msg = ValidationMessages.languages;}
    if (addressController.text.isEmpty){ msg = ValidationMessages.address;}
    if (emailController.text.isEmpty){ msg = ValidationMessages.email;}
    if (phoneController.text.isEmpty){ msg = ValidationMessages.phone;}
    if (lNameController.text.isEmpty){ msg = ValidationMessages.lastName;}
    if (fNameController.text.isEmpty){ msg = ValidationMessages.firstName;}

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

    for (var each in registerSP.workingDays){
      if (each.dayName.isNotEmpty){
        if (each.from.isEmpty || each.to.isEmpty){
          showAlertDialog(context,  AppStrings.VALIDATION_FAILED, ValidationMessages.time, false, (){});
          return;
        }
      }
    }
    registerSP.firstName = fNameController.text;
    registerSP.lastName = lNameController.text;
    registerSP.phone = phoneController.text;
    registerSP.emailAddress = emailController.text;
    registerSP.educationLevel = educationController.text;
    registerSP.languages = languageController.text;
    registerSP.experienceDetail = experienceController.text;
    registerSP.additionalDetails = additionalController.text;
    registerSP.apartmentNo = apartmentController.text;
    if (this.isSpecial){
      registerSP.extraServices.add("Special Needs");
    }
    if (this.isCooking){
      registerSP.extraServices.add("Cooking");
    }
    if (this.isClean){
      registerSP.extraServices.add("Cleaning");
    }
    _sendSignUpRequest(context);
  }

  List<Map<String, dynamic>> getWorkingHoursParamDict(){
    var result =  List<Map<String, dynamic>>();
    for (var each in registerSP.workingDays){
      if (each.dayName.isNotEmpty){
        var dict = Map<String, dynamic>();
        dict['Day'] = each.dayName;
        dict['From'] = each.from;
        dict['To'] = each.to; //each.name;
        result.add(dict);
      }
    }
    return result;
  }

  void _sendSignUpRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['ServiceProviderType'] = SEARCH_TYPES[0];
        parameters['FirstName'] = registerSP.firstName;
        parameters['LastName'] = registerSP.lastName;
        parameters['EmailAddress'] = registerSP.emailAddress;
        parameters['PostalAddress'] = registerSP.postalAddress;
        parameters['Phone'] = registerSP.phone;
        parameters['Longitude'] = registerSP.longitude;
        parameters['Latitude'] = registerSP.latitude;
        parameters['LanguagesSpoken'] = registerSP.languages;
        parameters['EducationLevel'] = registerSP.educationLevel;
        parameters['ExperienceDetail'] = registerSP.experienceDetail;
        parameters['AdditionalDetails'] = registerSP.additionalDetails;
        parameters['ListOperationalHours'] = getWorkingHoursParamDict();
        parameters['ExtraServices'] = registerSP.extraServices;
        parameters['ArrPictures'] = [];
        parameters["UnitNo"] = registerSP.apartmentNo;
        HTTPManager().updateSPUser(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            var user = ServiceProviderRegisterModel.api(response['data']);
            Global.currentServiceProvider = user;
            Global.currentServiceProvider = user;
            showAlertDialog(
                context, 'Success', AppStrings.ACCOUNT_BEING_VERIFIED, false, (){

            },closeMainScreen: true);

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
  removeFile(int index) {
    setState(() {
      this.files.removeAt(index);
    });
  }

}
