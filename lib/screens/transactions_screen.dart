import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction_model.dart';
import '../models/category_data.dart';
import '../models/category_model.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  // Dummy data for now
  List<TransactionModel> get transactions => [
    TransactionModel(
      id: '1',
      title: 'Groceries',
      amount: 50.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'food',
    ),
    TransactionModel(
      id: '2',
      title: 'Salary',
      amount: 2000.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
      category: 'salary',
    ),
    TransactionModel(
      id: '3',
      title: 'Rent',
      amount: 1500.0,
      date: DateTime.now().subtract(const Duration(days: 10)),
      category: 'home',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<TransactionModel>>{};
    for (var tx in transactions) {
      final month = DateFormat('MMMM yyyy').format(tx.date);
      grouped.putIfAbsent(month, () => []).add(tx);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: grouped.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(entry.key, style: Theme.of(context).textTheme.titleLarge),
              ),
              ...entry.value.map((tx) => Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(CategoryData.categories.firstWhere((c) => c.id == tx.category, orElse: () => CategoryData.categories.last).icon),
                  ),
                  title: Text(tx.title),
                  subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                  trailing: Text(
                    (CategoryData.categories.firstWhere((c) => c.id == tx.category, orElse: () => CategoryData.categories.last).type == CategoryType.income ? '+' : '-') +
                    NumberFormat.simpleCurrency().format(tx.amount),
                    style: TextStyle(
                      color: CategoryData.categories.firstWhere((c) => c.id == tx.category, orElse: () => CategoryData.categories.last).type == CategoryType.income
                        ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {}, // TODO: Edit transaction
                  onLongPress: () {}, // TODO: Delete transaction
                ),
              )),
            ],
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // TODO: Add transaction
        child: const Icon(Icons.add),
      ),
    );
  }
} 