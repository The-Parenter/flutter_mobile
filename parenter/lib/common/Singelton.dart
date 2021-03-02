

import 'package:google_sign_in/google_sign_in.dart';
import 'package:parenter/Models/Common/SeedDataModel.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Models/User/UserViewModel.dart';

class Global{

  static SeedValueListMode seedData;

  static UserType userType = UserType.Parent;
  static ServiceProviderType spType = ServiceProviderType.Kennel;

  static ServiceProviderRegisterModel bookingSP;

  static String token = "";
  static String userId = "";

  static UserViewModel currentUser = UserViewModel();
  static ServiceProviderRegisterModel currentServiceProvider = ServiceProviderRegisterModel();

  static GoogleSignIn googleSignIn = GoogleSignIn();

}

enum UserType  {Parent,ServiceProvider}
enum ServiceProviderType  {CareGiver,DayCare,Kennel,PetCare}