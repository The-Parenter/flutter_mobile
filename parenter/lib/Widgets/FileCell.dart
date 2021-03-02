import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:parenter/common/Constants.dart';


class FileCell extends StatefulWidget {
  final bool showFile;
  final PickedFile file;
  final Function removeFunction;
  final int index;

  FileCell(this.showFile, this.file, this.removeFunction,this.index);

  @override
  _FileCellState createState() => _FileCellState();
}

class _FileCellState extends State<FileCell> {
  void showPhoto(BuildContext context, String url) {
//    Navigator.of(context).push(CupertinoPageRoute(
//        fullscreenDialog: true, builder: (context) => PhotoViewer(url, true)));
  }

//  uploadFileToPresignedS3() async {
//    File payload = new File(this.widget.file.path);
//    String presignedURL = this.widget.file.preSignedUrl;
//
//    try {
//      var res = await http.put(
//        presignedURL,
//        body: payload.readAsBytesSync(),
//      );
//      if (res.statusCode == 200) {
//        setState(() {
//          this.widget.file.isUploaded = true;
//        });
//      }
//      print(res.statusCode);
//    } catch (ex) {
//      print(ex);
//    }
//  }

//  void getPreSignedUrl() async {
//    HTTPManager().getSignedUrl(this.widget.file.name).then((val) {
//      this.widget.file.preSignedUrl = val;
//      this.widget.file.fileUrl = this.widget.file.getFileUrl();
//      this.uploadFileToPresignedS3();
//    });
//  }

  @override
  void initState() {
   // getPreSignedUrl();
    super.initState();
    // TODO: implement initState
  }

  void removeFunction() => this.widget.removeFunction(this.widget.index);

  @override
  Widget build(BuildContext context) {
    //final fileIndex = Provider.of<ListnerModel>(context);

    return  Container(
            width: 120,
            child: Stack(
              children: <Widget>[
                new Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () => this.showPhoto(context, this.widget.file.path),
                    child: Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFBFC5D2),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:  Image(
                                fit: BoxFit.fill,
                                image: FileImage(File(this.widget.file.path)),
                              ),
                      ),
                    ),
                  ),
                ),
                new Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: removeFunction,
                      icon: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ))
              ],
            ),
          );
  }
}
