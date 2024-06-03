import 'package:flutter/material.dart';
import 'package:restaurantbooking/reviewpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedPackage = 'Fusion Package'; // Default selected package

  // Define package rates
  Map<String, int> packageRates = {
    'Fusion Package': 55,
    'Western Package': 58,
    'Thai Package': 50,
  };

  final TextEditingController _numberOfPeople = TextEditingController();
  final TextEditingController _discountController = TextEditingController();

  String _calculateTotalPayment(String numberOfPeople) {
    if (numberOfPeople.isEmpty) {
      return '0';
    }
    int peopleCount = int.tryParse(numberOfPeople) ?? 0;
    int ratePerPerson = packageRates[_selectedPackage] ?? 0;
    int totalPayment = peopleCount * ratePerPerson;
    return totalPayment.toString();
  }

  int _applyDiscount(int totalPayment, String discountText) {
    if (discountText.isEmpty) {
      return totalPayment;
    }

    // Check for valid voucher codes
    if (discountText.toUpperCase() == 'RAYA10') {
      return (totalPayment * 0.9).round();
    } else if (discountText.toUpperCase() == 'RAYA20') {
      return (totalPayment * 0.8).round();
    } else if (discountText.toUpperCase() == 'RAYA30') {
      return (totalPayment * 0.7).round();
    } else if (discountText.toUpperCase() == 'RAYA40') {
      return (totalPayment * 0.6).round();
    } else if (discountText.toUpperCase() == 'RAYA50') {
      return (totalPayment * 0.5).round();
    } else {
      // No valid voucher, apply no discount
      return totalPayment;
    }
  }

  void _submitForm() {
    // Validate number of people
    String numberOfPeopleText = _numberOfPeople.text.trim();
    if (numberOfPeopleText.isEmpty) {
      _showValidationError('Please enter the number of people');
      return;
    }

    int? peopleCount = int.tryParse(numberOfPeopleText);
    if (peopleCount == null || peopleCount <= 0) {
      _showValidationError('Please enter a valid number of people');
      return;
    }

    // Proceed with submission (e.g., navigate to next page)
    int totalPayment = int.tryParse(_calculateTotalPayment(numberOfPeopleText)) ?? 0;
    _applyDiscount(totalPayment, _discountController.text);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ReviewPage(),
      ),
    );
  }

  void _showValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: _selectedPackage,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPackage = newValue!;
                });
              },
              items: packageRates.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: _numberOfPeople,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Number of People",
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {}); // Trigger a rebuild to update the calculated total payment
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                enabled: false,
                controller: TextEditingController(
                  text: _calculateTotalPayment(_numberOfPeople.text),
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Total Payment",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                controller: _discountController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Voucher Code",
                ),
              ),
            ),
            // Apply Discount Button
            ElevatedButton(
              onPressed: () {
                setState(() {}); // Trigger a rebuild to update the discounted total payment
              },
              child: const Text("Apply Discount"),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: TextField(
                enabled: false,
                controller: TextEditingController(
                  text: _applyDiscount(
                    int.tryParse(_calculateTotalPayment(_numberOfPeople.text)) ?? 0,
                    _discountController.text,
                  ).toString(),
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Discounted Total Payment",
                ),
              ),
            ),
            // Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text("SUBMIT"),
            ),
          ],
        ),
      ),
    );
  }
}
