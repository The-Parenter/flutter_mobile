
import 'package:flutter/material.dart';

class FavouritesModel{
  String serviceProviderId;
  String serviceProviderName;
  String businessName;
  String serviceProviderType;
  String petCareServiceType;
  var avgRating;

  FavouritesModel() {
    serviceProviderId = "";
    serviceProviderName = "";
    businessName = "";
    serviceProviderType = "";
    petCareServiceType = "";
    avgRating = 0;
  }
  FavouritesModel.api(Map<String, dynamic> json) {
    this.serviceProviderId = json['serviceProviderId'] ?? '';
    this.serviceProviderName = json['serviceProviderName'] ?? '';
    this.businessName = json['businessName'] ?? '';
    this.serviceProviderType = json['serviceProviderType'] ?? '';
    this.petCareServiceType = json['petCareServiceType'] ?? '';
    this.avgRating = json['avgRating'] ?? 0;
  }


  String getName(){
    return this.serviceProviderName.isEmpty ? this.businessName : this.serviceProviderName;
  }

}

class FavouritesListModel {

  List<FavouritesModel> favourites = [];
  FavouritesListModel(){
    this.favourites = [];
  }
  FavouritesListModel.api(var json) {
    for(var each in json) {
      this.favourites.add(FavouritesModel.api(each));
    }
  }
}
