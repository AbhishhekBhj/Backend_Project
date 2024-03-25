import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mygymbuddy/features/graph/ui/graph_ui.dart';

import '../../measurements/ui/view_measurement_details.dart';

class ViewProgressOptions extends StatelessWidget {
  const ViewProgressOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Graphs'),
      ),
      body: SizedBox(
        height: Get.height,
        child: GridView(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2,
          ),
          children: [
            ProgressCard(
              onTap: () {
                Get.to(const MeasurementDetails());
              },
              title: 'Measurement Progress',
              icon: FontAwesomeIcons.weight,
              color: Colors.blue,
            ),
            ProgressCard(
              onTap: () {},
              title: 'Workout Progress',
              icon: FontAwesomeIcons.dumbbell,
              color: Colors.green,
            ),
            ProgressCard(
              onTap: () {},
              title: 'Water Intake Progress',
              icon: FontAwesomeIcons.glassWhiskey,
              color: Colors.orange,
            ),
            ProgressCard(
              onTap: () {
                Get.to(const Graph());
              },
              title: 'Nutrition Progress',
              icon: FontAwesomeIcons.utensils,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.color = Colors.blue,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48.0,
                color: color,
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
