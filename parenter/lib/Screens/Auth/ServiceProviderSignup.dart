import 'package:flutter/material.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Screens/Auth/ChildCareSignUpScreen.dart';
import 'package:parenter/Screens/Auth/DayCare.dart';
import 'package:parenter/Screens/Auth/Kennel.dart';
import 'package:parenter/Screens/Auth/PetCare.dart';
import 'package:parenter/common/Constants.dart';


class ServiceProviderSignupScreen extends StatefulWidget {
  static final routeName = "/ServiceProviderSignupScreen";

  @override
  _ServiceProviderSignupScreenState createState() => _ServiceProviderSignupScreenState();
}

class _ServiceProviderSignupScreenState extends State<ServiceProviderSignupScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  int currentIndex = 0;

  void propertyTabFunction(int index) {
    this._controller.animateTo(index);
    //PageController().animateToPage(5,duration: Duration(seconds: 1));
    print(index);
  }

  @override
  void initState() {
    super.initState();
    _controller = new TabController(vsync: this, initialIndex: 0, length: 4);
    _controller.addListener(() {
      currentIndex = _controller.index;
      setState(() {});
    });

    // TODO: implement initState
  }

  @override
  void dispose() {
    super.dispose();
    // TODO: implement dispose
    _controller.dispose();
  }









  @override
  Widget build(BuildContext context) {


    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color:AppColors.appPinkColor,
            ),
          ),
//          backgroundColor: currentIndex == 2
//              ? ColorConstants.darkGreen
//              : ColorConstants.magentaColor,
          title: Text('SignUp'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: false,
          bottom: TabBar(
            controller: this._controller,
            isScrollable: true,
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Child Care',
                 // style: kTabBarTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'Day Care',
                 // style: kTabBarTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'Pet Boarding',
                  //style: kTabBarTextStyle,
                ),
              ),
              Tab(
                child: Text(
                  'Pet Care',
                //  style: kTabBarTextStyle,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: this._controller,
          children: <Widget>[
            ChildCareSignUpScreen((model){
              print(model);
            }),
            DayCare(),
            Kennel(),
            PetCare(),
          ],
        ),
      ),
    );
  }

  void _sendSignUpRequest(BuildContext context) {
//    check().then((internet) {
//      if (internet != null && internet) {
//        progressDialog.show();
//        Map<String, String> parameters = Map();
//        parameters['FirstName'] = this.passwordController.text;
//        parameters['LastName'] = this.passwordController.text;
//        parameters['Email'] = this.passwordController.text;
//        parameters['Password'] = this.passwordController.text;
//
//        parameters['Phone'] = this.emailController.text.toLowerCase();
//        parameters['ChildCount'] = this.passwordController.text;
//        parameters['PetsCount'] = this.passwordController.text;
//        parameters['Longitude'] = this.passwordController.text;
//        parameters['Latitude'] = this.passwordController.text;
//        parameters['ListChildren'] = this.passwordController.text;
//        parameters['ListPets'] = this.passwordController.text;
//
//        HTTPManager().authenticateUser(parameters).then((onValue) {
//          progressDialog.hide();
//          final response = onValue;
//          if (response['responseCode'] == "01") {
//            var user = UserViewModel.api(response['data']);
//            Global.currentUser = user;
////            Navigator.of(context).pushNamedAndRemoveUntil(
////                BottomTabsScreen.routeName, (route) => false);
//          } else {
//            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
//          }
//        });
//      } else {
//        showAlertDialog(context, 'No Internet',
//            'Make sure you are connected to internet.', true, () {
//              Navigator.of(context).pop();
//              _sendSignUpRequest(context);
//            });
//      }
//    });
  }


}
