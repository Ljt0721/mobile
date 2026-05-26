import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  double bmi = 0.0;

  bool showBmi = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Height in cm',
              ),
              controller: heightController,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Weight in KG',
              ),
              controller: weightController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  double height = double.parse(heightController.text);
                  double weight = double.parse(weightController.text);
                  bmi = (weight / (height * height)) * 10000;
                  showBmi = true;
                });
              },
              child: const Text('Calculate', style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 20),
            showBmi
                ? Text(
                    'bmi: ${bmi.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 30),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
