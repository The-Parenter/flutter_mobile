import 'package:flutter/material.dart';
import 'package:parenter/Helper/SPManager.dart';
import 'package:parenter/Screens/Auth/LoginScreen.dart';
import 'package:parenter/Screens/Auth/SplashScreen.dart';
import 'package:parenter/Screens/Profile/BankInfoScreen.dart';
import 'package:parenter/Screens/Profile/ChangePasswordScreen.dart';
import 'package:parenter/Screens/Profile/CreditCards.dart';
import 'package:parenter/Screens/Profile/EditProfileScreen.dart';
import 'package:parenter/Screens/Profile/FamilyInfoScreen.dart';
import 'package:parenter/Screens/Profile/Favorites.dart';
import 'package:parenter/Screens/Profile/PaymentsScreen.dart';
import 'package:parenter/common/Constants.dart';
import 'package:parenter/common/Singelton.dart';

class ProfileScreen extends StatelessWidget {

  Widget _cardWithIconAndText(BuildContext context, Widget icon, String text) {
    return Container(
      height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: 16,
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBGColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                  color: AppColors.appPinkColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50))),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:40.0,horizontal: 16),


              child: Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'My Account',
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(fontSize: 24),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context)
                                .pushNamed(EditProfileScreen.routeName);
                          },
                            child: Text(
                          'Edit Profile',
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(fontSize: 14),
                        )),
                      ]),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            Global.userType == UserType.Parent
                                ? '${Global.currentUser.getFullName()}'
                                :'${Global.currentServiceProvider.getFullName()}' ,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(fontSize: 24, color: Colors.black),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.mail,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                Global.userType == UserType.Parent
                                    ? '${Global.currentUser.email}'
                                    :'${Global.currentServiceProvider.emailAddress}' ,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.grey.shade400,
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                Global.userType == UserType.Parent
                                    ? '${Global.currentUser.phoneNumber}'
                                    :'${Global.currentServiceProvider.phone}' ,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                        fontSize: 12,
                                        color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                 Global.userType == UserType.Parent
                     ?
                 Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context)
                            .pushNamed(FamilyInfoScreenView.routeName);
                      },

                      child: _cardWithIconAndText(
                          context,
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: AppColors.appPinkColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Icon(
                              Icons.group,
                              color: Colors.white,
                            ),

                          ),
                          "View Family Profile"),
                    ),
                  ):Container(height: 20,width: 1,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.of(context)
                                  .pushNamed(ChangePasswordScreen.routeName);
                            },

                            child: _cardWithIconAndText(
                                context,
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.deepOrangeAccent,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                  ),
                                ),
                                "Change Password"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(
                              height: 1,
                              color: AppColors.colorSecondaryText.withAlpha(70),
                            ),
                          ),
                          Global.userType == UserType.Parent
                              ?
                          InkWell(
                            onTap: (){
                              Navigator.of(context)
                                  .pushNamed(FavouritesScreen.routeName);
                            },

                            child: _cardWithIconAndText(
                                context,
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  ),
                                ),
                                "Favorites"),
                          ):Container(height: 1,width: 1,),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(
                              height: 1,
                              color: AppColors.colorSecondaryText.withAlpha(70),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.of(context)
                                  .pushNamed(PaymentsScreen.routeName);
                            },

                            child: _cardWithIconAndText(
                                context,
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: AppColors.appPinkColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Icon(
                                    Icons.monetization_on,
                                    color: Colors.white,
                                  ),


                                ),
                                "Payments"),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(
                              height: 1,
                              color: AppColors.colorSecondaryText.withAlpha(70),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Global.userType == UserType.Parent
                                  ?  Navigator.of(context)
                                  .pushNamed(CreditCardsScreen.routeName):Navigator.of(context)
                                  .pushNamed(BankInfoScreen.routeName);
                            },
                            child: _cardWithIconAndText(
                                context,
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade700,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Icon(
                                    Icons.payment,
                                    color: Colors.white,
                                  ),
                                ),
                                Global.userType == UserType.Parent
                                    ? "Add Credit Cards":"Add Bank Details"),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Divider(
                              height: 1,
                              color: AppColors.colorSecondaryText.withAlpha(70),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              var manager = SharedPreferenceManager();
                              manager.removeValues();
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  SplashScreen.routeName, (route) => false);
                            },
                            child: _cardWithIconAndText(
                                context,
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey.shade700,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                                  child: Icon(
                                    Icons.exit_to_app,
                                    color: Colors.white,
                                  ),
                                ),
                                "Log out"),
                          )

                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
