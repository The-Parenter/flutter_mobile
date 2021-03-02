import 'package:flutter/material.dart';
import 'package:parenter/Models/User/ChildPetViewModel.dart';

class BookingModel{

  String id;
  String parentId;
  String serviceProviderId;
  String parentFirstName;
  String parentLastName;
  String serviceProviderFirstName;
  String serviceProviderLastName;
  String businessName;
  String bookingDate;
  String postalAddress;
  String timingsFrom;
  String timingsTo;
  String petCareServiceType;
  String extraServices;
  String status;
  String updatedDate;
  String createdDate;
  DateTime date;
  List<ChildPetViewModel> childs = [];
  List<ChildPetViewModel> pets = [];
  bool isTrackEnable = false;


  BookingModel() {
  id = "";
  parentId = "";
  serviceProviderId = "";
  parentFirstName = "";
  parentLastName = "";
  serviceProviderFirstName = "";
  serviceProviderLastName = "";
  businessName = "";
  bookingDate = "";
  postalAddress = "";
  timingsFrom = "";
  timingsTo = "";
  petCareServiceType = "";
  extraServices = "";
  status = "";
  updatedDate = "";
  createdDate = "";
  date = DateTime.now();
  childs = [];
  pets = [];
  isTrackEnable = false;
  }

  BookingModel.api(Map<String, dynamic> json) {
  this.id = json['id'] ?? '';
  this.parentId = json['parentId'] ?? '';
  this.serviceProviderId = json['serviceProviderId'] ?? '';
  this.parentFirstName = json['parentFirstName'] ?? '';
  this.parentLastName = json['parentLastName'] ?? '';
  this.serviceProviderFirstName = json['serviceProviderFirstName'] ?? '';
  this.serviceProviderLastName = json['serviceProviderLastName'] ?? '';
  this.businessName = json['businessName'] ?? '';
  this.bookingDate = json['bookingDate'] ?? '';
  this.postalAddress = json['postalAddress'] ?? '';
  this.timingsFrom = json['timingsFrom'] ?? '';
  this.timingsTo = json['timingsTo'] ?? '';
  this.petCareServiceType = json['petCareServiceType'] ?? '';
  this.extraServices = json['extraServices'] ?? '';
  this.status = json['status'] ?? '';
  this.updatedDate = json['updatedDate'] ?? '';
  this.createdDate = json['createdDate'] ?? '';
  date = DateTime.tryParse(this.createdDate);
  for (var child in json["listChildren"] ?? []){
  this.childs.add(ChildPetViewModel.api(child));
  }
  for (var pet in json["listPets"] ?? []){
  this.pets.add(ChildPetViewModel.api(pet,isPet: true));
  }
  this.isTrackEnable = checkIfTrackingEnable();
  }
  String getSPFullName(){
    return this.serviceProviderFirstName + " " + this.serviceProviderLastName;
  }
  String getParentFullName(){
    return this.parentFirstName + " " + this.parentLastName;
  }

  bool checkIfTrackingEnable(){
    var result = false;
    var fromSplit = this.timingsFrom.split(":");
    var toSplit = this.timingsTo.split(":");

    var fromTime = DateTime(this.date.year,this.date.month,this.date.day,int.tryParse(fromSplit[0] ?? 0),int.tryParse(fromSplit[1] ?? 0));
    var toTime = DateTime(this.date.year,this.date.month,this.date.day,int.tryParse(toSplit[0] ?? 0),int.tryParse(toSplit[1] ?? 0));

    var current = DateTime.now();
    var fromDiff = fromTime.difference(current).inMinutes;
    var toDiff = toTime.difference(current).inMinutes;
    fromDiff = fromDiff < 0 ? fromDiff * -1 : fromDiff;
    toDiff = toDiff < 0 ? toDiff * -1 : toDiff;

    if (fromDiff > 15){
      result = false;
    }else{
      result =  true;
    }

    if (result){
      if (toDiff > 15){
        result = false;
      }else{
        result =  true;
      }
    }

    return result;
  }


}




class BookingListModel {

  List<BookingModel> pendingBookings = [];
  List<BookingModel> confirmedBookings = [];
  List<BookingModel> completedBookings = [];

  BookingListModel(){
    pendingBookings = [];
    confirmedBookings = [];
    completedBookings = [];
  }

  BookingListModel.api(var json) {
    for(var each in json) {
      var model = BookingModel.api(each);
      switch (model.status.toLowerCase()){
        case "pending":
          pendingBookings.add(model);
          break;
        case "accepted":
          confirmedBookings.add(model);
          break;
        case "completed":
          completedBookings.add(model);
          break;
      }

    }
    pendingBookings.sort((a,b) => a.date.compareTo(b.date));
    confirmedBookings.sort((a,b) => a.date.compareTo(b.date));
    completedBookings.sort((a,b) => a.date.compareTo(b.date));

  }
}
