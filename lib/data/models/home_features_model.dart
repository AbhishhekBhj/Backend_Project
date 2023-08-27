import 'dart:ui';

class FeatureModel {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  FeatureModel({
    required this.image,
    required this.title,
    required this.subtitle,
     this.onTap,
  });
}
