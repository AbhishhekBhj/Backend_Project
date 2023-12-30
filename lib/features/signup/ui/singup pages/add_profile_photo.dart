import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/home/ui/common_ui.dart';
import 'package:mygymbuddy/features/home/ui/homee.dart';
import 'package:mygymbuddy/provider/themes/theme_provider.dart';
import 'package:mygymbuddy/utils/texts/texts.dart';
import 'package:provider/provider.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({super.key});

  @override
  State<AddProfilePhoto> createState() => _AddProfilePhotoState();
}

class _AddProfilePhotoState extends State<AddProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool isDarkMode = themeProvider.getTheme == themeProvider.darkTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundColor:
                      isDarkMode ? Colors.white30 : Colors.deepPurpleAccent,
                  radius: 100,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.camera_alt),
                  color: isDarkMode
                      ? Colors.grey.shade400
                      : Colors.deepPurpleAccent,
                  iconSize: 32.0,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.1,
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(BaseClass());
              },
              style: isDarkMode
                  ? ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade400,
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.1, vertical: 20),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    )
                  : ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.1, vertical: 20),
                      foregroundColor: Colors.grey.shade400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
              child: const Text("DONE"),
            ),
          ],
        ),
      ),
    );
  }
}
