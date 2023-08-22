// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

class FeatureModel {
  final String image;
  final String title;
  final VoidCallback? onTap;
  final String subtitle;
  FeatureModel({
    required this.image,
    required this.title,
    this.onTap,
    required this.subtitle,
  });

  
}
