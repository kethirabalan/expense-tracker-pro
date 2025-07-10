import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/category_data.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color blue = const Color(0xFF2979FF);
    // Dummy data: categoryId -> [budget, spent]
    final Map<String, List<double>> budgets = {
      'food': [1000, 800],
      'shopping': [900, 700],
      'transport': [500, 400],
      'entertainment': [400, 300],
      'utilities': [300, 250],
    };
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Budget', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFe3f0ff), Color(0xFFf8fbff)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.all(20),
            children: budgets.entries.map((entry) {
              final cat = CategoryData.categories.firstWhere((c) => c.id == entry.key, orElse: () => CategoryData.categories.last);
              final budget = entry.value[0];
              final spent = entry.value[1];
              final percent = (spent / budget).clamp(0.0, 1.0);
              return _GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(child: Icon(cat.icon, color: blue), backgroundColor: blue.withOpacity(0.08)),
                          const SizedBox(width: 16),
                          Expanded(child: Text(cat.name, style: Theme.of(context).textTheme.titleMedium)),
                          Text(' 24${budget.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      LinearProgressIndicator(
                        value: percent,
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(8),
                        color: percent < 0.8 ? blue : Colors.red,
                        backgroundColor: blue.withOpacity(0.08),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Spent:  24${spent.toStringAsFixed(0)}'),
                          Text('${(percent * 100).toStringAsFixed(0)}%'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () {}, // TODO: Add/Edit budget
        child: const Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.2),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
} 