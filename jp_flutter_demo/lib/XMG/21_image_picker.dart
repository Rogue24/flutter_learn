import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jp_flutter_demo/JPLog.dart';
// import 'package:jp_flutter_demo/extension/double_extension.dart';

class ImagePickerExample extends StatelessWidget {
  static String title = "获取相册和相机";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ImagePickerExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: _ImagePickerPage(),

    );
  }
}

class _ImagePickerPage extends StatefulWidget {
  @override
  __ImagePickerPageState createState() => __ImagePickerPageState();
}

class __ImagePickerPageState extends State<_ImagePickerPage> {
  ImagePicker _imagePicker = ImagePicker();
  File _imageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            child: Text("选择照片"),
            onPressed: _pickImage,
          ),

          _imageFile == null ? Text("请选择一张照片") : Image.file(_imageFile),
        ],
      ),
    );
  }

  void _pickImage() async {
    // camera：相机
    // gallery：相册
    PickedFile pickedFile = await _imagePicker.getImage(source: ImageSource.gallery).catchError((error) {
      JPrint("错了 --- $error");
    });

    JPrint("拿到了");
    setState(() => _imageFile = File(pickedFile.path));
  }

  // void _pickImage() {
  //   _imagePicker.getImage(source: ImageSource.gallery).catchError((error) {
  //     JPrint("错了 --- $error");
  //   }).then((pickedFile) {
  //     JPrint("拿到了");
  //     setState(() => _imageFile = File(pickedFile.path));
  //   });
  // }
}