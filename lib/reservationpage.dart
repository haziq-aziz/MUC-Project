import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  DateTime? selectedDate; // Variable to store the selected date

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4B9EA6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Padding (padding: const EdgeInsets.only(top:60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Reservation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  readOnly: true,
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: selectedDate != null
                        ? DateFormat('dd MMM yyyy').format(selectedDate!)
                        : 'Select Date',
                    hintStyle: TextStyle(
                      color: selectedDate != null ? Colors.black : Colors.grey[400],
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onTap: () async {
                    // Show date picker
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      // Update selected date
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Time',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  keyboardType: TextInputType.datetime,
                  onTap: () async {
                    // Show time picker
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Additional Request',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  style: const TextStyle(color: Colors.grey, fontSize: 18),
                  decoration: InputDecoration(
                    hintText: 'Number of guests',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Handle reservation logic
                },
                child: Text('Book Now'),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }
}
