import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurantbooking/Admin/booking_list.dart';
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

  late TextEditingController _menuPackageController;
  late TextEditingController _eventDateController;
  late TextEditingController _eventTimeController;
  late TextEditingController _numGuestController;
  late TextEditingController _packagePriceController;

  @override
  void initState() {
    super.initState();
    _menuPackageController = TextEditingController(text: widget.booking.menuPackage);
    _eventDateController = TextEditingController(
        text: DateFormat('yyyy-MM-dd').format(widget.booking.eventDate));
    _eventTimeController = TextEditingController(
        text: DateFormat('HH:mm').format(widget.booking.eventTime));
    _numGuestController = TextEditingController(text: widget.booking.numGuest.toString());
    _packagePriceController = TextEditingController(text: widget.booking.packagePrice.toString());
  }

  @override
  void dispose() {
    _menuPackageController.dispose();
    _eventDateController.dispose();
    _eventTimeController.dispose();
    _numGuestController.dispose();
    _packagePriceController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateFormat('yyyy-MM-dd').parse(_eventDateController.text),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _eventDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(
        DateFormat('HH:mm').parse(_eventTimeController.text),
      ),
    );

    if (pickedTime != null) {
      setState(() {
        _eventTimeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event Date and Time',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: _selectDate,
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today),
                              SizedBox(width: 8),
                              Text(
                                _eventDateController.text.isNotEmpty
                                    ? _eventDateController.text
                                    : 'Select Date',
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextButton(
                          onPressed: _selectTime,
                          child: Row(
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(width: 8),
                              Text(
                                _eventTimeController.text.isNotEmpty
                                    ? _eventTimeController.text
                                    : 'Select Time',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextFormField(
                controller: _menuPackageController,
                decoration: InputDecoration(labelText: 'Menu Package'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the menu package';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numGuestController,
                decoration: InputDecoration(labelText: 'Number of Guests'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of guests';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _packagePriceController,
                decoration: InputDecoration(labelText: 'Package Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the package price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Update booking in the database
      try {
        DateTime pickedDateTime = DateFormat('yyyy-MM-dd HH:mm')
            .parse('${_eventDateController.text} ${_eventTimeController.text}');

        await DatabaseService().updateBooking(
          widget.booking.bookId,
          _menuPackageController.text,
          pickedDateTime,
          int.parse(_numGuestController.text),
          double.parse(_packagePriceController.text),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking updated successfully')),
        );

        // Navigate back to the booking list
        Navigator.pop(context); // Pop the booking edit screen
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update booking')),
        );
      }
    }
  }
}
