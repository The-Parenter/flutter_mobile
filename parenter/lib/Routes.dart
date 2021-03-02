import 'package:flutter/material.dart';
import 'package:parenter/Screens/Auth/FamilyInfoScreen.dart';
import 'package:parenter/Screens/Auth/ForgotPasswordScreen.dart';
import 'package:parenter/Screens/Auth/HomeScreen.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Screens/Auth/ServiceProviderSignup.dart';
import 'package:parenter/Screens/Auth/SplashScreen.dart';
import 'package:parenter/Screens/Home/BottomTabsScreen.dart';
import 'package:parenter/Screens/Home/ChatDetailScreen.dart';
import 'package:parenter/Screens/Home/InfoScreen.dart';
import 'package:parenter/Screens/Home/booking/BookingDtailScreen.dart';
import 'package:parenter/Screens/Notification/NotificationScreen.dart';
import 'package:parenter/Screens/Profile/AddBankAccountScreen.dart';
import 'package:parenter/Screens/Profile/AddCreditCard.dart';
import 'package:parenter/Screens/Profile/BankInfoScreen.dart';
import 'package:parenter/Screens/Profile/ChangePasswordScreen.dart';
import 'package:parenter/Screens/Profile/Favorites.dart';
import 'package:parenter/Screens/Profile/PaymentsScreen.dart';
import 'package:parenter/Screens/Search/ComfirmBookingScreen.dart';
import 'package:parenter/Screens/Search/MapVIewScreen.dart';
import 'package:parenter/Screens/Search/SearchDetail.dart';
import 'package:parenter/Screens/Search/SearchScreen.dart';
import 'package:parenter/Screens/Search/TrackScreen.dart';

import 'Screens/Auth/LoginScreen.dart';
import 'Screens/Home/booking/TipScreen.dart';
import 'Screens/Profile/CreditCards.dart';
import 'Screens/Profile/EditProfileScreen.dart';
import 'Screens/Profile/FamilyInfoScreen.dart';
import 'Screens/Search/ReviewsScreen.dart';

//        Route with arguments
/*

  case '/second':
  if(args is String){
    return MaterialPageRoute(builder: (_) => SecondPage(data: args,))
  }

  How to call args route....
  Navigator.of(context).pushNamed('/second',arguments: 'Hello')

 */

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/LoginScreen':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/SplashScreen':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/ForgotPasswordScreen':
        return MaterialPageRoute(builder: (_) => ForgotPasswordScreen());
      case '/ParentSignUpScreen':
        return MaterialPageRoute(builder: (_) => ParentSignUpScreen());
      case '/FamilyInformationScreen':
        return MaterialPageRoute(builder: (_) => FamilyInformationScreen(settings.arguments));
      case '/ServiceProviderSignupScreen':
        return MaterialPageRoute(builder: (_) => ServiceProviderSignupScreen());
      case '/BottomTabsScreen':
        return MaterialPageRoute(builder: (_) => BottomTabsScreen());
      case '/NotificationScreen':
        return MaterialPageRoute(builder: (_) => NotificationScreen());
      case '/SearchScreen':
        return MaterialPageRoute(
            builder: (_) => SearchScreen(settings.arguments));
      case '/SearchDetail':
        return MaterialPageRoute(builder: (_) => SearchDetail(settings.arguments));
      case '/ConfirmBookingScreen':
        return MaterialPageRoute(builder: (_) => ConfirmBookingScreen(settings.arguments));
      case '/InfoScreen':
        return MaterialPageRoute(builder: (_) => InfoScreen());
      case '/FamilyInfoScreenView':
        return MaterialPageRoute(builder: (_) => FamilyInfoScreenView());
      case '/ChangePasswordScreen':
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case '/FavouritesScreen':
       return MaterialPageRoute(builder: (_) => FavouritesScreen());
      case '/PaymentsScreen':
        return MaterialPageRoute(builder: (_) => PaymentsScreen());
      case '/CreditCardsScreen':
        return MaterialPageRoute(builder: (_) => CreditCardsScreen());
      case '/TipScreen':
        return MaterialPageRoute(builder: (_) => TipScreen());
      case '/TrackScreen':
        return MaterialPageRoute(builder: (_) => TrackScreen(args));
      case '/ReviewScreen':
        return MaterialPageRoute(builder: (_) => ReviewScreen(args));
      case '/EditProfileScreen':
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case '/BookingDetail':
        return MaterialPageRoute(builder: (_) => BookingDetail());
      case '/MapScreen':
        return MaterialPageRoute(builder: (_) => MapScreen(args));
      case '/AddCreditCardScreen':
        return MaterialPageRoute(builder: (_) => AddCreditCardScreen());
      case '/BankInfoScreen':
        return MaterialPageRoute(builder: (_) => BankInfoScreen());
      case '/AddBankAccountScreen':
        return MaterialPageRoute(builder: (_) => AddBankAccountScreen());
      case '/ChatDetailScreen':
        return MaterialPageRoute(builder: (_) => ChatDetailScreen(settings.arguments));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Routing Error!'),
        ),
      );
    });
  }
}
