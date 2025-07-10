import 'package:flutter/material.dart';
import '../models/category_data.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data: categoryId -> [budget, spent]
    final Map<String, List<double>> budgets = {
      'food': [1000, 800],
      'shopping': [900, 700],
      'transport': [500, 400],
      'entertainment': [400, 300],
      'utilities': [300, 250],
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Budget')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: budgets.entries.map((entry) {
          final cat = CategoryData.categories.firstWhere((c) => c.id == entry.key, orElse: () => CategoryData.categories.last);
          final budget = entry.value[0];
          final spent = entry.value[1];
          final percent = (spent / budget).clamp(0.0, 1.0);
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(child: Icon(cat.icon)),
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
                    color: percent < 0.8 ? Theme.of(context).colorScheme.primary : Colors.red,
                    backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // TODO: Add/Edit budget
        child: const Icon(Icons.add),
      ),
    );
  }
} 