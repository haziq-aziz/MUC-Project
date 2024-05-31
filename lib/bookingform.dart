import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'services/database_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BookingForm(),
    );
  }
}

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _numGuestController = TextEditingController();
  final List<String> _menuPackages = ['Package 1', 'Package 2', 'Package 3'];
  final List<bool> _selectedPackages = [false, false, false];
  DateTime? _selectedBookDate;
  TimeOfDay? _selectedBookTime;
  DateTime? _selectedEventDate;
  TimeOfDay? _selectedEventTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your name' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your phone number' : null,
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a username' : null,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a password' : null,
              ),
              const SizedBox(height: 20),
              _buildDateTimePicker(
                label: 'Booking Date',
                selectedDate: _selectedBookDate,
                selectedTime: _selectedBookTime,
                onDateSelected: (date) =>
                    setState(() => _selectedBookDate = date),
                onTimeSelected: (time) =>
                    setState(() => _selectedBookTime = time),
              ),
              _buildDateTimePicker(
                label: 'Event Date',
                selectedDate: _selectedEventDate,
                selectedTime: _selectedEventTime,
                onDateSelected: (date) =>
                    setState(() => _selectedEventDate = date),
                onTimeSelected: (time) =>
                    setState(() => _selectedEventTime = time),
              ),
              const SizedBox(height: 20),
              const Text('Menu Packages'),
              ..._menuPackages.asMap().entries.map((entry) {
                int index = entry.key;
                String package = entry.value;
                return CheckboxListTile(
                  title: Text(package),
                  value: _selectedPackages[index],
                  onChanged: (value) {
                    setState(() {
                      _selectedPackages[index] = value!;
                    });
                  },
                );
              }),
              TextFormField(
                controller: _numGuestController,
                decoration:
                    const InputDecoration(labelText: 'Number of Guests'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter number of guests' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime? selectedDate,
    required TimeOfDay? selectedTime,
    required ValueChanged<DateTime> onDateSelected,
    required ValueChanged<TimeOfDay> onTimeSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Row(
          children: [
            TextButton(
              onPressed: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (date != null) onDateSelected(date);
              },
              child: Text(selectedDate != null
                  ? DateFormat.yMd().format(selectedDate)
                  : 'Select Date'),
            ),
            TextButton(
              onPressed: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) onTimeSelected(time);
              },
              child: Text(selectedTime != null
                  ? selectedTime.format(context)
                  : 'Select Time'),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Save the data to the database
      String name = _nameController.text;
      String email = _emailController.text;
      int phone = int.parse(_phoneController.text);
      String username = _usernameController.text;
      String password = _passwordController.text;
      int numGuest = int.parse(_numGuestController.text);
      String menuPackage = _menuPackages
          .asMap()
          .entries
          .where((entry) => _selectedPackages[entry.key])
          .map((entry) => entry.value)
          .join(', ');

      DateTime bookDateTime = DateTime(
        _selectedBookDate!.year,
        _selectedBookDate!.month,
        _selectedBookDate!.day,
        _selectedBookTime!.hour,
        _selectedBookTime!.minute,
      );

      DateTime eventDateTime = DateTime(
        _selectedEventDate!.year,
        _selectedEventDate!.month,
        _selectedEventDate!.day,
        _selectedEventTime!.hour,
        _selectedEventTime!.minute,
      );

      await DatabaseService().insertUser(
        name,
        email,
        phone,
        username,
        password,
      );

      int userId = await DatabaseService().getUserIdByUsername(username);

      await DatabaseService().insertBooking(
        userId,
        bookDateTime,
        eventDateTime,
        menuPackage,
        numGuest,
        0.0, // Example package price, replace with actual logic
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Booking successful')));
    }
  }
}
