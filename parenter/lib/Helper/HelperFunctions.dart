import 'dart:convert';
import 'dart:io' as Io;
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:parenter/common/Constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
Future<bool> check() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

bool isValidEmail(String email){
  return  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool isSameDate(DateTime first, DateTime second){
  return first.year == second.year && first.month == second.month
      && first.day == second.day;
}

Future<String> getBase64FromFile(PickedFile image) async{
//  List<int> imageBytes = await image.readAsBytes();
//  //print(imageBytes);
//  String base64Image = base64Encode(imageBytes);
//  return base64Image;
  var imageResized = await FlutterNativeImage.compressImage(image.path,
      quality: 50, targetWidth: 120, targetHeight: 120);
  List<int> imageBytes = imageResized.readAsBytesSync();
  String  photoBase64 = base64Encode(imageBytes);
  return photoBase64;

}

Future<String> getBase64FromImage(Io.File image) async{

  var imageResized = await FlutterNativeImage.compressImage(image.path,
      quality: 50, targetWidth: 120, targetHeight: 120);
  List<int> imageBytes = imageResized.readAsBytesSync();
  String  photoBase64 = base64Encode(imageBytes);

//  final bytes = Io.File(image.path).readAsBytesSync();
//  List<int> imageBytes = await image.readAsBytes();
  //print(imageBytes);
//  String base64Image = base64Encode(imageBytes);
//  base64Image = base64Image.replaceAll("data:image/jpeg;base64,", "");
  return photoBase64;
}

String formatDateAndReturnString(DateTime date) {
  var formatter = new DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(date);
  return formatted;
}

String getDateOnlyFromDate(DateTime date) {
  var result = '${date.year}' + "-";
  if (date.month < 10){
    result += "0" + '${date.month}' + "-";
  }else{
    result += '${date.month}' + "-";
  }

  if (date.day < 10){
    result += "0" + '${date.day}' ;
  }else{
    result += '${date.day}' ;
  }
  return result;
}

String getTimeOnlyFromDate(DateTime date) {
  var result = '${date.hour}' + ":";
  if (date.minute < 10){
    result += "0" + '${date.minute}' + ":";
  }else{
    result += '${date.minute}' + ":";
  }
    result += "00";
  return result;
}


String formatDateForDashboard(DateTime date) {
  var formatter = DateFormat('MMM yyyy');
  return formatter.format(date);
}

String formatDateForLineChart(DateTime date) {
  var formatter = DateFormat('MMM');
  return formatter.format(date);
}

String formatDateForDateRangePicker(DateTime dateTime) {
  var formatter = DateFormat('dd MMM yyyy');
  return formatter.format(dateTime);
}

String formatDateFromString(String dateTime) {
  if (dateTime != '' && dateTime != null) {
    var date = DateTime.parse(dateTime) ?? '01-01-2020';
    return formatDateForDateRangePicker(date);
  }
  return dateTime;
}

String formatDateForCashFlowAPI(DateTime dateTime) {
  var formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}

String formatDueDateForReminders(String dueDate) {
  var formatDueDate = DateFormat("yyyy-MM-dd").parse(dueDate);
  return DateFormat('dd MMM yyyy').format(formatDueDate);
}

bool checkIfStringEmpty(String value) {
  return (value == '' || value == null || value == 'null');
}

Widget returnEmptyContainerForHeight() {
  return SizedBox(
    width: 1,
    height: 1,
  );
}

bool isNumeric(String str) {
  if (str == null || str.isEmpty) {
    return true;
  }
  return num.tryParse(str) != null;
}

String showAlertDialog(BuildContext context, String title, String message,
    bool isInternetDialog, Function onRetryClick,
    {bool closeMainScreen: false}) {
  AlertDialog dialog = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        color: AppColors.appPinkColor,
        child: Text('Ok'),
        onPressed: () {
          Navigator.of(context).pop();
          if (closeMainScreen) {
            Navigator.of(context).pop();
          }
        },
      ),
      isInternetDialog
          ? FlatButton(
              child: Text('Retry'),
              onPressed: onRetryClick,
            )
          : Container(
              width: 0,
              height: 0,
            ),
    ],
  );

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

void showDoubleButtonAlertDialog(
    BuildContext context,
    String title,
    String message,
    String titleFirstButton,
    String titleSecondButton,
    Function onFirstClick) {
  AlertDialog dialog = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text('$titleSecondButton'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      FlatButton(
        child: Text('$titleFirstButton'),
        onPressed: onFirstClick,
      ),
    ],
  );
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return dialog;
      });
}

//void openAttachment(BuildContext context, AttachmentViewModel doc) {
//  if (doc.extension == 'pdf') {
//    showPDF(context, doc.fileUrl);
//  } else if (doc.type.name == 'image') {
//    showPhoto(context, doc.fileUrl);
//  } else {
//    _launchURL(context, doc.fileUrl);
//    print('new format');
//  }
//}

//void showPhoto(BuildContext context, String url, {bool isDocument = false}) {
//  Navigator.of(context).push(CupertinoPageRoute(
//      fullscreenDialog: true,
//      builder: (context) => PhotoViewer(url, false, isDocument: isDocument)));
//}
//
//void showPDF(BuildContext context, String url) {
//  Navigator.of(context).push(CupertinoPageRoute(
//      fullscreenDialog: true, builder: (context) => PDFViewerScreen(url)));
//}

_launchURL(BuildContext context, String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    showAlertDialog(context, '', "Invalid Url", false, () {});
    throw 'Could not launch $url';
  }
}

num roundNumToDecimalPlaces(num number) {
  var result = number;
  if (number != null && !number.isNaN) {
      result = ((number * 100).truncateToDouble()/100);
  }
  return result;
}
