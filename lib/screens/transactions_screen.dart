import 'dart:ui';
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
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
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
          SafeArea(
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
                      child: _GlassTab(
                        label: timeTabs[i],
                        selected: i == selectedTab,
                        accent: blue,
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
                // Transactions list in a glass card
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _GlassCard(
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
        ],
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

class _GlassTab extends StatelessWidget {
  final String label;
  final bool selected;
  final Color? accent;
  const _GlassTab({required this.label, this.selected = false, this.accent});

  @override
  Widget build(BuildContext context) {
    final Color blue = accent ?? const Color(0xFF2979FF);
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: selected ? blue.withOpacity(0.18) : Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: selected ? blue.withOpacity(0.4) : Colors.transparent, width: 1.2),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? blue : Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
} 