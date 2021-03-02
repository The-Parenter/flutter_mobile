import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/GeoCodeManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/Screens/Auth/FamilyInfoScreen.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';


 var kGoogleApiKey =  "AIzaSyBswzNSlJ1rqDncjYmvkOqQTho6NzivfTQ";
class ParentSignUpScreen extends StatefulWidget {
  static String routeName = '/ParentSignUpScreen';

  @override
  _ParentSignUpScreenState createState() => _ParentSignUpScreenState();
}

class _ParentSignUpScreenState extends State<ParentSignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Mode _mode = Mode.overlay;

  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserViewModel registerUser = UserViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.appBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: SizedBox(
                      height: 90,
                      width: 90,
                      child: Image(
                        image: AssetImage(
                          'resources/images/logo.png',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  AppStrings.SIGNUP,
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.black),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  AppStrings.REGISTER_YOURSELF,
                  style: Theme.of(context).textTheme.bodyText2,
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
                  controller: fNameController
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
                  controller: this.lNameController,
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
                  isPhoneFormat:true,
                  keyBoardType: TextInputType.number,
                ),
                SizedBox(
                  height: 16,
                ),
                appTextField(
                  'Email Address *',
                  Icon(
                    Icons.email,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: this.emailController,
                    keyBoardType: TextInputType.emailAddress

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
                SizedBox(
                  height: 8,
                ),
                SizedBox(
                  height: 24,
                ),
                InkWell(
                    onTap: () {
                   //   GeoCodeManager().getLatLongFromAddress(context, 'address');
                      _validateAndSendRequest(context);

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
      ),
    );
  }

  void _validateAndSendRequest(BuildContext context){
    if (fNameController.text.isEmpty || lNameController.text.isEmpty ||
        phoneController.text.isEmpty || emailController.text.isEmpty ||
        passwordController.text.isEmpty ||confirmController.text.isEmpty ||
        addressController.text.isEmpty ) {
      showAlertDialog(context, AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
      return;
    }
    if (!isValidEmail(emailController.text)){
      showAlertDialog(context, AppStrings.VALIDATION_FAILED, AppStrings.VALID_EMAIL_MESSAGE, false, (){});
      return;
    }
    if (passwordController.text != confirmController.text){
      showAlertDialog(context, AppStrings.VALIDATION_FAILED, AppStrings.PASSWORD_MISMATCH_MESSAGE, false, (){});
      return;
    }
    registerUser.firstName = fNameController.text;
    registerUser.lastName = lNameController.text;
    registerUser.phoneNumber = phoneController.text;
    registerUser.email = emailController.text;
    registerUser.password = passwordController.text;
    registerUser.address = addressController.text;

    Navigator.of(context)
        .pushNamed(FamilyInformationScreen.routeName,arguments: registerUser);
  //  _sendSignUpRequest(context);

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
      registerUser.address = address;
      registerUser.latitude = '$lat';
      registerUser.longitude = '$long';
      print(lat);
      print(long);
      print(address);

      setState(() {
        addressController.text = address;
      });
    }
  }
}
