import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:progress_dialog/progress_dialog.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/ForgotPasswordScreen';

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  ProgressDialog progressDialog;
  TextEditingController emailController = TextEditingController();
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
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
                AppStrings.FORGOT_PASSWORD,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: 220,
                child: Text(
                  AppStrings.ENTER_EMAIL,
                  style: Theme.of(context).textTheme.bodyText2,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 48,
              ),
              appTextField(
                'Email',
                Icon(
                  Icons.email,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                controller: emailController
              ),
              SizedBox(
                height: 32,
              ),
              InkWell(
                onTap: (){
                  if (emailController.text.isEmpty){
                    showAlertDialog(context, AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, null);
                  }else {
                    _forgotPasswordRequest(context);
                  }
                },
                  child: AppButton(btnTitle: AppStrings.SEND)
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _forgotPasswordRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, String> parameters = Map();
        parameters['Email'] = this.emailController.text.toLowerCase();
        HTTPManager().forgotPassword(this.emailController.text.toLowerCase()).then((onValue) {
          if (onValue != false) {
            progressDialog.hide();
            final response = onValue;
            if (response['responseCode'] == "01") {
              showAlertDialog(
                  context, 'Error', response['responseMessage'], false, null);
            } else {
              showAlertDialog(
                  context, 'Error', response['responseMessage'], false, null);
            }
          }else {
            showAlertDialog(
                context, 'Error','An Error has occured', false, null);
          }
        });
      } else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _forgotPasswordRequest(context);
            });
      }
    });
  }

}
