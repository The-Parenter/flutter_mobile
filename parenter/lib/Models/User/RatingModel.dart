

import 'package:flutter/material.dart';

class RatingModel{

  var userId = "";
  var firstName = "";
  var lastName = "";
  var businessName = "";
  var ratedUserId = "";
  var ratedUserType = "";
  var rating = 0;
  var review = "";
  var createdDate = "";
  var isActive = false;

  RatingModel(){
    this.userId = "";
    this.firstName = "";
    this.lastName = "";;
    this.businessName = "";;
    this.ratedUserId = "";
    this.ratedUserType = "";
    this.rating = 0;
    this.review = "";
    this.createdDate = "";
    this.isActive = false;
  }


  RatingModel.api(Map<String, dynamic> json) {
    this.userId = json['userId'] ?? '';
    this.firstName = json['firstName'] ?? '';
    this.lastName  = json['lastName '] ?? '';
    this.businessName  = json['businessName '] ?? '';
    this.ratedUserId = json['ratedUserId'] ?? '';
    this.ratedUserType = json['ratedUserType'] ?? '';
    this.rating = json['rating'] ?? 0;
    this.review = json['review'] ?? '';
    this.createdDate = json['createdDate'] ?? '';
    this.isActive = json['isActive'] ?? false;
  }
}

class RatingListModel{
  List<RatingModel> ratings = [];
  double avgRating = 0.0;
  int totalRating = 0;
  RatingListModel(){
    ratings = [];
    avgRating = 0.0;
  }
  RatingListModel.api(var json){
    for (var each in json){
      var model = RatingModel.api(each);
      this.ratings.add(model);
      totalRating += model.rating;
    }
    this.avgRating = totalRating/ratings.length;
  }
  }
