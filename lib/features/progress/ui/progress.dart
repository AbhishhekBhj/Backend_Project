import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ViewProgressOptions extends StatelessWidget {
  const ViewProgressOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
      ),
      body: GridView(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: Get.height * 0.1),
        children: [
          ProgressCard(
            onTap: () {},
            title: 'Measurement Progress',
            icon: FontAwesomeIcons.weight,
          ),
          ProgressCard(
            onTap: () {},
            title: 'Workout Progress',
            icon: FontAwesomeIcons.dumbbell,
          ),
          ProgressCard(
            onTap: () {},
            title: 'Water Intake Progress',
            icon: FontAwesomeIcons.glassWhiskey,
          ),
          ProgressCard(
            onTap: () {},
            title: 'Nutrition Progress',
            icon: FontAwesomeIcons.utensils,
          ),
        ],
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  ProgressCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.onTap});

  final String title;
  final IconData icon;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
              ),
              Icon(icon)
            ],
          ),
        ),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(3)),
      ),
    );
  }
}
