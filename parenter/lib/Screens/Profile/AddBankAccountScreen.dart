import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/API/Urls.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddBankAccountScreen extends StatefulWidget {
  static String routeName = '/AddBankAccountScreen';

  @override
  _AddBankAccountScreenState createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog;

  TextEditingController titleController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController institutionController = TextEditingController();

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
                      'Add Bank Account',
                      style:
                      TextStyle(fontSize: 24, color: AppColors.textColor),
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
                        controller: titleController,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Account Title',
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

                        keyboardType: TextInputType.numberWithOptions(signed: true),
                        controller: numberController,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Account Number',
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
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: codeController,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Branch Code',
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
                        controller: institutionController,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Institution Number',
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
                child: AppButton(btnTitle: AppStrings.SAVE),
                onTap: () {
                  _validateAndSendRequest(context);
//                  Navigator.of(context).pushNamedAndRemoveUntil(
//                      BottomTabsScreen.routeName, (route) => false);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _validateAndSendRequest(BuildContext context){
    if (titleController.text.isEmpty || numberController.text.isEmpty || codeController.text.isEmpty || institutionController.text.isEmpty) {
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
      return;
    }
    _sendAddCardRequest(context);
  }

  void _sendAddCardRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();


        parameters['ServiceProviderId'] = Global.currentServiceProvider.id;
        parameters['AccountHolderName'] = this.titleController.text;
        parameters['AccountNumber'] = this.numberController.text;
        parameters['BranchNumber'] = this.codeController.text;
        parameters['InstitutionNumber'] = this.institutionController.text;
        HTTPManager().addPaymentInfo(parameters,ApplicationURLs.ADD_BANK_INFO_URL).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            // var user = UserViewModel.api(response['data']);
            //   Global.currentUser = user;
            showAlertDialog(context, 'Success', response['responseMessage'],false, null,closeMainScreen: true);

          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      } else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendAddCardRequest(context);
            });
      }
    });
  }
}
