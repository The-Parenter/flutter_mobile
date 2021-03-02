import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NotificationModel{
  String fullName;
  String notificationBody;
  String createdDate;
  DateTime date;
  String timeDifference;

  NotificationModel() {
    fullName = "";
    notificationBody = "";
    createdDate = "";
    timeDifference = "";
    date = DateTime.now();
  }
  NotificationModel.api(Map<String, dynamic> json) {
    this.fullName = json['fullName'] ?? '';
    this.notificationBody = json['notificationBody'] ?? '';
    this.createdDate = json['createdDate'] ?? '';
    date = DateTime.tryParse(this.createdDate);
    final f = new DateFormat('dd/MM/yyyy HH:mm');
    this.createdDate = f.format(this.date);
    this.timeDifference = this.calculateTimeDifference();
  }

  String calculateTimeDifference(){
    var current = DateTime.now();
    final minutes = current.difference(this.date).inMinutes;
    var text = "$minutes min ago";
    if (minutes > 0){
      if (minutes > 1440){
        final f = new DateFormat('dd/MM/yyyy');
        text = f.format(this.date);
      }else if (minutes > 60) {
        int h = (minutes / 60).round();
        text = "$h hour ago";
      }
    }else{
      text = "$minutes sec ago";
    }
    return text;
  }
}

class NotificationListModel {

  List<NotificationModel> notifications = [];
  NotificationListModel(){
    this.notifications = [];
  }
  NotificationListModel.api(var json) {
    for(var each in json) {
      this.notifications.add(NotificationModel.api(each));
    }
    notifications.sort((a,b) => a.date.compareTo(b.date));
  }
}
