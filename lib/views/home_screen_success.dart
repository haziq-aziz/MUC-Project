import 'package:flutter/material.dart';
import 'package:restaurantbooking/views/edit_profile.dart';
import 'package:restaurantbooking/views/landingpage.dart';
import 'package:restaurantbooking/views/registerationpage.dart';
import 'package:restaurantbooking/widgets/destination_restoran.dart';
import 'package:restaurantbooking/widgets/restoran_comingsoon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurantbooking/Authentication/login.dart';
import 'package:restaurantbooking/BookForm/bookingform.dart';
import 'package:restaurantbooking/Authentication/globals.dart' as globals;

class HomeScreenSuccess extends StatefulWidget {
  const HomeScreenSuccess({Key? key}) : super(key: key);

  @override
  _HomeScreenSuccessState createState() => _HomeScreenSuccessState();
}

class _HomeScreenSuccessState extends State<HomeScreenSuccess> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  final List<IconData> _icons = [
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceGrinStars,
    FontAwesomeIcons.faceGrin,
    FontAwesomeIcons.faceSurprise,
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _buildIcon(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          color: _selectedIndex == index
              ? Theme.of(context).primaryColor
              : const Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color:
              _selectedIndex == index ? Colors.white : const Color(0xFFB4C1C4),
        ),
      ),
    );
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
        title: const Text("Home Page"),
        backgroundColor: Color.fromRGBO(43, 159, 148, 1.0),
        automaticallyImplyLeading: false,
      ),

      key: _scaffoldKey,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'How are you feeling?',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _icons
                  .asMap()
                  .entries
                  .map(
                    (MapEntry map) => _buildIcon(map.key),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20.0),
            DestinationRestoran(),
            const SizedBox(height: 20.0),
            HotelCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
            if (value == 0) {
              // Navigate to the current page
              // You may not need to navigate anywhere, so this is left blank
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
          )
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
}
