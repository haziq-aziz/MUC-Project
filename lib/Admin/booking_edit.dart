// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurantbooking/JsonModels/booking.dart'; // Import MenuBook from the correct location
import '../services/database_service.dart';

class BookingEdit extends StatefulWidget {
  final MenuBook booking;

  const BookingEdit({super.key, required this.booking});

  @override
  _BookingEditState createState() => _BookingEditState();
}

class _BookingEditState extends State<BookingEdit> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _menuPackages = ['Package 1', 'Package 2', 'Package 3', 'Package 4', 'Package 5'];
  final List<double> _packagePrices = [50.0, 40.0, 30.0, 55.0, 35.0];
  final List<bool> _selectedPackages = [false, false, false, false, false];
  final List<TextEditingController> _guestControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  late DateTime _selectedEventDate;
  late TimeOfDay _selectedEventTime;
  double _totalPrice = 0.0;
  int _totalGuests = 0;

  @override
  void initState() {
    super.initState();
    _initializeSelectedPackagesAndGuests();
  }

  void _initializeSelectedPackagesAndGuests() {
    final selectedPackages = widget.booking.menuPackage.split(', ');
    for (int i = 0; i < _menuPackages.length; i++) {
      if (selectedPackages.contains(_menuPackages[i])) {
        _selectedPackages[i] = true;
        _guestControllers[i].text = widget.booking.numGuest.toString();
      }
    }
    _selectedEventDate = widget.booking.eventDate;
    _selectedEventTime = TimeOfDay(
      hour: widget.booking.eventTime.hour,
      minute: widget.booking.eventTime.minute,
    );
    _calculateTotal();
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime selectedDate,
    required TimeOfDay selectedTime,
    required ValueChanged<DateTime> onDateSelected,
    required ValueChanged<TimeOfDay> onTimeSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                controller: TextEditingController(text: DateFormat('yyyy-MM-dd').format(selectedDate)),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    onDateSelected(pickedDate);
                  }
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(labelText: 'Time (HH:MM)'),
                controller: TextEditingController(text: selectedTime.format(context)),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (pickedTime != null) {
                    onTimeSelected(pickedTime);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateTimePicker(
                    label: 'Event Date',
                    selectedDate: _selectedEventDate,
                    selectedTime: _selectedEventTime,
                    onDateSelected: (date) => setState(() => _selectedEventDate = date),
                    onTimeSelected: (time) => setState(() => _selectedEventTime = time),
                  ),
                  const Text(
                    '\n Menu Packages',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._menuPackages.asMap().entries.map((entry) {
                    final index = entry.key;
                    final package = entry.value;
                    return Column(
                      children: [
                        CheckboxListTile(
                          title: Text('$package (RM${_packagePrices[index]})'),
                          value: _selectedPackages[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedPackages[index] = value!;
                              _calculateTotal();
                            });
                          },
                        ),
                        if (_selectedPackages[index])
                          TextFormField(
                            controller: _guestControllers[index],
                            decoration: InputDecoration(labelText: 'Number of Guests for $package'),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (_selectedPackages[index] && value!.isEmpty) {
                                return 'Please enter number of guests for $package';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _calculateTotal();
                            },
                          ),
                      ],
                    );
                  }),
                  const SizedBox(height: 20),

                ],
              ),
              const SizedBox(height: 20),
              Text('Total Number of Guests: $_totalGuests'),
              Text('Total Price: RM$_totalPrice'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateTotal() {
    double totalPrice = 0.0;
    int totalGuests = 0;
    for (int i = 0; i < _selectedPackages.length; i++) {
      if (_selectedPackages[i]) {
        int numGuests = int.tryParse(_guestControllers[i].text) ?? 0;
        totalGuests += numGuests;
        totalPrice += _packagePrices[i] * numGuests;
      }
    }
    setState(() {
      _totalPrice = totalPrice;
      _totalGuests = totalGuests;
    });
  }

  Future<void> _updateBooking() async {
    if (_formKey.currentState!.validate()) {
      try {
        final selectedPackages = _menuPackages
            .asMap()
            .entries
            .where((entry) => _selectedPackages[entry.key])
            .map((entry) => entry.value)
            .join(', ');

        final eventDateTime = DateTime(
          _selectedEventDate.year,
          _selectedEventDate.month,
          _selectedEventDate.day,
          _selectedEventTime.hour,
          _selectedEventTime.minute,
        );

        final updatedBooking = MenuBook(
          bookId: widget.booking.bookId,
          userId: widget.booking.userId,
          bookDate: widget.booking.bookDate,
          bookTime: widget.booking.bookTime,
          eventDate: _selectedEventDate,
          eventTime: DateTime(0, 0, 0, _selectedEventTime.hour, _selectedEventTime.minute),
          menuPackage: selectedPackages,
          numGuest: _totalGuests,
          packagePrice: _totalPrice,
        );

        final db = DatabaseService();
        await db.updateBooking(
          updatedBooking.bookId,
          updatedBooking.menuPackage,
          eventDateTime,
          updatedBooking.numGuest,
          updatedBooking.packagePrice,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking updated successfully')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update booking')),
        );
      }
    }
  }

  void _submitForm() async {
    await _updateBooking();
  }
}
