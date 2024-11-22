import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResultScreen extends StatelessWidget {
  final double totalEmission;
  final Map<String, double> breakdown;

  const ResultScreen({Key? key, required this.totalEmission, required this.breakdown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Carbon Footprint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Total Carbon Emission:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              '${totalEmission.toStringAsFixed(2)} kg CO2',
              style: TextStyle(fontSize: 36, color: Colors.green),
            ),
            SizedBox(height: 32),
            Text(
              'Emission Breakdown',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: breakdown.entries
                      .map(
                        (entry) => PieChartSectionData(
                          value: entry.value,
                          title: '${entry.key} (${entry.value.toStringAsFixed(1)} kg)',
                          color: _getColor(entry.key),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Tips to Reduce Carbon Emission:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ..._buildTips(),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Recalculate'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildTips() {
    return [
      Text('- Use public transportation or carpool.'),
      Text('- Switch to energy-efficient appliances.'),
      Text('- Reduce air travel or opt for carbon offsets.'),
      Text('- Recycle and compost waste.'),
    ].map((tip) => Padding(padding: const EdgeInsets.all(4.0), child: tip)).toList();
  }

  Color _getColor(String key) {
    switch (key) {
      case 'Travel':
        return Colors.blue;
      case 'Electricity':
        return Colors.orange;
      case 'Flights':
        return Colors.red;
      case 'Waste':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
