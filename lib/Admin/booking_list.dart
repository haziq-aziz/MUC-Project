import 'package:flutter/material.dart';
import 'package:restaurantbooking/Admin/dashboard.dart';
import 'package:restaurantbooking/Admin/user_list.dart';
import 'package:restaurantbooking/JsonModels/session.dart'; // Import the Users model
import 'package:restaurantbooking/services/database_service.dart'; // Import the DatabaseService
import 'package:restaurantbooking/Admin/booking_list.dart';

class BookingList extends StatefulWidget {
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  List<Users> BookingList = []; // Initialize an empty list of Users

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Handle navigation based on index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()), // Navigate to the BookingList screen
        );
        break;
      case 1:
        // Navigate to Bookings screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserList()), // Navigate to the BookingList screen
        );
        break;

      case 2:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMenuBookings(); // Call the method to fetch users data from the database when the widget initializes
  }

  Future<void> _fetchMenuBookings() async {
    try {
      List<Users> users = await DatabaseService().getAllMenuBookings()(); // Fetch users data from the database
      setState(() {
        BookingList = users; // Update the BookingList with the fetched data
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Shoe Database")),
      ),
      backgroundColor: const Color(0xFF4B9EA6),
      body: ListView.builder(
        itemCount: BookingList.length,
        itemBuilder: (context, index) {
          final user = BookingList[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${user.userid}'), // Assuming userid is the unique identifier for users
              ),
              title: Text(user.name ?? ''), // Accessing the name property of the user
              subtitle: Text(user.email ?? ''), // Accessing the email property of the user
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Implement edit functionality
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement delete functionality
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4B9EA6), // Set the selected tab color
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
        ],
      ),
    );
  }
}
