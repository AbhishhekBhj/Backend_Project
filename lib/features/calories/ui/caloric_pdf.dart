import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart'; // Import the fluttertoast package

Future<void> saveAndOpenPdf(List<int> bytes, String fileName) async {
  try {
    final directory = await getExternalStorageDirectory();
    final path = directory!.path;
    final File file = File('$path/$fileName');
    await file.writeAsBytes(bytes);
    OpenFile.open(file.path);
  } catch (e) {
    print('Error saving or opening PDF: $e');
    Fluttertoast.showToast(
      msg: 'Error: $e',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}
