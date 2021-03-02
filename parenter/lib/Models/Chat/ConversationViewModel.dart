import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
class ConversationViewModel{
  String id;
  String senderUserName;
  String senderUserId;
  String recevierUserName;
  String recevierUserId;
  String message;
  String createdDate;
  DateTime date;
  String timeDifference;

  ConversationViewModel() {
    id = "";
    senderUserName = "";
    senderUserId = "";
    recevierUserName = "";
    recevierUserId = "";
    message = "";
    createdDate = "";
    timeDifference = "";
    date = DateTime.now();
  }
  ConversationViewModel.api(Map<String, dynamic> json) {
  this.id = json['id'] ?? '';
  this.senderUserName = json['senderUserName'] ?? '';
  this.senderUserId = json['senderUserId'] ?? '';
  this.recevierUserName = json['recevierUserName'] ?? '';
  this.recevierUserId = json['recevierUserId'] ?? '';
  this.message = json['message'] ?? '';
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
      text = "Just Now";
    }
    return text;
  }
}

class ConversationListViewModel {

  List<ConversationViewModel> conversations = [];

  ConversationListViewModel(){
    this.conversations = [];
  }

  ConversationListViewModel.api(var json) {
    for(var each in json) {
      this.conversations.add(ConversationViewModel.api(each));
    }
    conversations.sort((a,b) => a.date.compareTo(b.date));
    }
  }
