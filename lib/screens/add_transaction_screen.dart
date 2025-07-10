import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/category_data.dart';
import '../models/category_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _selectedCategory = 'food';
  DateTime _selectedDate = DateTime.now();
  final Color blue = const Color(0xFF2979FF);

  @override
  Widget build(BuildContext context) {
    final categories = CategoryData.categories.where((c) => c.type == CategoryType.expense).toList();
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Add Payment', style: TextStyle(color: Colors.black)),
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
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _GlassCard(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Amount
                      const Text('Amount', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          prefixText: 'USD  ',
                          prefixStyle: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.w600, fontSize: 18),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Category
                      const Text('Select Category', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: categories.map((cat) => ChoiceChip(
                          label: Text(cat.name),
                          avatar: Icon(cat.icon, size: 18, color: _selectedCategory == cat.id ? Colors.white : blue),
                          selected: _selectedCategory == cat.id,
                          selectedColor: blue,
                          backgroundColor: Colors.grey[100],
                          labelStyle: TextStyle(color: _selectedCategory == cat.id ? Colors.white : Colors.black87, fontWeight: FontWeight.w500),
                          onSelected: (_) => setState(() => _selectedCategory = cat.id),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                        )).toList(),
                      ),
                      const SizedBox(height: 24),
                      // Note
                      const Text('Write Note', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          hintText: 'Enter a note...',
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Date
                      const Text('Set Date', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: _selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (picked != null) setState(() => _selectedDate = picked);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            '${_selectedDate.day} ${_selectedDate.month}, ${_selectedDate.year}',
                            style: const TextStyle(fontSize: 16, color: Colors.black87),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Save button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            elevation: 2,
                          ),
                          onPressed: () {}, // TODO: Save transaction
                          child: const Text('Save', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
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