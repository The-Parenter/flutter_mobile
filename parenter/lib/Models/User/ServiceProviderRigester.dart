
import 'package:parenter/Models/User/RefrenceModel.dart';
import 'package:parenter/common/Constants.dart';

class ServiceProviderRegisterModel {
  String token;
  String id;
  String serviceProviderType;
  String petCareServiceType;
  String firstName;
  String lastName;
  String businessName;
  String businessNumber;
  String emailAddress;
  String phone;
  String postalAddress;
  bool isMentionedAge;
  bool haveValidLicense;
  String educationLevel;
  String experienceDetail;
  String languages = "";
  String educationCertificateBase64;
  String firstAidCertificateBase64;
  String backgroundCertificateBase64;
  String additionalDetails;
  String password;
  String longitude;
  String latitude;
  List<String> extraServices = [];
  List<Map<String,String>> listOperationalHours = [];
  List<DayModel> workingDays = [];
  bool isSocialLogin;
  String socialToken;
  String apartmentNo;

  var avgRating;
  List<String> picturesArray = [];
  List<ReferencePersonModel> refrences = [];
  var doubleRating = 0;

  ServiceProviderRegisterModel() {
    token = "";
    id = "";
   serviceProviderType = "";
   petCareServiceType = "";
   firstName = "";
   lastName = "";
   businessName = "";
   businessNumber = "";
   emailAddress = "";
   phone = "";
   postalAddress = "";
   isMentionedAge = false;
   haveValidLicense = false;
   educationLevel = "";
   experienceDetail = "";
   educationCertificateBase64 = "";
   firstAidCertificateBase64 = "";
   backgroundCertificateBase64 = "";
   additionalDetails = "";
   password = "";
   longitude = "";
   latitude = "";
   languages = "";
   isSocialLogin = false;
   socialToken = "";
   avgRating = 0.0;
   this.apartmentNo = "";
   picturesArray = [];
   refrences = [ReferencePersonModel(),ReferencePersonModel()];
   this.doubleRating = 0;

  }

  ServiceProviderRegisterModel.api(Map<String, dynamic> json) {
    if (json['id'] != null) {
      this.id = json['id'] ?? '';
      this.serviceProviderType = json['serviceProviderType'] ?? '';
      this.petCareServiceType = json['petCareServiceType'] ?? '';

      this.extraServices.clear();
      if (json['extraServices'] != null) {
        for (var each in json['extraServices']) {
          this.extraServices.add(each);
        }
      }

      this.firstName = json['firstName'] ?? '';
      this.lastName = json['lastName'] ?? '';
      this.businessName = json['businessName'] ?? '';
      this.businessNumber = json['businessNumber'] ?? '';

      this.postalAddress = json['postalAddress'] ?? '';
      this.emailAddress = json['emailAddress'] ?? '';
      this.phone = json['phone'] ?? '';
      this.password = json['password'] ?? '';
      this.languages = json['languagesSpoken'] ?? "";
      this.isMentionedAge = json['isMentionedAge'] ?? false;
      this.haveValidLicense = json['haveValidLicense'] ?? false;
      this.haveValidLicense = json['haveValidLicense'] ?? false;
      this.apartmentNo = json['UnitNo'] ?? "";
      this.avgRating = json['avgRating'] ?? 0;

      this.educationLevel = json['educationLevel'] ?? '';
      this.experienceDetail = json['experienceDetail'] ?? '';
      this.educationCertificateBase64 =
          json['educationCertificateBase64'] ?? '';
      this.firstAidCertificateBase64 = json['firstAidCertificateBase64'] ?? '';
      this.backgroundCertificateBase64 =
          json['backgroundCertificateBase64'] ?? '';
      this.additionalDetails = json['additionalDetails'] ?? '';

      this.longitude = json['longitude'] ?? '';
      this.latitude = json['latitude'] ?? '';


      this.workingDays.clear();
      if (json['listOperationalHours'] != null) {
        for (var each in json['listOperationalHours']) {
          this.workingDays.add(DayModel.api(each));
        }
      }

      this.picturesArray.clear();
      if (json['arrPictures'] != null) {
        for (var each in json['arrPictures']) {
          this.picturesArray.add(each);
        }
      }
      this.refrences.clear();
      if (json['arrReferences'] != null) {
        for (var each in json['arrReferences']) {
          this.refrences.add(ReferencePersonModel.api(each));
        }
      }
      this.token = json['token'] ?? '';
    }
  }

  String getFullName(){
    return this.firstName + " " + this.lastName;
  }

  String getWorkingDaysTitle(){
    String result = "";
    for (var each in this.workingDays){
      if (!each.dayName.isEmpty) {
        result +=
            '${each.dayName[0]}' + '${each.dayName[1]}' + '${each.dayName[2]}' +
                "-";
      }
  }
    if (result.length > 0){
    result = result.substring(0, result.length - 1);
    }
    return result;
  }

  String getExtraServices(){
    String result = "";
    for (var each in this.extraServices){
      result += each + ",";
    }
    if (result.length > 0){
      result = result.substring(0, result.length - 1);
    }
    return result;
  }


  String getWorkingTime(){
    String result = "";
    if (this.workingDays.length > 0){
      result += this.workingDays[0].from + " - " + this.workingDays[0].to;
    }
    return result;
  }

}


class ServiceProviderRegisterListMode{
  var values = List<ServiceProviderRegisterModel>();

  ServiceProviderRegisterListMode(){
    values = List<ServiceProviderRegisterModel>();
  }
  ServiceProviderRegisterListMode.api(var json) {
    for(var each in json){
      var model = ServiceProviderRegisterModel.api(each);
      values.add(model);
    }
  }

  void sortServiceProviders(String text){

    if (text == sortOptions[0]){
      values.sort((a, b) => b.avgRating.compareTo(a.avgRating));
    }else{
      values.sort((a, b) => a.avgRating.compareTo(b.avgRating));

    }

  }



}

class DayModel{
  String dayName = "";
  String from = "";
  String to = "";
  bool isEnabled = false;
  String slot = "";
  DayModel() {
    this.dayName = "";
    this.from = "";
    this.to = "";
    this.isEnabled = false;
    this.slot = "";
  }
  DayModel.api(Map<String, dynamic> json) {
    this.dayName = json['day'] ?? '';
    this.from = json['from'] ?? '';
    this.to = json['to'] ?? '';
    this.slot = json['slotDate'] ?? [];
  }

}

