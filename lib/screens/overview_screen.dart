import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/category_data.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final double monthlySpending = 2450;
    final double lastMonthSpending = 2130;
    final double percentChange = ((monthlySpending - lastMonthSpending) / lastMonthSpending) * 100;
    final Map<String, double> categorySpending = {
      'food': 800,
      'transport': 400,
      'entertainment': 300,
      'utilities': 250,
      'shopping': 700,
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Spending Overview')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Monthly Spending', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      ' 24${monthlySpending.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(
                          'This Month ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          (percentChange >= 0 ? '+' : '') + percentChange.toStringAsFixed(1) + '%',
                          style: TextStyle(
                            color: percentChange >= 0 ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Spending by Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 220,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 1000,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  final keys = categorySpending.keys.toList();
                                  if (value.toInt() < 0 || value.toInt() >= keys.length) return const SizedBox();
                                  final cat = CategoryData.categories.firstWhere((c) => c.id == keys[value.toInt()], orElse: () => CategoryData.categories.last);
                                  return Column(
                                    children: [
                                      Icon(cat.icon, size: 20),
                                      Text(cat.name.split(' ')[0], style: const TextStyle(fontSize: 12)),
                                    ],
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: List.generate(categorySpending.length, (i) {
                            return BarChartGroupData(
                              x: i,
                              barRods: [
                                BarChartRodData(
                                  toY: categorySpending.values.elementAt(i),
                                  color: Theme.of(context).colorScheme.primary,
                                  width: 24,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 