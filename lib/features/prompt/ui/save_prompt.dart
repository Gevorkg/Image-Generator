// image_saver.dart
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveImage(Uint8List imageBytes, BuildContext context) async {
  try {
    _showLoadingOverlay(context);

    await Future.delayed(Duration(seconds: 2));

    final directory = await getTemporaryDirectory();

    final imagePath = '${directory.path}/downloaded_image.png';
    final file = File(imagePath);

    await file.writeAsBytes(imageBytes);

    await GallerySaver.saveImage(file.path);

    Navigator.of(context).pop();

    _showLoadedOverlay(context);

    await Future.delayed(Duration(milliseconds: 500));

    Navigator.of(context).pop();
  } catch (e) {
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save image: $e')),
    );
  }
}

void _showLoadingOverlay(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                "Downloading...",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void _showLoadedOverlay(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                "Sucess!",
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      );
    },
  );
}
