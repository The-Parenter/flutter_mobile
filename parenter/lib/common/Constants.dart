import 'package:flutter/material.dart';

var BASE_IMAGE_PATH = 'resources/images/';


class ValidationMessages{
  static String firstName = 'Please Enter your first name';
  static String lastName = 'Please Enter your last name';
  static String email = 'Please Enter your email';
  static String phone = 'Please Enter your phone';
  static String password = 'Please Enter your password';
  static String confirmPassword = 'Please confirm your password';
  static String address = 'Please Enter your street address';
  static String education = 'Please Enter your highest education';
  static String languages = 'Please Enter languages you spoke';
  static String experience = 'Please Enter your experience';
  static String time = 'Please Enter start and end time for day you selected';
  static String reference = 'Please Enter complete information for reference';

}

class AppStrings {
  static String SELECT_ROLE = '  Select your Role';
  static String PARENT = 'Parent';
  static String SAVE = 'Save';
  static String SERVICE_PROVIDER = 'Service Provider';
  static String LOGIN = 'Login';
  static String UPDATE = 'Update';
  static String SIGNUP = 'Sign Up';
  static String REGISTER = 'Register';
  static String REGISTER_YOURSELF = 'Register yourself here to continue';
  static String SEND = 'Send';
  static String SUBMIT = 'Submit';
  static String LOGIN_OR_SIGNUP = 'Login or sign up to continue.';
  static String DONT_ACCOUNT = 'Don\'t have an account?';
  static String CREATE_ACCOUNT = 'Sign up';
  static String FORGOT_PASSWORD = 'Forgot Password';
  static String ENTER_EMAIL = 'Enter your email address to reset the password';
  static String ALREADY_HAVE = 'Already have an account?';
  static String SIGNIN = 'Sign in';
  static String CREATE_PROFILE = 'Create Profile';
  static String NO_OF_KIDS = 'No. of Children';
  static String NO_OF_PETS = 'No. of Pets';
  static String ADD_CHILD = 'Add Child';
  static String CHILD_INFO= 'Children';

  static String NAME_OF_CHILD = 'Name of Child';
  static String AGE = 'Age';
  static String Gender = 'Gender';
  static String ADD_PET = 'Add Pet';
  static String PET_INFO = 'Pets';
  static String NAME_OF_Pet = 'Name of Pet';
  static String TYPE_PET = 'Type';

  static String VALIDATION_FAILED = 'Validation Failed';

  static String FORM_FILL_MESSAGE = 'Please fill all the fields';
  static String ADD_CHILDS_MESSAGE = 'Please add children into your profile to add a booking';
  static String ADD_PETS_MESSAGE = 'Please add pets into your profile to add a booking';

  static String SELECT_CHILDS_MESSAGE = 'Please select child to add a booking';
  static String SELECT_PETS_MESSAGE = 'Please select pets  to add a booking';

  static String WRONG_EXPIRE_MESSAGE = 'Please add a valid expiry date. e.g MM/YY';

  static String VALID_EMAIL_MESSAGE = 'Please enter a valid email address';
  static String VALID_EMAIL_MESSAGE_REFERENCE = 'Please enter a valid email address for references';

  static String PASSWORD_MISMATCH_MESSAGE = 'Password and confirm password mismatched';
  static String DOCUMENT_ATTACH_MESSAGE = 'Please attach required documents';
  static String RATING_ADD_MESSAGE = 'Rating Added Successfully';
  static String ACCOUNT_BEING_VERIFIED = 'Thank you for signing up with The Parenter. We will review your details and send a confirmation email once your profile has been approved.';



  static String pending = 'Pending';
  static String accepted = 'Accepted';
  static String rejected = 'Rejected';
  static String completed = 'Completed';
  static String parentNoShow = 'ParentNoShow';
  static String serviceProviderNoShow = 'ServiceProviderNoShow';
  static String serviceProviderCancelled = 'ServiceProviderCancelled';
  static String parentCancelled = 'ParentCancelled';

}

class AppColors {
  static Color appBGColor = Color.fromRGBO(242, 244, 246, 1);
  static Color appPinkColor = Color.fromRGBO(215, 40, 82, 1);
  static Color textColor = Colors.black;
  static Color appBottomNabColor = Color(0xFFF4275B);
  static Color colorWhite = Color(0xFFFFFFFF);
  static Color colorSecondaryText = Color(0xFF6D7EA9);
  static Color colorSecondaryLightText = Color(0xFFA1AABD);
  static Color colorYellow = Color(0xFFC8A351);
  static Color colorGreen = Color(0xFF0FB587);
  static Color colorRed = Color(0xFFFD6858);
  static Color colorPrimaryText = Color(0xFF141B37);
  static Color colorLightYellow = Color(0xFFFABB5B);
  static Color chatGrayColor = Color(0xFFA1AABF);
}




var SEARCH_TYPES = ["ChildCare","DayCare","PetCare","PetBoarding"];

var SAMPLE_NAMES = ["Ms.Molly Garner","MotherHood Day Care","Adam Sandlers","Pup House"];

var daysName = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
var sortOptions = ["High To Low","Low To High"];


var destinationPoint = [43.71367770507242, -79.78010814607761];

var routePoints = [[43.70941383801247, -79.7902468267519],
  [43.709689221917934, -79.78959549333926],
  [43.71048871640995, -79.78684268797262]
,[43.71116383678683, -79.78739570690789]
,[43.71163463991717, -79.78785041136577]
,[43.712291981497245, -79.7886369271848]
,[43.71271836139219, -79.78793643648042]
,[43.7130470271402, -79.78729739237745]
,[43.713668822273206, -79.7861667758876]
,[43.71408630967099, -79.78544170661691]
,[43.7146192680801, -79.78472892665592]
,[43.71409519242378, -79.78353686350029]
,[43.71375764969649, -79.78273805837158]
,[43.71366882234697, -79.78186551738483]
,[43.71367770507242, -79.78010814607761]
];