import 'package:flutter/material.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class VitalsEntryScreen extends StatefulWidget {
  const VitalsEntryScreen({super.key});

  @override
  State<VitalsEntryScreen> createState() => _VitalsEntryScreenState();
}

class _VitalsEntryScreenState extends State<VitalsEntryScreen> {
  String _selectedVital = 'Blood Pressure';
  final List<String> _vitalTypes = ['Blood Pressure', 'Heart Rate', 'Blood Glucose', 'SpO2', 'Body Temperature'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'Log New Reading'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Vital Type',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedVital,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.analytics_outlined)),
              items: _vitalTypes.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
              onChanged: (val) => setState(() => _selectedVital = val!),
              dropdownColor: AppColors.surface,
            ),
            const SizedBox(height: 32),
            if (_selectedVital == 'Blood Pressure') _buildBPInput() else _buildSingleValueInput(),
            const SizedBox(height: 24),
            Text('Date & Time', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            TextField(
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'Today, 10:45 AM',
                prefixIcon: Icon(Icons.access_time_rounded),
                suffixIcon: Icon(Icons.calendar_today_outlined, size: 18),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 24),
            Text('Optional Note', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            const TextField(
              decoration: InputDecoration(
                hintText: 'e.g. Taken after exercise...',
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 48),
            GradientButton(
              label: 'Save Reading',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Vital reading logged successfully.')),
                );
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildBPInput() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Systolic (Top)', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 8),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: '120', suffixText: 'mmHg'),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Diastolic (Bottom)', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 8),
              const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: '80', suffixText: 'mmHg'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSingleValueInput() {
    String unit = '';
    String hint = '';
    switch (_selectedVital) {
      case 'Heart Rate': unit = 'bpm'; hint = '72'; break;
      case 'Blood Glucose': unit = 'mg/dL'; hint = '90'; break;
      case 'SpO2': unit = '%'; hint = '98'; break;
      case 'Body Temperature': unit = '°C'; hint = '36.6'; break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reading Value', style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: hint, suffixText: unit),
        ),
      ],
    );
  }
}
