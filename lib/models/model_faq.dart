import 'dart:ui';

class ModelFaq {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;
  String img;

  ModelFaq({
    this.expanded = false,
    required this.headerItem,
    required this.discription,
    required this.colorsItem,
    required this.img});
}