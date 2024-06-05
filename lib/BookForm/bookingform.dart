import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/database_service.dart';
import 'package:restaurantbooking/views/home_screen_success.dart';
import 'package:restaurantbooking/services/database_service.dart';
import 'package:restaurantbooking/services/auth_service.dart';
import 'package:restaurantbooking/Authentication/globals.dart' as globals;

import '../views/edit_profile.dart';
import '../views/landingpage.dart';

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
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> _menuPackages = ['Package 1', 'Package 2', 'Package 3'];
  final List<double> _packagePrices = [50.0, 40.0, 30.0];
  final List<bool> _selectedPackages = [false, false, false];
  final List<TextEditingController> _guestControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  DateTime? _selectedBookDate;
  TimeOfDay? _selectedBookTime;
  DateTime? _selectedEventDate;
  TimeOfDay? _selectedEventTime;

  double _totalPrice = 0.0;
  int _totalGuests = 0;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  int _userId = 0; // Default value

  void _getCurrentUserId() async {
    int? userId = await AuthService().getCurrentUserId();
    if (userId != null) {
      setState(() {
        _userId = userId!;
      });
    } else {
      // Handle the case where userId is null
      // For example, you might want to display an error message or take other actions
    }
  }
  void _openProfileDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _logout() {
    // Perform logout actions, such as clearing authentication state
    // and navigating back to the login screen
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LandingPage()),
          (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Form'), // Add the title here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                        decoration: InputDecoration(
                            labelText: 'Number of Guests for $package'),
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
              Text('Total Number of Guests: $_totalGuests'),
              Text('Total Price: RM$_totalPrice'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
            if (value == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreenSuccess()),
              );
            } else if (value == 1) {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BookingForm()),
              );
            } else if (value == 2) {
              _openProfileDrawer();
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30.0,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
              size: 30.0,
            ),
            label: 'Book Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30.0,
            ),
            label: 'Profile',
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(43, 159, 148, 1.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        globals.name ?? '', // Display current user's name
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      SizedBox(height: 5),
                      Text(
                        globals.email ?? '', // Display current user's email
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EditProfile(userId: globals.userId!)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Booking List'),
              onTap: () {
                // Navigate to Booking List screen
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: _logout,
            ),
          ],
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

  void _calculateTotal() {
    double totalPrice = 0.0;
    int totalGuests = 0;
    for (int i = 0; i < _selectedPackages.length; i++) {
      if (_selectedPackages[i]) {
        int numGuests = int.parse(_guestControllers[i].text.isEmpty
            ? '0'
            : _guestControllers[i].text);
        totalGuests += numGuests;
        totalPrice += _packagePrices[i] * numGuests;
      }
    }
    setState(() {
      _totalPrice = totalPrice;
      _totalGuests = totalGuests;
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      double totalPrice = 0.0;
      int totalGuests = 0;
      String menuPackage = _menuPackages
          .asMap()
          .entries
          .where((entry) => _selectedPackages[entry.key])
          .map((entry) {
        int index = entry.key;
        totalGuests += int.parse(_guestControllers[index].text);
        totalPrice +=
            _packagePrices[index] * int.parse(_guestControllers[index].text);
        return entry.value;
      }).join(', ');

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



      await DatabaseService().insertBooking(
        _userId,
        bookDateTime,
        eventDateTime,
        menuPackage,
        totalGuests,
        totalPrice,
      );

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Booking successful')));
    }
  }
}
