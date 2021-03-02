import 'dart:io';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parenter/Widgets/AttachImgeCell.dart';
import 'package:parenter/Widgets/FileCell.dart';
import 'package:parenter/common/Constants.dart';

enum Departments { Image, Document }

class FormImagePicker extends StatefulWidget {
  final List<PickedFile> files;
  final Function removeFunction;
  FormImagePicker( this.files, this.removeFunction);

  @override
  _FormImagePickerState createState() => _FormImagePickerState();
}

class _FormImagePickerState extends State<FormImagePicker> {

  //FileListViewModel files = FileListViewModel();

  String _path = '-';
  bool _pickFileInProgress = false;
  bool _iosPublicDataUTI = true;
  bool _checkByCustomExtension = false;
  bool _checkByMimeType = false;
  final picker = ImagePicker();

  final _utiController = TextEditingController(
    text: 'com.sidlatau.example.mwfbak',
  );

  final _extensionController = TextEditingController(
    text: 'mwfbak',
  );

  final _mimeTypeController = TextEditingController(
    text: 'application/pdf image/png',
  );

  showPopUp(BuildContext context) {
    getImage();
  }

//  Future<void> selectImages() async {
//    List<Media> _listImagePaths = await ImagePickers.pickerPaths(
//      galleryMode: GalleryMode.image,
//      selectCount: 1,
//      showCamera: true,
//      compressSize: 500,
//      uiConfig: UIConfig(uiThemeColor: COLOR_ARRAY[this.widget.colorIndex]),
//    );
//    setState(() {
//      for (Media image in _listImagePaths) {
//        FileViewModel file = FileViewModel.data(image.path, 'image');
//
//        this.widget.files.filesList.add(file);
//        imagesList.add(image);
//      }
//    });
//  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
//          return this.widget.files.length > index
//              ? FileCell(this.widget.files.length > 0,
//                  this.widget.files[index], this.widget.removeFunction,index)
//              : AttachImageCell(
//                  () => this.showPopUp(context),
//                );
          return  index > 0
              ? FileCell(this.widget.files.length > 0,
              this.widget.files[index - 1], this.widget.removeFunction,index - 1)
              : AttachImageCell(
                () => this.showPopUp(context),
          );
        },
        itemCount:  this.widget.files.length < 10 ? this.widget.files.length + 1 :  this.widget.files.length,
      ),
    );
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        this.widget.files.add(pickedFile);
        setState(() {});
      } else {
        print('No image selected.');
      }
    });
  }
}
