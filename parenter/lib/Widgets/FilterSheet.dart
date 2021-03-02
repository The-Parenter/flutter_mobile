import 'package:flutter/material.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/ServiceProvider/FilterModel.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Widgets/AvailabilityWIdget.dart';
import 'package:parenter/common/Constants.dart';
import 'package:intl/intl.dart';

class BottomFilterSheet extends StatefulWidget {
  final int searchType;
  final Function applyFilter;

  BottomFilterSheet(this.searchType,this.applyFilter);
  @override
  _BottomFilterSheetState createState() => _BottomFilterSheetState();
}

class _BottomFilterSheetState extends State<BottomFilterSheet> {
  TextEditingController daysController = TextEditingController();
  var timingsFrom = "";
  var timingsTo = "";
  var daysText ;
  bool isCooking = false;
  bool isCleaning = false;
  bool isSpecial = false;
  FilterModel filterValues = FilterModel();
  RangeValues values = RangeValues(1, 100);
  RangeLabels labels = RangeLabels('1', "100");

  int petCareRadioValue = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
      child: new Wrap(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filters',
                style:
                TextStyle(color: AppColors.textColor, fontSize: 22.0),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.clear,
                  size: 30,
                ),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Location Radius',
                style:
                TextStyle(color: AppColors.textColor, fontSize: 17),
              ),
              SizedBox(
                height: 15,
              ),
              RangeSlider(
                  divisions: 10,
                  activeColor: Colors.red[700],
                  inactiveColor: Colors.red[300],
                  labels: labels,
                  min: 1,
                  max: 100,
                  values: this.values,
                  onChanged: (value){
                    setState(() {
                      this.values = value;
                      labels =RangeLabels("${value.start.toInt().toString()}", "${value.end.toInt().toString()}");
                    });
                  }
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Select Day',
                style:
                TextStyle(color: AppColors.textColor, fontSize: 17),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: AppColors.appPinkColor,width: 1)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: new DropdownButton<String>(
                    isExpanded: true,
                    iconEnabledColor: AppColors.appPinkColor,
                    underline: Container(),
                    items: daysName.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    value:  daysText,
                    onChanged: (val) {
                      setState(() {
                        daysText = val;
                      });
                    },
                  ),
                ),
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Timings From',
                        style: TextStyle(
                            color: AppColors.textColor, fontSize: 17),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container
                        (
                          width:150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: AppColors.appPinkColor,width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,bottom: 6.0),
                            child:  BasicTimeField(true,(value){
                              final f = new DateFormat('HH:mm');
                              timingsFrom = getTimeOnlyFromDate(value);
                            }),
                          )
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Timings To',
                        style: TextStyle(
                            color: AppColors.textColor, fontSize: 17),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container
                        (
                          width:150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(color: AppColors.appPinkColor,width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left:8.0,bottom: 6.0),
                            child:  BasicTimeField(true,(value){
                              final f = new DateFormat('HH:mm');
                              timingsTo = getTimeOnlyFromDate(value);

                            }),
                          )
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
              ],
            ),
          ),

          Container(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.widget.searchType == 0 ?
            [   Text(
              'Select Extra Services',
              style: TextStyle(
                  color: AppColors.textColor, fontSize: 17),
            ),
              Container(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: isSpecial, onChanged: (value){
                        setState(() {
                          isSpecial = value;
                        });
                      }),
                      Text('Special Needs'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isCleaning, onChanged: (value){
                        setState(() {
                          isCleaning = value;
                        });
                      }),
                      Text('Cleaning'),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isCooking, onChanged: (value){
                        setState(() {
                          isCooking = value;
                        });
                      }),
                      Text('Cooking'),
                    ],
                  ),
                ],
              ),
            ]:this.widget.searchType == 2 ?
            [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    new Text(
                      'Please select a type',
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Radio(
                          value: 0,
                          groupValue: petCareRadioValue,
                          onChanged: _handlePetCareValueChange,
                        ),
                        new Text(
                          'Pet Sitter ',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 1,
                          groupValue: petCareRadioValue,
                          onChanged: _handlePetCareValueChange,
                        ),
                        new Text(
                          'Dog Walker',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ] :[],
          ),
          Container(
            height: 40,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: FlatButton(
              onPressed: () {
                this.filterValues.day = this.daysText;
                this.filterValues.timeFrom = this.timingsFrom;
                this.filterValues.timeT0 = this.timingsTo;
                this.filterValues.radius = this.values.end;
                this.filterValues.petCareType = this.petCareRadioValue == 0 ? "Pet Sitter":"Dog Walker";
                this.widget.applyFilter(this.filterValues);
                // Navigator.of(context).pushNamed(SearchDetail.routeName,arguments: widget.searchType);
              },
              color: AppColors.appBottomNabColor,
              child: Text(
                'Apply Filters',
                style:
                TextStyle(color: AppColors.colorWhite, fontSize: 18),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  void _handlePetCareValueChange(int value) {
    setState(() {
      petCareRadioValue = value;
    });
  }
}
