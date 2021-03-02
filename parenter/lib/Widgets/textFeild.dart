import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:parenter/common/Constants.dart';

Widget
appTextField(String text, Widget icon,
    {TextEditingController controller = null,
      bool isPassword = false,
      TextInputType keyBoardType = TextInputType.text,
      bool isPhoneFormat = false,
      bool isEnable = true
    }) {

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal:16.0),
    child: Card(
      elevation: 0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Container(
        height: 50,
       width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))
        ),
//        child: Row(
//          children: [
           child:Stack(
             children:[ Padding(
               padding: const EdgeInsets.symmetric(horizontal:16.0),
               child: TextField(
                 inputFormatters: isPhoneFormat ? [
                   MaskedInputFormater('(###) ###-####')
                 ]:[],
                 style:TextStyle(fontSize: 12) ,
                 enabled: isEnable,
                 keyboardType: keyBoardType,
                  controller: controller,
                  obscureText: isPassword,
                 cursorColor: AppColors.appPinkColor,
                 decoration: InputDecoration(

                     contentPadding: EdgeInsets.all(0),
                     filled: true,
                     fillColor: Colors.white,
                     hintText: text,
                     hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                     border: OutlineInputBorder(
                         borderSide: BorderSide.none,
                         borderRadius: BorderRadius.circular(30))),
                ),
             ),
               Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment:MainAxisAlignment.end,
                   children: [
                     InkWell(
                         child: icon
                     )
                   ],
                 ),
               )
      ]
           ),
//          ],
//        ),
      ),
    ),
  );


}
