import 'package:flutter/material.dart';
import 'package:parenter/common/Constants.dart';

class SortOptionsSheet extends StatefulWidget {
  final Function applyFilter;
  SortOptionsSheet(this.applyFilter);

  @override
  _SortOptionsSheetState createState() => _SortOptionsSheetState();
}

class _SortOptionsSheetState extends State<SortOptionsSheet> {
  var sortText;
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
                'Sort',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Rating',
                style:
                TextStyle(color: AppColors.textColor, fontSize: 17),
              ),
              Container(
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
                    items: sortOptions.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    value: sortText,
                    onChanged: (val) {
                      setState(() {
                        sortText = val;
                      });
                    },
                  ),
                ),
              ),
              Container(
                height: 40,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  onPressed: () {

                    this.widget.applyFilter(this.sortText);

                  },
                  color: AppColors.appBottomNabColor,
                  child: Text(
                    'Apply',
                    style: TextStyle(
                        color: AppColors.colorWhite, fontSize: 18),
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
        ],
      ),
    );
  }
}
