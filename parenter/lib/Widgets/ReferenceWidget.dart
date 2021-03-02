

import 'package:flutter/material.dart';
import 'package:parenter/Models/User/RefrenceModel.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';


class ReferenceWidget extends StatelessWidget {
  final Function onChanged;
  final ReferencePersonModel referenceModel;
  ReferenceWidget(this.referenceModel,this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 4,
          ),
          Container(
            width:  double.infinity,
            child: TextField(
              onChanged: (value){
                referenceModel.name = value;
              },
              cursorColor: AppColors.appPinkColor,
              decoration: InputDecoration(
                  hintText: "Name *",

                  contentPadding: EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width:  double.infinity,
            child: TextField(
              onChanged: (value){
                referenceModel.email = value;
              },
              cursorColor: AppColors.appPinkColor,
              decoration: InputDecoration(
                  hintText: "Email *",

                  contentPadding: EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            width:  double.infinity,
            child: TextField(
              onChanged: (value){
                referenceModel.contact = value;
              },
              cursorColor: AppColors.appPinkColor,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "Phone No *",
                  contentPadding: EdgeInsets.only(left: 20),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30))),
            ),
          ),
        ],
      ),
    );
  }
}
