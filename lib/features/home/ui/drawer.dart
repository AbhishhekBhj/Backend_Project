import 'package:flutter/material.dart';
import 'package:mygymbuddy/colours/colours.dart';
import 'package:mygymbuddy/texts/texts.dart';

class MyDrawer extends StatelessWidget implements PreferredSizeWidget {
  MyDrawer({Key? key}) : super(key: key);
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth * 0.5,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.all(20.9),
                decoration: BoxDecoration(
                  color: MyColors.accentPurple,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(stretchingImage),
                      backgroundColor: Colors.white,
                      radius: 30,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Username here',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'User Email here',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.help_center),
                title: Text('Help & Support'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text('About Us'),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
