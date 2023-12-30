import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({super.key});

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 100,
                 
                ),
                IconButton(
                  onPressed: () {
                    // Handle camera icon click
                  },
                  icon: Icon(Icons.camera_alt),
                  color: Colors.black,
                  iconSize: 32.0,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("DONE"),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.1, vertical: 20),
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
