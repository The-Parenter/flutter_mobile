import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Screens/Auth/ForgotPasswordScreen.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Screens/Auth/ServiceProviderSignup.dart';
import 'package:parenter/Screens/Home/BottomTabsScreen.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ChangePasswordScreen extends StatefulWidget {
  static String routeName = '/ChangePasswordScreen';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController existingController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  ProgressDialog progressDialog;

  bool showExisting = false;
  bool showNew = false;

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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:16.0,left: 12),
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
                      'Change Password',
                      style:
                      TextStyle(fontSize: 24, color: AppColors.textColor),
                    ),
                  ],
                ),
              ),
//              SizedBox(
//                height: 20,
//              ),

//              Container(
//                margin: EdgeInsets.symmetric(horizontal: 20),
//                height: 46,
//                width: double.infinity,
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.all(Radius.circular(23)),
//                ),
//                child: Stack(
//                  children: [
//                    Padding(
//                      padding: const EdgeInsets.symmetric(horizontal:16.0),
//                      child: TextField(
//                        controller: existingController,
//                        obscureText: !showExisting,
//                        cursorColor: AppColors.appPinkColor,
//                        decoration: InputDecoration(
//
//                            contentPadding: EdgeInsets.all(0),
//                            filled: true,
//                            fillColor: Colors.white,
//                            hintText: 'Existing Password',
//                            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
//                            border: OutlineInputBorder(
//                                borderSide: BorderSide.none,
//                                borderRadius: BorderRadius.circular(30))),
//                      ),
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(right:12.0),
//                      child: Align(
//                        alignment: Alignment.centerRight,
//                        child: InkWell(
//                          onTap: (){
//                            setState(() {
//                              showExisting = !showExisting;
//                            });
//                          },
//                          child: Icon(
//                              Icons.remove_red_eye,
//                            color: this.showExisting ? AppColors.appPinkColor : Colors.grey,
//                          ),
//                        ),
//                      ),
//                    ),
//
//                  ],
//                ),
//              ),

              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(23)),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:16.0),
                      child: TextField(
                        controller: newController,
                        obscureText: !showNew,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'New Password',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:12.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              showNew = !showNew;
                            });
                          },
                          child: Icon(
                            Icons.remove_red_eye,
                            color: this.showNew ? AppColors.appPinkColor : Colors.grey,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 46,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(23)),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:16.0),
                      child: TextField(
                        controller: confirmController,
                        obscureText: true,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30))),
                      ),
                    ),


                  ],
                ),
              ),



              SizedBox(
                height: 24,
              ),
              InkWell(
                child: AppButton(btnTitle: AppStrings.UPDATE),
                onTap: () {
                  _validateAndSendRequest(context);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _validateAndSendRequest(BuildContext context){
    if (newController.text.isEmpty || confirmController.text.isEmpty) {
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
      return;
    }

    if (confirmController.text != newController.text){
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.PASSWORD_MISMATCH_MESSAGE, false, (){});
      return;
    }
    _changePasswordRequest(context);
  }

  void _changePasswordRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, String> parameters = Map();
        parameters['EmailAddress'] = Global.userType == UserType.Parent ? Global.currentUser.email:Global.currentServiceProvider.emailAddress;
        parameters['NewPassword'] = this.newController.text;
        HTTPManager().authenticateUser(parameters).then((onValue) {
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
              _changePasswordRequest(context);
            });
      }
    });
  }

}
