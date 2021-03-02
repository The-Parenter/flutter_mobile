
import 'package:flutter/material.dart';
import 'package:parenter/common/Constants.dart';

class AppButton extends StatelessWidget {
 final String btnTitle;
 AppButton({this.btnTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: Container(
        height:56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color:AppColors.appPinkColor,
//          gradient: LinearGradient(
//            colors: [AppColors.lightGradient, AppColors.darkGradient],
//            begin: Alignment.centerLeft,
//            end: Alignment.centerRight,
//          ),
        ),
        child: Text(
          this.btnTitle,
          style: TextStyle(
            color: Colors.white,
           // fontFamily: Constants.fontfamily,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
