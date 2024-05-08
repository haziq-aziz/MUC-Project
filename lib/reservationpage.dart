import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'calculatepackage.dart';
import 'package:restaurantbooking/pagelistfood.dart';
import 'inputdata.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  ReservationPageState createState() => ReservationPageState();
}

class ReservationPageState extends State<ReservationPage> {
  final _formKey = GlobalKey<FormState>();

  ReservationFormData booking = ReservationFormData(
      name: '',
      address: '',
      phone: '',
      email: '',
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.fromDateTime(DateTime.now()),
      additionalRequest: '',
      numberOfGuests: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4B9EA6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
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
                          booking.name = value;
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
                          booking.address = value;
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
                          booking.phone = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
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
                          booking.email = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
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
                              readOnly: true,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: booking.selectedDate != null
                                    ? DateFormat('dd MM yyyy').format(booking.selectedDate!)
                                    : 'Date',
                                hintStyle: TextStyle(
                                  color: booking.selectedDate != null
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(10),
                                prefixIcon: const Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                // Show date picker
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: booking.selectedDate ?? DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    booking.selectedDate = pickedDate;
                                  });
                                }
                              },
                              validator: (value) {
                                if (booking.selectedDate == null) {
                                  return 'Please select a date';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              readOnly: true,
                              style: const TextStyle(color: Colors.grey, fontSize: 16),
                              decoration: InputDecoration(
                                hintText: booking.selectedTime != null
                                    ? '${booking.selectedTime!.hour}:${booking.selectedTime!.minute}'
                                    : 'Time',
                                hintStyle: TextStyle(
                                  color: booking.selectedTime != null
                                      ? Colors.black
                                      : Colors.grey[400],
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(10),
                                prefixIcon: const Icon(Icons.access_time),
                              ),
                              onTap: () async {
                                // Show time picker
                                TimeOfDay? pickedTime = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (pickedTime != null) {
                                  setState(() {
                                    booking.selectedTime = pickedTime;
                                  });
                                }
                              },
                              validator: (value) {
                                if (booking.selectedTime == null) {
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
                          booking.additionalRequest = value;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
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
                          booking.numberOfGuests = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of guests';
                          }
                          // You can add more specific validation here if needed
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
              Text(booking.name ?? "None"),
              const SizedBox(height: 10.0),
              const Text(
                'Address:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(booking.address ?? "None"),
              const SizedBox(height: 10.0),
              const Text(
                'Phone No:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(booking.phone ?? "None"),
              const SizedBox(height: 10.0),
              const Text(
                'Email:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(booking.email ?? "None"),
              const SizedBox(height: 10.0),
              const Text(
                'Date:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(booking.selectedDate != null
                  ? DateFormat('dd MM yyyy').format(booking.selectedDate!)
                  : "Not selected"),
              const SizedBox(height: 10.0),
              const Text(
                'Time:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(booking.selectedTime != null
                  ? '${booking.selectedTime!.hour}:${booking.selectedTime!.minute}'
                  : "Not selected"),
              const SizedBox(height: 10.0),
              const Text(
                'Additional Request:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(booking.additionalRequest ?? "None"),
              const SizedBox(height: 10.0),
              const Text(
                'Number of Guests:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(' ${booking.numberOfGuests ?? "None"}'),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PageListFood()));
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
