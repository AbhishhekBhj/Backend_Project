import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class OTPScreen extends StatefulWidget {
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  OtpFieldController _otpController = OtpFieldController();
  String otp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              const Text(
                'Enter the OTP sent to your email address',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              OTPTextField(
                controller: _otpController,
                length: 4,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 50,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: const TextStyle(fontSize: 20, color: Colors.black),
                onChanged: (pin) {
                  setState(() {
                    otp = pin;
                  });
                },
                onCompleted: (pin) {
                  setState(() {
                    otp = pin;
                  });
                },
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  print('Verify OTP');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  var result = await http.get(Uri.parse(
                      'http://10.0.2.2:8000/api/export/waterintake/Aviskar/'));
                  var decodedData = jsonDecode(result.body);
                  log(decodedData["data"].runtimeType.toString());
                  createExcelSheet(decodedData["data"]);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Resend OTP',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createExcelSheet(List<dynamic> data) async {
    log('Creating Excel sheet...');
    var excel = Excel. createExcel();

    // Create a Sheet
    var sheet = excel['Water Intake Data'];

    // Add header row
    sheet.appendRow(
        [const TextCellValue('Timestamp'), const TextCellValue('Volume')]);

    // Add data rows
    for (var entry in data) {
      sheet.appendRow([
        TextCellValue(entry['timestamp']),
        // TextCellValue(entry['volume'.toString()])
      ]);
    }

    // Save the Excel file
    var directory = await getExternalStorageDirectory();
    var filePath = join(directory!.path, 'water_intake_data.xlsx');
    var fileBytes = excel.encode();

    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    log('Excel file generated successfully: $filePath');
  }
}
