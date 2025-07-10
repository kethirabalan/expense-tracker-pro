import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double balance = 301.95;
    final List<double> monthlyTrends = [200, 250, 180, 220, 301.95];
    final List<String> months = ['jul', 'aug', 'sep', 'oct', 'nov', 'dec'];
    final List<Map<String, dynamic>> quickActions = [
      {'icon': Icons.account_balance_wallet, 'label': 'balance'},
      {'icon': Icons.trending_up, 'label': 'income'},
      {'icon': Icons.trending_down, 'label': 'expenses'},
      {'icon': Icons.fastfood, 'label': 'food'},
      {'icon': Icons.flight, 'label': 'travel'},
      {'icon': Icons.emoji_emotions, 'label': 'fun'},
      {'icon': Icons.beach_access, 'label': 'retire'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            // Quick actions (as in the leftmost reference screen)
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: quickActions.map((action) => Chip(
                backgroundColor: Colors.grey[100],
                label: Text(action['label'], style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
                avatar: Icon(action['icon'], color: Colors.black54, size: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              )).toList(),
            ),
            const SizedBox(height: 24),
            // Large balance
            Text(
              ' 24${balance.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: -2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Month selector (minimal, just text for now)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('this month', style: TextStyle(color: Colors.grey[600], fontSize: 16)),
                const SizedBox(width: 8),
                Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 20),
              ],
            ),
            const SizedBox(height: 24),
            // Simple line chart
            SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(monthlyTrends.length, (i) => FlSpot(i.toDouble(), monthlyTrends[i])),
                        isCurved: true,
                        color: Colors.black,
                        barWidth: 3,
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
            const SizedBox(height: 16),
            // Minimal divider
            Container(height: 1, color: Colors.grey[200], margin: const EdgeInsets.symmetric(horizontal: 16)),
            // You can add more minimal widgets here (e.g., recent transactions preview)
          ],
        ),
      ),
    );
  }
} 