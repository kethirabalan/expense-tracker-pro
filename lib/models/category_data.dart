import 'package:flutter/material.dart';
import 'category_model.dart';

class CategoryData {
  static const List<CategoryModel> categories = [
    // Income
    CategoryModel(id: 'salary', name: 'Salary', icon: Icons.attach_money, type: CategoryType.income),
    CategoryModel(id: 'freelance', name: 'Freelance', icon: Icons.work, type: CategoryType.income),
    CategoryModel(id: 'investments', name: 'Investments', icon: Icons.trending_up, type: CategoryType.income),
    // Expenses
    CategoryModel(id: 'food', name: 'Food & Drinks', icon: Icons.restaurant, type: CategoryType.expense),
    CategoryModel(id: 'shopping', name: 'Shopping', icon: Icons.shopping_bag, type: CategoryType.expense),
    CategoryModel(id: 'transport', name: 'Transportation', icon: Icons.directions_car, type: CategoryType.expense),
    CategoryModel(id: 'home', name: 'Home', icon: Icons.home, type: CategoryType.expense),
    CategoryModel(id: 'utilities', name: 'Utilities', icon: Icons.receipt_long, type: CategoryType.expense),
    CategoryModel(id: 'entertainment', name: 'Entertainment', icon: Icons.movie, type: CategoryType.expense),
    CategoryModel(id: 'travel', name: 'Travel', icon: Icons.flight, type: CategoryType.expense),
    CategoryModel(id: 'health', name: 'Health', icon: Icons.favorite, type: CategoryType.expense),
    CategoryModel(id: 'education', name: 'Education', icon: Icons.school, type: CategoryType.expense),
    CategoryModel(id: 'gifts', name: 'Gifts', icon: Icons.card_giftcard, type: CategoryType.expense),
    CategoryModel(id: 'other', name: 'Other', icon: Icons.help_outline, type: CategoryType.expense),
  ];
} 