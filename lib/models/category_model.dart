import 'package:flutter/material.dart';

enum CategoryType { income, expense }

class CategoryModel {
  final String id;
  final String name;
  final IconData icon;
  final CategoryType type;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.type,
  });
} 