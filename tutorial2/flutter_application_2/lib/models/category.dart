import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String iconPath;
  final Color boxColor;

  CategoryModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });

  static List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories.add(
      CategoryModel(
        name: "Salad",
        iconPath: "Asset Chap 3 - Part 2/salad.svg",
        boxColor: const Color(0xff92A3FD),
      ),
    );

    categories.add(
      CategoryModel(
        name: "Cake",
        iconPath: "Asset Chap 3 - Part 2/cake.svg",
        boxColor: const Color(0xffC58BF2),
      ),
    );

    categories.add(
      CategoryModel(
        name: "Pie",
        iconPath: "Asset Chap 3 - Part 2/pie.svg",
        boxColor: const Color(0xff92A3FD),
      ),
    );

    return categories;
  }
}
