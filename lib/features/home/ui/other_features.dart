import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mygymbuddy/widgets/widgets.dart';

class OtherFeaturePage extends StatelessWidget {
  const OtherFeaturePage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Function to create decorated ListTiles with onTap
    Widget _buildDecoratedListTile(IconData icon, VoidCallback? onTap) {
      return GestureDetector(
        onTap: onTap, // Assign the onTap callback to the GestureDetector
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4), // Adjust margin as needed
          decoration: BoxDecoration(
            border: Border.all(
                color: Colors.grey), // Add a border around the ListTile
            borderRadius: BorderRadius.circular(10), // Add rounded corners
          ),
          child: ListTile(
            leading: Icon(icon),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          _buildDecoratedListTile(
            FontAwesomeIcons.noteSticky,
            () {
              // Add your logic for onTap here
              print("object");

              // This function will be called when the ListTile is tapped
            },
          ),
          _buildDecoratedListTile(
            FontAwesomeIcons.book,
            () {
              // Add your logic for onTap here
              print("object");
            },
          ),
          _buildDecoratedListTile(
            FontAwesomeIcons.glassWater,
            () {
              // Add your logic for onTap here
              print("object");
            },
          ),
          _buildDecoratedListTile(
            Icons.history_outlined,
            () {
              // Add your logic for onTap here
              print("object");
            },
          ),
          _buildDecoratedListTile(
            Icons.person,
            () {
              print("object");
            },
          ),
        ],
      ),
    );
  }
}
