import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Helper/SPManager.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Screens/Home/BottomTabsScreen.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/AvailabilityWIdget.dart';
import 'package:parenter/Widgets/ReferenceWidget.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:progress_dialog/progress_dialog.dart';



class ChildCareSignUpScreen extends StatefulWidget {
  final Function onSubmit;
  final bool isUpdate;
  ChildCareSignUpScreen(this.onSubmit,{this.isUpdate = false});

  @override
  _ChildCareSignUpScreenState createState() => _ChildCareSignUpScreenState();
}

class _ChildCareSignUpScreenState extends State<ChildCareSignUpScreen> {
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

  List<String> extraServices = List<String>();
  final picker = ImagePicker();

  var registerSP = ServiceProviderRegisterModel();
  var spData = ServiceProviderRegisterModel();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isUpdate){
      this.spData = Global.currentServiceProvider;
      setSPData();
      setState(() {
      });
    }

    // getUserDetails();
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

  Future getImage(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        if (index == 0) {
          educationImage = File(pickedFile.path);
        } else if (index == 1) {
          firstAidImage = File(pickedFile.path);
        } else {
          backGroundImage = File(pickedFile.path);
        }
        setState(() {});
      } else {
        print('No image selected.');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Please wait \n Uploading of images can take time.',
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
                Column(
              children:!this.widget.isUpdate ? [
                 SizedBox(
               height: 24,
                 ),
            Center(
              child: Text(
                AppStrings.SIGNUP,
                style: Theme
                    .of(context)
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
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyText2,
              ),
            ),

            ]:[],
              ),

              SizedBox(
                height: 24,
              ),
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
              Column(
                children: !this.widget.isUpdate?[
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
                      controller: this.passwordController,

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
                      controller: this.confirmController,
                      isPassword: true),
                ]:[],
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
              ),
              SizedBox(
                height: 24,
              ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: !this.widget.isUpdate?[
                  SizedBox(
                    height: 24,
                  ),
                  new Text(
                    '      First Reference',
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  ReferenceWidget(this.registerSP.refrences[0],(reference){
                    this.registerSP.refrences[0] = reference;
                  }),
                  SizedBox(
                    height: 24,
                  ),
                  new Text(
                    '      Second Reference',
                    textAlign: TextAlign.left,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                  ReferenceWidget(this.registerSP.refrences[1],(reference){
                    this.registerSP.refrences[1] = reference;
                  }),


              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      'Are you 21 or older?',
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          activeColor: AppColors.appPinkColor,
                          groupValue: ageRadioValue,
                          onChanged: _handleRadioValueChange2,
                        ),
                        new Text(
                          'Yes',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          activeColor: AppColors.appPinkColor,

                          value: 1,
                          groupValue: ageRadioValue,
                          onChanged: _handleRadioValueChange2,
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
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      'Do you have a valid driver’s license?',
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.0,
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Radio(
                          activeColor: AppColors.appPinkColor,

                          value: 0,
                          groupValue: licensRadioValue,
                          onChanged: _handleRadioValueChange1,
                        ),
                        new Text(
                          'Yes',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          activeColor: AppColors.appPinkColor,

                          value: 1,
                          groupValue: licensRadioValue,
                          onChanged: _handleRadioValueChange1,
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
              InkWell(
                onTap: () {
                  this.getImage(0);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        'Please attach any educational certificates *',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          child: this.educationImage == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 100,
                                )
                              : Image.file(
                                  this.educationImage,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              InkWell(
                onTap: () {
                  this.getImage(1);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        'Please attach first aid certificate *',
                        textAlign: TextAlign.left,
                        style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          child: this.firstAidImage == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 100,
                                )
                              : Image.file(
                                  this.firstAidImage,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  this.getImage(2);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        child: new Text(
                          'Please attach background check certificate from RCMP *',
                          textAlign: TextAlign.left,
                          style: new TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          child: this.backGroundImage == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 100,
                                )
                              : Image.file(
                                  this.backGroundImage,
                                  fit: BoxFit.contain,
                                ),
                        ),
                      )
                    ],
                  ),
                ),

              ),
                ]:[],
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
    if (educationController.text.isEmpty){ msg = ValidationMessages.education;}
    if (languageController.text.isEmpty){ msg = ValidationMessages.languages;}
    if (addressController.text.isEmpty){ msg = ValidationMessages.address;}
    if (confirmController.text.isEmpty){ msg = ValidationMessages.confirmPassword;}
    if (passwordController.text.isEmpty){ msg = ValidationMessages.password;}
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
    if (passwordController.text != confirmController.text){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.PASSWORD_MISMATCH_MESSAGE, false, (){});
      return;
    }

    if (this.educationImage == null || this.firstAidImage == null || this.backGroundImage == null){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.DOCUMENT_ATTACH_MESSAGE, false, (){});
      return;
    }else{
     await getBase64FromImage(this.educationImage).then((value) {
        registerSP.educationCertificateBase64 = value;
      });
     await getBase64FromImage(this.firstAidImage).then((value) {
        registerSP.firstAidCertificateBase64 = value;
      });
     await getBase64FromImage(this.backGroundImage).then((value) {
        registerSP.backgroundCertificateBase64 = value;
      });
    }

    for (var each in registerSP.refrences){
      if (each.name.isEmpty || each.contact.isEmpty ||
          each.email.isEmpty ) {
        showAlertDialog(context,  AppStrings.VALIDATION_FAILED, ValidationMessages.reference, false, (){});
        return;
      }

      if (!isValidEmail(each.email)){
        showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.VALID_EMAIL_MESSAGE_REFERENCE, false, (){});
        return;
      }
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
    registerSP.password = passwordController.text;
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
    registerSP.isMentionedAge = this.ageRadioValue == 0 ? true : false;
    registerSP.haveValidLicense = this.licensRadioValue == 0 ? true : false;
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

  List<Map<String, dynamic>> getReferencesParamDict(){
    var result =  List<Map<String, dynamic>>();
    for (var each in registerSP.refrences){
        var dict = Map<String, dynamic>();
        dict['name'] = each.name;
        dict['contact'] = each.contact;
        dict['email'] = each.email; //each.name;
        result.add(dict);
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
        parameters['Password'] = registerSP.password;
        parameters['Phone'] = registerSP.phone;
        parameters['Longitude'] = registerSP.longitude;
        parameters['Latitude'] = registerSP.latitude;
        parameters['LanguagesSpoken'] = registerSP.languages;
        parameters['EducationLevel'] = registerSP.educationLevel;
        parameters['ExperienceDetail'] = registerSP.experienceDetail;
        parameters['AdditionalDetails'] = registerSP.additionalDetails;
        parameters['ListOperationalHours'] = getWorkingHoursParamDict();
        parameters['EducationCertificateImg'] = registerSP.educationCertificateBase64;
        parameters['FirstAidCertificateImg'] = registerSP.firstAidCertificateBase64;
        parameters['BackgroundCertificateImg'] = registerSP.backgroundCertificateBase64;
        parameters['IsMentionedAge'] = ageRadioValue == 0 ? true:false;
        parameters['HaveValidLicense'] = licensRadioValue == 0 ? true:false;
        parameters['ExtraServices'] = registerSP.extraServices;
        parameters['arrReferences'] = getReferencesParamDict();
        parameters['ArrPictures'] = [];
        parameters['Status'] = "Inactive";
        parameters["UnitNo"] = registerSP.apartmentNo;



        HTTPManager().registerServiceProvider(parameters).then((onValue) {
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


}
