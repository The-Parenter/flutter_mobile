
import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/Payment/CreditCardModel.dart';
import 'package:parenter/Screens/Profile/AddCreditCard.dart';
import 'package:parenter/Screens/Search/SearchDetail.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/ConfirmationPopup.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';
class CreditCardsScreen extends StatefulWidget {
  static String routeName = '/CreditCardsScreen';

  @override
  _CreditCardsScreenState createState() => _CreditCardsScreenState();
}
class _CreditCardsScreenState extends State<CreditCardsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CreditCardListModel creditCards = CreditCardListModel();
  ProgressDialog progressDialog;

  bool isLoading = false;
  void getAllCards() {
    HTTPManager()
        .getAllCards()
        .then((val) {
      this.creditCards = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getAllCards();
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
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
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
                    'Credit Card',
                    style:
                    TextStyle(fontSize: 24, color: AppColors.textColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),

            this.isLoading
                ? Expanded(child: ActivityIndicator())
                :Expanded(
                  child: SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height - 130,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0, right: 16.0),
                          child: ListView.builder(
                            itemCount: this.creditCards.cards.length + 1,

                            itemBuilder: (BuildContext context, index) {
                              return index < creditCards.cards.length ?
                              Dismissible(
                                direction: DismissDirection.endToStart,
                                  confirmDismiss: (DismissDirection direction) async {
                                    return await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm"),
                                          content: const Text("Are you sure you wish to delete this item?"),
                                          actions: <Widget>[
                                            FlatButton(
                                                onPressed: () => Navigator.of(context).pop(true),
                                                child: const Text("Yes")
                                            ),
                                            FlatButton(
                                              onPressed: () => Navigator.of(context).pop(false),
                                              child: const Text("No"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                key: Key(creditCards.cards[index].id),
                               // secondaryBackground: Icon(Icons.delete,color: Colors.red,),
                                background: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                    children:[
                                  Icon(Icons.delete,color: Colors.red,),

                                ]
                                ),
                                child: InkWell(
                                  onTap: (){
                                 //   Navigator.of(context).pushNamed(SearchDetail.routeName);
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Card(
                                      elevation: 0.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 12.0,
                                            ),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children:[
                                                          Row(
                                                            children: [
                                                              Icon(Icons.credit_card,color: AppColors.appPinkColor,size: 30,),
                                                              SizedBox(width: 16,),
                                                              Text('**** **** ${creditCards.cards[index].last4Digits}')
                                                            ],
                                                          ),
                                                          Icon(
                                                            creditCards.cards[index].isActive ? Icons.check_circle_outline :Icons.radio_button_unchecked ,
                                                            color: Colors.green,size: 25,)
                                                        ]
                                                    ),
                                                  ],
                                                ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                onDismissed: (direction){
                                  _deleteCard(creditCards.cards[index].last4Digits);
                                },

                              ):Padding(
                                padding: const EdgeInsets.only(top:16.0),
                                child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(AddCreditCardScreen.routeName);
                                  },
                                    child: AppButton(btnTitle: 'Add Another Card',)
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
              ),
            ),
                ),
          ],
        ),
      ),
    );
  }

  _deleteCard(String digits) async {
    progressDialog.show();
    HTTPManager().removeCardInfo(digits).then((onValue) {
      progressDialog.hide();
      showAlertDialog(context, '', onValue['responseMessage'], false, null);
      this.getAllCards();

    }
    );

  }

//  void _activeCard(BuildContext context,CreditCardModel card) {
//    check().then((internet) {
//      if (internet != null && internet) {
//        progressDialog.show();
//        Map<String, dynamic> parameters = Map();
//
//
//        parameters['ParentId'] = Global.currentUser.id;
//        parameters['Email'] = Global.currentUser.email;
//        parameters['CardNumber'] = card.last4Digits;
//        parameters['ExpiryMonth'] = card.ex;
//        parameters['ExpiryYear'] = int.tryParse(this.yearController.text);
//        parameters['CVC'] = this.cvvController.text;
//
//        HTTPManager().addPaymentInfo(parameters,ApplicationURLs.ADD_CREDIT_CARD_URL).then((onValue) {
//          progressDialog.hide();
//          final response = onValue;
//          if (response['responseCode'] == "01") {
//            // var user = UserViewModel.api(response['data']);
//            //   Global.currentUser = user;
//            showAlertDialog(context, 'Success', response['responseMessage'],false, null,closeMainScreen: true);
//
//          } else {
//            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
//          }
//        });
//      } else {
//        showAlertDialog(context, 'No Internet',
//            'Make sure you are connected to internet.', true, () {
//              Navigator.of(context).pop();
//              _sendAddCardRequest(context);
//            });
//      }
//    });
//  }


}
