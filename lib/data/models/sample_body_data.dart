import 'package:flutter/material.dart';

class SampleData {
  final String? title;
  final Color? color;
  final List<double>? data;

  SampleData({required this.title, required this.color, required this.data});
  final List<SampleData> datas = [
    SampleData(
      title: "ARMS",
      color: Colors.blue,
      data: [12.1, 12.2, 12.3, 12.4, 12.5, 12.6],
    ),
    SampleData(
      title: "lEGS",
      color: Colors.black,
      data: [20, 20.8, 21.6, 21.7, 22.3, 23.1],
    ),
    SampleData(
      title: "CHEST",
      color: Colors.orange,
      data: [42.4, 43.2, 44.9, 45.5, 46.6, 47.4],
    ),
    SampleData(
      title: "WAIST",
      color: Colors.red,
      data: [30.5, 30.2, 30, 30.3, 31, 31.3],
    ),
    SampleData(
      title: "BODY WEIGHT",
      color: Colors.green,
      data: [70, 71, 72, 73, 74, 75, 76],
    ),
  ];
}
