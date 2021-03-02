import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parenter/common/Constants.dart';

class ActivityIndicator extends StatelessWidget {
  final size;
  ActivityIndicator({this.size = 40});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitDoubleBounce(
        color: AppColors.appPinkColor,
        size: 40,
      ),
    );
  }
}
