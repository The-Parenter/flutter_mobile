import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/API/Urls.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddCreditCardScreen extends StatefulWidget {
  static String routeName = '/AddCreditCardScreen';
  @override
  _AddCreditCardScreenState createState() => _AddCreditCardScreenState();
}

class _AddCreditCardScreenState extends State<AddCreditCardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog;
  TextEditingController cardController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();

  TextEditingController cvvController = TextEditingController();

  var month = 0;
  var year = 0;
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
                      'Add Credit Card',
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
                        keyboardType: TextInputType.numberWithOptions(),
                        controller: cardController,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'CardNumber',
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        keyboardType: TextInputType.number,
                        controller: monthController,
                        cursorColor: AppColors.appPinkColor,

                        decoration: InputDecoration(

                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Expiry Month',
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        keyboardType: TextInputType.number,
                        controller: yearController,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Expiry Year',
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
                        controller: cvvController,
                        cursorColor: AppColors.appPinkColor,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'CVC,CVV',
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
    if (cardController.text.isEmpty || monthController.text.isEmpty || yearController.text.isEmpty || cvvController.text.isEmpty) {
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


        parameters['ParentId'] = Global.currentUser.id;
        parameters['Email'] = Global.currentUser.email;
      parameters['CardNumber'] = this.cardController.text;
      parameters['ExpiryMonth'] = int.tryParse(this.monthController.text);
      parameters['ExpiryYear'] = int.tryParse(this.yearController.text);
      parameters['CVC'] = this.cvvController.text;

      HTTPManager().addPaymentInfo(parameters,ApplicationURLs.ADD_CREDIT_CARD_URL).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
           // var user = UserViewModel.api(response['data']);
         //   Global.currentUser = user;
            showAlertDialog(context, 'Credit Card', "Credit Card information has been saved successfully.",false, null,closeMainScreen: true);

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
