import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:intl/intl.dart';

class AvailabilityWidget extends StatefulWidget {

  final Function onChanged;
  final List<DayModel> data;
  AvailabilityWidget(this.onChanged,{this.data});
  @override
  _AvailabilityWidgetState createState() => _AvailabilityWidgetState();
}

class _AvailabilityWidgetState extends State<AvailabilityWidget> {
   List<bool> daysValues = [false,false,false,false,false,false,false];
   List<DayModel> workingDays = [DayModel(),DayModel(),DayModel(),DayModel(),DayModel(),DayModel(),DayModel()];
   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     if (widget.data != null){

       for (var i=0;i<widget.data.length;i++){
         var each = widget.data[i];
         if (each.dayName.toLowerCase().contains('sun')){
           workingDays[0] = each;
           workingDays[0].isEnabled = true;
           daysValues[0] = true;
         }else if (each.dayName.toLowerCase().contains('mon')){
           workingDays[1] = each;
           workingDays[1].isEnabled = true;
           daysValues[1] = true;
         } else if (each.dayName.toLowerCase().contains('tue')){
           workingDays[2] = each;
           workingDays[2].isEnabled = true;
           daysValues[2] = true;
         }else if (each.dayName.toLowerCase().contains('wed')){
           workingDays[3] = each;
           workingDays[3].isEnabled = true;
           daysValues[3] = true;
         }else if (each.dayName.toLowerCase().contains('thu')){
           workingDays[4] = each;
           workingDays[4].isEnabled = true;
           daysValues[4] = true;
         }else if (each.dayName.toLowerCase().contains('fri')){
           workingDays[5] = each;
           workingDays[5].isEnabled = true;
           daysValues[5] = true;
         }else if (each.dayName.toLowerCase().contains('sat')){
           workingDays[6] = each;
           workingDays[6].isEnabled = true;
           daysValues[6] = true;
         }

       }

       setState(() {

       });
     }

     // getUserDetails();
   }

  Widget availabilityRow(BuildContext context,String dayTitle,int index){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
                value: daysValues[index],
                activeColor: AppColors.appPinkColor,
                onChanged: (value){
                  setState(() {
                    workingDays[index].dayName = dayTitle;
                    workingDays[index].isEnabled = value;
                    daysValues[index] = value;
                    widget.onChanged(workingDays);
                  });
                }
            ),
            SizedBox(width: 2,),
            Text(dayTitle,style: Theme.of(context).textTheme.bodyText2,),
          ],
        ),
        Row(
          children: [
            Container
              (
                width:60,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: daysValues[index] == true ? AppColors.appPinkColor : Colors.grey,width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0,bottom: 6.0),
                  child: BasicTimeField(daysValues[index],(value){
                    final f = new DateFormat('HH:mm');
                    workingDays[index].from = f.format(value);
                    widget.onChanged(workingDays);
                  },initialValue: workingDays[index].from),
                )
            ),
            SizedBox(width: 40,),

            Container
              (
                width:60,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: daysValues[index] == true ? AppColors.appPinkColor : Colors.grey,width: 1),
                ),
                child:  Padding(
                  padding: const EdgeInsets.only(left:8.0,bottom: 6.0),
                  child: BasicTimeField(daysValues[index],(value){
                    final f = new DateFormat('HH:mm');
                    workingDays[index].to = f.format(value);
                    widget.onChanged(workingDays);
                  },initialValue: workingDays[index].to,),
                )
            ),
            SizedBox(width: 15,),

          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left:16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Day'),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                  Container(width:60,child: Text('From')),
                  SizedBox(width: 40,),
                      Container(width:60,child: Text('To')),
                  ]
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),

          availabilityRow(context,"Sunday",0),
          availabilityRow(context,"Monday",1),
          availabilityRow(context,"Tuesday",2),
          availabilityRow(context,"Wednesday",3),
          availabilityRow(context,"Thursday",4),
          availabilityRow(context,"Friday",5),
          availabilityRow(context,"Saturday",6),
        ],
      ),
    );
  }
}

class BasicTimeField extends StatelessWidget {
  final bool isEnable;
  final Function onValueChanged;
  final String initialValue;
  BasicTimeField(this.isEnable,this.onValueChanged,{this.initialValue});
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return
      DateTimeField(
       // initialValue: this.initialValue.isEmpty ?null: DateTime.parse(initialValue),
        onChanged: (value){
          onValueChanged(value);
        },
        enabled:this.isEnable ,
        style: TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: initialValue,
          hintStyle: TextStyle(
            color: Colors.black
          ),
          border: InputBorder.none,
            suffixIcon: null,
        ),

        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
    );
  }
}