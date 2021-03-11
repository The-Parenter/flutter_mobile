import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Models/Payment/BankInfoModel.dart';
import 'package:parenter/Screens/Profile/AddBankAccountScreen.dart';
import 'package:parenter/Widgets/ActivityIndicator.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/common/Constants.dart';

class BankInfoScreen extends StatefulWidget {
  static String routeName = '/BankInfoScreen';

  @override
  _BankInfoScreenState createState() => _BankInfoScreenState();
}

class _BankInfoScreenState extends State<BankInfoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BankInfoListModel bankList = BankInfoListModel();
  bool isLoading = false;
  void getConversations() {
    HTTPManager()
        .getAllBanks()
        .then((val) {
      this.bankList = val;
      setState(() {
        this.isLoading = false;
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    this.isLoading = true;
    this.getConversations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                    'Bank Information',
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
                :
            SingleChildScrollView(
              child: Container(
                height: (45.0 + (100 * 2)) + (45.0 + (100 * 2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, right: 16.0),
                        child: ListView.builder(
                          itemCount: this.bankList.banks.length + 1,

                          itemBuilder: (BuildContext context, index) {
                            return index < this.bankList.banks.length ? InkWell(
                              onTap: (){
//                                   Navigator.of(context).pushNamed(SearchDetail.routeName);
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
                                                        Icon(Icons.money,color: AppColors.appPinkColor,size: 30,),
                                                        SizedBox(width: 16,),
                                                        Text('${this.bankList.banks[index].accountNumber}')
                                                      ],
                                                    ),
                                                    Icon(Icons.check_circle_outline,color: Colors.green,size: 25,)
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
                            ):Padding(
                              padding: const EdgeInsets.only(top:16.0),
                              child: InkWell(
                                  onTap: (){
                                    Navigator.of(context).pushNamed(AddBankAccountScreen.routeName);
                                  },
                                  child: AppButton(btnTitle: 'Add Another Bank Account',)
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
          ],
        ),
      ),
    );
  }
}
