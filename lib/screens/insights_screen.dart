import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/category_data.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final Map<String, double> categorySpending = {
      'food': 800,
      'shopping': 700,
      'transport': 400,
      'entertainment': 300,
      'utilities': 250,
    };
    final List<double> monthlyTrends = [1200, 1500, 1800, 2100, 2450];
    final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
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
                    const Text('Spending by Category', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: List.generate(categorySpending.length, (i) {
                            final color = Colors.primaries[i % Colors.primaries.length];
                            return PieChartSectionData(
                              color: color,
                              value: categorySpending.values.elementAt(i),
                              title: '',
                              radius: 60,
                            );
                          }),
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      children: List.generate(categorySpending.length, (i) {
                        final cat = CategoryData.categories.firstWhere((c) => c.id == categorySpending.keys.elementAt(i), orElse: () => CategoryData.categories.last);
                        final color = Colors.primaries[i % Colors.primaries.length];
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(width: 12, height: 12, color: color),
                            const SizedBox(width: 6),
                            Text(cat.name, style: const TextStyle(fontSize: 13)),
                          ],
                        );
                      }),
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
                    const Text('Spending Trend', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: List.generate(monthlyTrends.length, (i) => FlSpot(i.toDouble(), monthlyTrends[i])),
                              isCurved: true,
                              color: Theme.of(context).colorScheme.primary,
                              barWidth: 4,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  if (value.toInt() < 0 || value.toInt() >= months.length) return const SizedBox();
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(months[value.toInt()]),
                                  );
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: true),
                          minY: 0,
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