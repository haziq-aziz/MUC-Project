import 'package:restaurantbooking/screens/landingpage.dart';
import 'package:restaurantbooking/screens/registerationpage.dart';
import 'package:flutter/material.dart';
import 'package:restaurantbooking/widgets/destination_restoran.dart';
import 'package:restaurantbooking/widgets/restoran_comingsoon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:restaurantbooking/Authentication/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _currentTab = 0;
  List<IconData> _icons = [
    FontAwesomeIcons.faceSmile,
    FontAwesomeIcons.faceGrinStars,
    FontAwesomeIcons.faceGrin,
    FontAwesomeIcons.faceSurprise,
  ];

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
              : Color(0xFFE7EBEE),
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(
          _icons[index],
          size: 25.0,
          color: _selectedIndex == index
              ? Colors.white
              : Color(0xFFB4C1C4),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'What would you like to find?',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
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
            SizedBox(height: 20.0),
            DestinationRestoran(),
            SizedBox(height: 20.0),
            HotelCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(//untuk navigation bar
        currentIndex: _currentTab,
        onTap: (int value) {
          setState(() {
            _currentTab = value;
            if (value == 0) {
        // Navigate to the current page
        // You may not need to navigate anywhere, so this is left blank
      } else if (value == 1) {
        // Navigate to Login App
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else if (value == 2) {
        // Navigate to Login App
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
          });
        },
        items: [
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
            label: 'Login',
          )
        ],
      ),
    );
  }
}
