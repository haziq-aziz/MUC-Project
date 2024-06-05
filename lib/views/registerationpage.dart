import 'package:flutter/material.dart';
import 'package:restaurantbooking/views/home_screen.dart';
import 'package:restaurantbooking/views/home_screen_success.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  int _currentTab = 0; //for navigation bar

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();

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
                      //calling for name field
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _name,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'First Name',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.face),
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
                      //calling for name username
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _username,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Username',
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
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      //calling for email
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      // calling for phone no
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
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      //calling for password field
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _password,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10),
                          prefixIcon: const Icon(Icons.password),
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          _name.text;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
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
                            'Register Now',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w900),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen()), //letak login page
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 32.0),
                          decoration: BoxDecoration(
                            color: const Color(
                                0xFF4B9EA6), // Background color of the label
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust as needed for rounded corners
                          ),
                          child: const Text(
                            'Already have an account? Click here to log in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Column(
                        children: [
                          Divider(color: Colors.white),
                          //SizedBox(height: 8),
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
      bottomNavigationBar: BottomNavigationBar(
        //untuk navigation bar
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
            if (value == 0) {
              // Navigate to the current page
              // You may not need to navigate anywhere, so this is left blank
            } else if (value == 1) {
              // Navigate to HomeScreen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (value == 2) {
              // Navigate to ReservationPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReservationPage()),
              );
            }
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 30.0,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_restaurant,
              size: 30.0,
            ),
            label: 'Restaurant',
          ),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 15.0,
              backgroundImage: NetworkImage('http://i.imgur.com/zL4Krbz.jpg'),
            ),
            label: 'Profile',
          )
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You have successfully logged in.'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_name.text),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back',
                  style: TextStyle(
                    color: Color(0xFF4B9EA6),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreenSuccess()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF4B9EA6), // Change the button color
              ),
              child:
                  const Text('Continue', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
