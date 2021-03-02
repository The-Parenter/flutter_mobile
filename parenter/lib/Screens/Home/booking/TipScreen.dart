import 'package:flutter/material.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';

class TipScreen extends StatelessWidget {
  static final String routeName = '/TipScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBGColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 190,
                    width: 190,
                    child: Image(
                      image: AssetImage(
                        'resources/images/tip.png',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 48,
              ),
              appTextField(
                '####',
                Icon(
                  Icons.monetization_on,
                  size: 25,
                  color: AppColors.appPinkColor,
                ),
              ),
              SizedBox(
                height: 32,
              ),
              AppButton(btnTitle: AppStrings.SUBMIT),
            ],
          ),
        ),
      ),
    );
  }
}
