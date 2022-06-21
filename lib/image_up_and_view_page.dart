import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageUploadAndViewPage extends StatefulWidget {
  @override
  _ImageUploadAndViewPagetState createState() =>
      _ImageUploadAndViewPagetState();
}

class _ImageUploadAndViewPagetState extends State<ImageUploadAndViewPage> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imageList = [];// list of file
  List<String> _imageNameList = [];// list of file name

  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.green,
        elevation: 0,
        title: Text('Multiple Image Picker',
            style: GoogleFonts.comfortaa(
                color: const Color(0xFFFFFFFF), fontWeight: FontWeight.w900)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                child: OutlinedButton(
                  onPressed: () async {
                    await _handlePhotoUpload(Permission.storage);
                    selectImage();
                  },
                  child: Text('Choose Image'),
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: _imageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 20,
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          children: <Widget>[
                            Image.file(
                              File(_imageList[index].path),
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              right: 5,
                              top: 5,
                              child: InkWell(
                                child: Icon(
                                  Icons.remove_circle,
                                  size: 25,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  setState(() {
                                    _imageList.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePhotoUpload(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

  void selectImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage!.path.isNotEmpty) {
      _imageList.add(selectedImage);
      _imageNameList.add(selectedImage.name);
    }
    print('aksfhksalhfqxiwghfoewrhig');
    print(_imageNameList);
    setState(() {});
  }
}
