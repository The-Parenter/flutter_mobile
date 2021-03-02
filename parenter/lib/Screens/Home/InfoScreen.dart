import 'package:flutter/material.dart';
import 'package:parenter/common/Constants.dart';

class InfoScreen extends StatefulWidget {
  static String routeName = '/InfoScreen';

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0,bottom: 16),
                    child: Icon(
                        Icons.keyboard_backspace
                    ),
                  ),
                ),
              ),
              Text(
                'About App',
                style: TextStyle(fontSize: 24, color: AppColors.textColor),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: Card(
                  color: AppColors.colorWhite,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        _buildCard(
                            Icons.info_outline, 'About', AppColors.colorRed),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 0.3,
                          color: AppColors.colorSecondaryText,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buildCard(Icons.event_note, 'Terms & Conditions',
                            AppColors.colorGreen),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          height: 0.3,
                          color: AppColors.colorSecondaryText,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _buildCard(Icons.note, 'Privacy Policy',
                            AppColors.appBottomNabColor),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildCard(IconData iconData, String title, Color color) {
    return Row(
      children: [
        Card(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 0.0,
          child: Container(
            width: 50,
            height: 50,
            child: Icon(
              iconData,
              size: 30,
              color: AppColors.colorWhite,
            ),
          ),
        ),
        SizedBox(
          width: 30,
        ),
        Text(
          title,
          style: TextStyle(color: AppColors.colorPrimaryText, fontSize: 18),
        )
      ],
    );
  }
}
