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
      title: 'Grocery',
      amount: 240.0,
      date: DateTime.now().subtract(const Duration(days: 1)),
      category: 'food',
    ),
    TransactionModel(
      id: '2',
      title: 'Cash From ATM',
      amount: 120.0,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'shopping',
    ),
    TransactionModel(
      id: '3',
      title: 'Amazon',
      amount: 200.0,
      date: DateTime.now().subtract(const Duration(days: 3)),
      category: 'shopping',
    ),
    TransactionModel(
      id: '4',
      title: 'Restaurant',
      amount: 30.0,
      date: DateTime.now().subtract(const Duration(days: 4)),
      category: 'food',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Color blue = const Color(0xFF2979FF);
    final List<String> timeTabs = ['Weekly', 'Monthly', 'Yearly', 'All time'];
    int selectedTab = 1; // Monthly by default

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time range tabs
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(timeTabs.length, (i) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(timeTabs[i], style: TextStyle(fontWeight: FontWeight.w600)),
                    selected: i == selectedTab,
                    selectedColor: blue.withOpacity(0.1),
                    backgroundColor: Colors.grey[100],
                    labelStyle: TextStyle(color: i == selectedTab ? blue : Colors.black87),
                    onSelected: (_) {}, // TODO: Implement tab switching
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  ),
                )),
              ),
            ),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search transactions',
                  prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Transactions list in a card
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: transactions.length,
                    separatorBuilder: (context, i) => Divider(indent: 72, endIndent: 16, color: Colors.grey[200]),
                    itemBuilder: (context, i) {
                      final tx = transactions[i];
                      final cat = CategoryData.categories.firstWhere((c) => c.id == tx.category, orElse: () => CategoryData.categories.last);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: blue.withOpacity(0.08),
                          child: Icon(cat.icon, color: blue, size: 22),
                        ),
                        title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(DateFormat.yMMMd().format(tx.date), style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                        trailing: Text(
                          '-${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        onTap: () {}, // TODO: Edit transaction
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () {}, // TODO: Add transaction
        child: const Icon(Icons.add, color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
      ),
    );
  }
} 