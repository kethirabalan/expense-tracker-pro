import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double balance = 5345.43;
    final List<double> monthlyTrends = [2000, 2500, 1800, 2200, 5345.43];
    final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
    final Color blue = const Color(0xFF2979FF);
    final List<Map<String, dynamic>> transactions = [
      {'icon': Icons.shopping_cart, 'title': 'Grocery', 'subtitle': 'Jun 12, 2023', 'amount': 240},
      {'icon': Icons.account_balance_wallet, 'title': 'Cash From ATM', 'subtitle': 'Jun 10, 2023', 'amount': 120},
      {'icon': Icons.shopping_bag, 'title': 'Amazon', 'subtitle': 'Jun 9, 2023', 'amount': 200},
    ];

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
          // Main content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Tabs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _GlassTab(label: 'Weekly', selected: false),
                      const SizedBox(width: 8),
                      _GlassTab(label: 'Monthly', selected: true, accent: blue),
                      const SizedBox(width: 8),
                      _GlassTab(label: 'Yearly', selected: false),
                      const SizedBox(width: 8),
                      _GlassTab(label: 'All time', selected: false),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Balance Card
                  _GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 8),
                        Text('Total Expenses', style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 16)),
                        const SizedBox(height: 8),
                        Text(
                          ' 24${balance.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: blue,
                            letterSpacing: -2,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Chart Card
                  _GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0, bottom: 8),
                            child: Text('Spending Trend', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ),
                          SizedBox(
                            height: 120,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: LineChart(
                                LineChartData(
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots: List.generate(monthlyTrends.length, (i) => FlSpot(i.toDouble(), monthlyTrends[i])),
                                      isCurved: true,
                                      color: blue,
                                      barWidth: 4,
                                      dotData: FlDotData(show: false),
                                    ),
                                  ],
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) {
                                          if (value.toInt() < 0 || value.toInt() >= months.length) return const SizedBox();
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(months[value.toInt()], style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  gridData: FlGridData(show: false),
                                  minY: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Transactions Card
                  _GlassCard(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 8.0, bottom: 8),
                            child: Text('Transactions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ),
                          ...transactions.map((tx) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: blue.withOpacity(0.08),
                                  child: Icon(tx['icon'], color: blue, size: 22),
                                ),
                                title: Text(tx['title'], style: const TextStyle(fontWeight: FontWeight.w600)),
                                subtitle: Text(tx['subtitle'], style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                                trailing: Text(
                                  '-${tx['amount'].toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
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