import 'package:chocaycanh/components/rotatewidget.dart';
import 'package:chocaycanh/constants.dart';
import 'package:chocaycanh/profile.dart';
import 'package:chocaycanh/token.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:chocaycanh/token.dart';
import 'package:chocaycanh/model/User.dart';
import 'package:chocaycanh/screens/profilescreen/avatar_interface.dart';

class UploadAvartar extends StatefulWidget {
  final Avatar_interface callback;

  const UploadAvartar({Key key, this.callback}) : super(key: key);
  @override
  _UploadAvartarState createState() => _UploadAvartarState();
}

class _UploadAvartarState extends State<UploadAvartar> {
  final GlobalKey _scaffoldKey = new GlobalKey();
  bool avatar_updated = true;
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 50,
          maxHeight: 500.0,
          maxWidth: 500.0);
      // var image = await ImagePicker.pickImage(source: imageSource, imageQuality: 50, maxHeight: 500.0, maxWidth: 500.0);
    });
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Đang tải ảnh...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return RotateWidget(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
            height: 200,
            width: 200,
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Lỗi không đọc được ảnh',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'Chưa có ảnh nào được chọn',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  String devicename = "app";
  Future<void> upload(String fileName) async {
    var request = http.MultipartRequest('POST', Uri.parse(linkuploadavatar));
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "multipart/form-data",
      "Authorization": "Bearer " + Token.token,
    }; // ignore this headers if there is no authentication
    request.headers.addAll(headers);

    final img.Image capturedImage =
        img.decodeImage(await tmpFile.readAsBytes());
    final img.Image orientedImage = img.bakeOrientation(capturedImage);

    final imageBytes = await tmpFile.readAsBytes();
    final compressedImageBytes =
        await FlutterImageCompress.compressWithList(imageBytes);
    // await image.writeAsBytes(compressedImageBytes);
    // return image;

    // request.files.add(http.MultipartFile.fromBytes(
    //     'file', tmpFile.readAsBytesSync(),
    //     filename: fileName.split("/").last));
    request.files.add(http.MultipartFile.fromBytes('file', compressedImageBytes,
        filename: fileName.split("/").last));

    var response = await request.send();

    print(response.stream);
    print(response.statusCode);
    final res = await http.Response.fromStream(response);
    print(res.body);
    var data = json.decode(res.body);
    var users = data['data'];
    var user = User.fromJson(users);
    var profile = Myprofile.fromUser(user);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('avatar', user.avatar);
    if (response.statusCode == 200) {
      Navigator.pop(context);
      widget.callback.updateAvatar(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tải ảnh avatar"),
      ),
      body: Container(
        key: _scaffoldKey,
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            OutlineButton(
              onPressed: chooseImage,
              child: Text('Chọn hình'),
            ),
            SizedBox(
              height: 20.0,
            ),
            showImage(),
            SizedBox(
              height: 20.0,
            ),
            OutlineButton(
              onPressed: startUpload,
              child: Text('Lưu ảnh'),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
          ],
        ),
      ),
    );
  }
}
