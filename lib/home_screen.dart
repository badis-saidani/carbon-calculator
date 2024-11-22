import 'package:flutter/material.dart';
import 'result_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  double distance = 50; // Travel distance in km
  double electricity = 100; // Electricity in kWh
  double flights = 1; // Number of flights
  double waste = 2; // Waste in kg

  void _calculateAndNavigate() {
    double travelEmission = distance * 0.12; // kg CO2 per km
    double electricityEmission = electricity * 0.5; // kg CO2 per kWh
    double flightEmission = flights * 90; // kg CO2 per flight
    double wasteEmission = waste * 0.2; // kg CO2 per kg waste

    double totalEmission =
        travelEmission + electricityEmission + flightEmission + wasteEmission;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          totalEmission: totalEmission,
          breakdown: {
            'Travel': travelEmission,
            'Electricity': electricityEmission,
            'Flights': flightEmission,
            'Waste': wasteEmission,
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carbon Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSlider(
                label: 'Travel Distance (km)',
                value: distance,
                min: 0,
                max: 500,
                onChanged: (val) => setState(() => distance = val),
                unit: 'km',
              ),
              _buildSlider(
                label: 'Electricity Usage (kWh)',
                value: electricity,
                min: 0,
                max: 500,
                onChanged: (val) => setState(() => electricity = val),
                unit: 'kWh',
              ),
              _buildSlider(
                label: 'Flights Taken',
                value: flights,
                min: 0,
                max: 10,
                onChanged: (val) => setState(() => flights = val),
                unit: 'flights',
              ),
              _buildSlider(
                label: 'Waste Produced (kg)',
                value: waste,
                min: 0,
                max: 50,
                onChanged: (val) => setState(() => waste = val),
                unit: 'kg',
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _calculateAndNavigate,
                  child: Text('Calculate Carbon Emission'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
    required String unit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ($unit)',
          style: TextStyle(fontSize: 18),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 100,
          label: '${value.round()} $unit',
          onChanged: onChanged,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
