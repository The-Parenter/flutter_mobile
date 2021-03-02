import 'package:parenter/Models/User/ChildPetViewModel.dart';



class UserViewModel {
  String id;
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String childCount;
  String petCount;
  bool isActive;
  String createdDate;
  String updatedDate;
  String longitude;
  String latitude;
  bool isSocialLogin;
  String socialToken;
  String address;
  String token;
  List<ChildPetViewModel> childs = [];
  List<ChildPetViewModel> pets = [];
  List<String> favourtiesIds = [];


UserViewModel() {
   id = "";
   firstName = "";
   lastName = "";
   email = "";
   phoneNumber = "";
   password = "";
   childCount = "";
   petCount = "";
   isActive = false;
   createdDate = "";
   updatedDate = "";
   longitude = "";
   latitude = "";
   isSocialLogin = false;
   socialToken = "";
   token;
   address = "";
   childs = [];
   pets = [];
   favourtiesIds = [];

  }

  UserViewModel.api(Map<String, dynamic> json) {
    this.id = json['id'] ?? '';
    this.firstName = json['firstName'] ?? '';
    this.lastName = json['lastName'] ?? '';
    this.email = json['email'] ?? '';
    this.phoneNumber = json['phone'] ?? '';
    this.password = json['password'] ?? '';
    this.address = json['postalAddress'] ?? '';
    this.childCount = json['childCount'] ?? '';
    this.petCount = json['petsCount'] ?? '';
    this.isActive = json['isActive'] ?? false;
    this.createdDate = json['createdDate'] ?? '';
    this.updatedDate = json['updatedDate'] ?? '';
    this.longitude = json['longitude'] ?? '';
    this.latitude = json['latitude'] ?? '';
    this.isSocialLogin = json['isSocialLogin'] ?? false;
    this.socialToken = json['socialToken'] ?? '';
    if (json['token'] != null) {
      this.token = json['token'] ?? '';
    }
    for (var child in json["listChildren"]){
      this.childs.add(ChildPetViewModel.api(child));
    }
    for (var pet in json["listPets"]){
      this.pets.add(ChildPetViewModel.api(pet,isPet: true));
    }
    this.favourtiesIds.clear();
    if (json['arrFavServiceProviderIds'] != null) {
      for (var each in json['arrFavServiceProviderIds']) {
        this.favourtiesIds.add(each);
      }
    }
  }
  String getFullName(){
    return this.firstName + " " + this.lastName;
  }


  bool isInFavourite(String id,isRemove){
  var result = false;
  for ( var i = 0;i<this.favourtiesIds.length; i++){
    if (this.favourtiesIds[i] == id){
      result = true;
      if (isRemove){
        this.favourtiesIds.removeAt(i);
      }
      break;
    }
  }
    return result;
  }
 }

