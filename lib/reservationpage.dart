import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'viewpackage.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _selectedDate = TextEditingController();
  final TextEditingController _selectedTime = TextEditingController();
  final TextEditingController _additionalRequest = TextEditingController();
  final TextEditingController _numberOfGuest = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B9EA6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'RESERVATION',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _name,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.person),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _name.text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _address,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Address',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.location_city),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _address.text = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _phone,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Phone No',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.contact_phone),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _phone.text = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Invalid phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _email,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _email.text = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return 'Enter a valid email!';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _selectedDate,
                              readOnly: true,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: 'Time',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(10),
                                prefixIcon: const Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedDate.text.isNotEmpty
                                      ? DateFormat('dd MM yyyy')
                                          .parse(_selectedDate.text)
                                      : DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now()
                                      .add(const Duration(days: 365)),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    _selectedDate.text =
                                        DateFormat('dd MM yyyy')
                                            .format(pickedDate);
                                  });
                                }
                              },
                              validator: (value) {
                                if (_selectedDate.text.isEmpty) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              controller: _selectedTime,
                              readOnly: true,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: _selectedTime.text.isNotEmpty
                                    ? _selectedTime.text
                                    : 'Time',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(10),
                                prefixIcon: const Icon(Icons.access_time),
                              ),
                              onTap: () async {
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    _selectedTime.text =
                                        '${pickedTime.hour}:${pickedTime.minute}';
                                  });
                                }
                              },
                              validator: (value) {
                                if (_selectedTime.text.isEmpty) {
                                  return 'Please select a time';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _additionalRequest,
                        maxLines: null,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Additional Request',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.note),
                        ),
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          _additionalRequest.text = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _numberOfGuest,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Number of guests',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.people),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          _numberOfGuest.text = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Input number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      margin: const EdgeInsets.symmetric(vertical: 20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _showConfirmationDialog(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B9EA6),
                          elevation: 0,
                          textStyle: const TextStyle(color: Colors.white),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Column(
                        children: [
                          Divider(color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            'Booking may be subject to cancellation by Selera Kampung under certain circumstances.',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Reservation Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Name:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_name.text),
              const SizedBox(height: 10.0),
              const Text(
                'Address:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_address.text),
              const SizedBox(height: 10.0),
              const Text(
                'Phone No:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_phone.text),
              const SizedBox(height: 10.0),
              const Text(
                'Email:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_email.text),
              const SizedBox(height: 10.0),
              const Text(
                'Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_selectedDate.text),
              const SizedBox(height: 10.0),
              const Text(
                'Time:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_selectedTime.text),
              const SizedBox(height: 10.0),
              const Text(
                'Additional Request:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_additionalRequest.text),
              const SizedBox(height: 10.0),
              const Text(
                'Number of Guests:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_numberOfGuest.text),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Edit Detail',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color(0xFF4B9EA6),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPackage(name: _name.text)));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF4B9EA6), // Change the button color
              ),
              child: const Text('Continue Booking',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
