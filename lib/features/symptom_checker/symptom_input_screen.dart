import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/colors.dart';
import '../../widgets/shared_widgets.dart';

class SymptomInputScreen extends StatefulWidget {
  const SymptomInputScreen({super.key});

  @override
  State<SymptomInputScreen> createState() => _SymptomInputScreenState();
}

class _SymptomInputScreenState extends State<SymptomInputScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'isAi': true,
      'text': 'I understand you are feeling discomfort in your Chest. How long have you been experiencing this?',
    },
  ];

  final List<String> _options = ['Less than an hour', 'Fews hours', 'A full day', 'More than 2 days'];
  int _currentStep = 0;

  void _addMessage(String text, bool isAi) {
    setState(() {
      _messages.add({'isAi': isAi, 'text': text});
    });

    if (!isAi && _currentStep == 0) {
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          _messages.add({
            'isAi': true,
            'text': 'On a scale of 1 to 10, how intense is the pain?',
          });
          _currentStep = 1;
        });
      });
    } else if (!isAi && _currentStep == 1) {
       Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          _messages.add({
            'isAi': true,
            'text': 'Are you experiencing any shortness of breath or dizziness?',
          });
          _currentStep = 2;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const MedFlowAppBar(title: 'AI Triage'),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / 4,
            backgroundColor: AppColors.divider,
            color: AppColors.primary,
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildChatBubble(msg['text'], msg['isAi']);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(String text, bool isAi) {
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isAi ? AppColors.surface : AppColors.primary,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isAi ? 0 : 16),
            bottomRight: Radius.circular(isAi ? 16 : 0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isAi ? AppColors.textPrimary : Colors.white,
            fontSize: 15,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    if (_currentStep == 0) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: _options.map((opt) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _addMessage(opt, false),
                child: Text(opt),
              ),
            ),
          )).toList(),
        ),
      );
    } else if (_currentStep == 1) {
       return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Mild'), Text('Moderate'), Text('Severe')],
            ),
            Slider(
              value: 7,
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (val) {},
            ),
            const SizedBox(height: 16),
            GradientButton(
              label: 'Confirm Intensity',
              onPressed: () => _addMessage('Intense (7/10)', false),
            ),
          ],
        ),
      );
    } else {
       return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => context.push('/symptom-checker/context'),
                child: const Text('No'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: GradientButton(
                label: 'Yes',
                onPressed: () => context.push('/symptom-checker/context'),
              ),
            ),
          ],
        ),
      );
    }
  }
}
