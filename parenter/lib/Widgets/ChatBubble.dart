import 'package:flutter/material.dart';
import 'package:parenter/common/Constants.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({this.message, this.time, this.delivered, this.isMe});

  final String message, time;
  final bool delivered, isMe;

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? AppColors.appPinkColor: AppColors.chatGrayColor;
    final align = isMe ?  CrossAxisAlignment.end :CrossAxisAlignment.start ;
    final icon = delivered ? Icons.done_all : Icons.done;
    final radius = isMe
        ?
         BorderRadius.only(
      topRight: Radius.circular(15.0),
      topLeft: Radius.circular(15.0),
      bottomLeft: Radius.circular(15.0),)
           :BorderRadius.only(
         topRight: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0),
         topLeft: Radius.circular(15.0),
    )
    ;
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Padding(
          padding: isMe ? const EdgeInsets.only(
              top:8.0,
              bottom: 8.0,
              left:  100 ,
            right: 8
          ):const EdgeInsets.only(
              top:8.0,
              bottom: 8.0,
              left:  8,
              right: 100

          ),
          child: Container(
              //width: MediaQuery.of(context).size.width - 120,
            margin: const EdgeInsets.all(3.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: .5,
                    spreadRadius: 1.0,
                    color: Colors.black.withOpacity(.12))
              ],
              color: bg,
              borderRadius: radius,
            ),

            child: Container(
              padding: const EdgeInsets.only(bottom:10.0),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 90.0),
                    child: Text(message,style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                   // top: 10,
                    child: Row(
                      children: <Widget>[
                        Text(time,
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 10.0,
                            )),
//                        SizedBox(width: 3.0),
//                        Icon(
//                          icon,
//                          size: 0.0,
//                          color: Colors.black38,
//                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}