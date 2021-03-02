import 'package:flutter/material.dart';
import 'package:parenter/common/Constants.dart';

class AttachImageCell extends StatefulWidget {
  final Function showPopUp;

  AttachImageCell(this.showPopUp);

  @override
  _AttachImageCellState createState() => _AttachImageCellState();
}

class _AttachImageCellState extends State<AttachImageCell> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:16.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: this.widget.showPopUp,
        child: Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(
              color:AppColors.appPinkColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add,
                size: 30,
                color:AppColors.appPinkColor,
              ),
              Text(
                'Add Image',
                style: TextStyle(
                  fontSize: 13,
                  color:AppColors.appPinkColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
