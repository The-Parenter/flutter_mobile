import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Helper/SPManager.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';
import 'package:parenter/Screens/Auth/ForgotPasswordScreen.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Screens/Auth/ServiceProviderSignup.dart';
import 'package:parenter/Screens/Home/BottomTabsScreen.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);
class LoginScreen extends StatefulWidget {
  static String routeName = '/LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProgressDialog progressDialog;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
      //  _currentUser = account;
      });
//      if (_currentUser != null) {
//        _handleGetContact();
//      }
    });
    emailController.text = "";
    passwordController.text = "";
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 48.0),
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
                AppStrings.LOGIN,
                style: Theme.of(context)
                    .textTheme
                    .headline2
                    .copyWith(color: Colors.black),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                AppStrings.LOGIN_OR_SIGNUP,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 24,
              ),
              appTextField(
                'Email',
                Icon(
                  Icons.email,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
                controller: this.emailController,
              ),
              SizedBox(
                height: 24,
              ),
              appTextField(
                  'Password',
                  Icon(
                    Icons.lock_outline,
                    size: 25,
                    color: AppColors.appPinkColor,
                  ),
                  controller: this.passwordController,
                  isPassword: true),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      child: Text(AppStrings.FORGOT_PASSWORD + '?',
                          style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold)),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ForgotPasswordScreen.routeName);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              InkWell(
                child: AppButton(btnTitle: AppStrings.LOGIN),
                onTap: () {
                           //   Navigator.of(context).pushNamedAndRemoveUntil(BottomTabsScreen.routeName, (route) => false);
                 _validateAndSendRequest(context);

                },
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _handleGoogleSignIn();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: Image(
                            image: AssetImage(
                              'resources/images/google.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Center(
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: Image(
                            image: AssetImage(
                              'resources/images/apple.png',
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:16.0),
                    child: Text(
                      AppStrings.DONT_ACCOUNT,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    width: 1,
                  ),
                  InkWell(
                    onTap: () {
                      if (Global.userType == UserType.Parent) {
                        Navigator.of(context)
                            .pushNamed(ParentSignUpScreen.routeName);
                      }else{
                        Navigator.of(context)
                            .pushNamed(ServiceProviderSignupScreen.routeName);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom:16.0),
                      child: Text(
                        AppStrings.CREATE_ACCOUNT,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 12, color: AppColors.appPinkColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48,
              ),
              Text(
                'V01012021',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 12, color: AppColors.appPinkColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToLogin() {
//    if (route == LoginScreen.routeName.routeName) {
//      Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false,
//          arguments: SearchArguments(isFromProfile: false));
//    } else {
    //  }
  }

  void _validateAndSendRequest(BuildContext context){
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showAlertDialog(context,  AppStrings.VALIDATION_FAILED, AppStrings.FORM_FILL_MESSAGE, false, (){});
      return;
    }
    _sendLoginRequest(context);
  }

  void _sendLoginRequest(BuildContext context) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, String> parameters = Map();
        parameters['Email'] = this.emailController.text.toLowerCase();
        parameters['Password'] = this.passwordController.text;
        HTTPManager().authenticateUser(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
          if (response['responseCode'] == "01") {
            if (Global.userType == UserType.Parent) {
              var user = UserViewModel.api(response['data']);
              Global.currentUser = user;
              Global.token = user.token;
              Global.userId = user.id;
            }else{
              var user = ServiceProviderRegisterModel.api(response['data']);
              Global.currentServiceProvider = user;
              Global.token = user.token;
              Global.userId = user.id;
            }

            var manager = SharedPreferenceManager();
            manager.saveUserToken();
            manager.setUserId(Global.userId);
            manager.saveUserType(Global.userType == UserType.Parent);

            Navigator.of(context).pushNamedAndRemoveUntil(
                BottomTabsScreen.routeName, (route) => false);
          } else {
            showAlertDialog(context, 'Error', response['responseMessage'], false, null);
          }
        });
      } else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendLoginRequest(context);
            });
      }
    });
  }
  Future<void> _handleGoogleSignIn() async {
    try {
      var res = await _googleSignIn.signIn();
      print(res.displayName);
    } catch (error) {
      print(error);
    }
  }

}
