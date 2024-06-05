import 'package:flutter/material.dart';
import 'package:restaurantbooking/Admin/dashboard.dart';
import 'package:restaurantbooking/JsonModels/session.dart'; // Import the Users model
import 'package:restaurantbooking/services/database_service.dart'; // Import the DatabaseService
import 'package:restaurantbooking/Admin/booking_list.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Users> userList = []; // Initialize an empty list of Users

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
          MaterialPageRoute(builder: (context) => AdminDashboard()), // Navigate to the UserList screen
        );
        break;
      case 1:
        
        break;
      case 2:
        // Navigate to Bookings screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookingList()), // Navigate to the BookingList screen
        );
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUsers(); // Call the method to fetch users data from the database when the widget initializes
  }

  Future<void> _fetchUsers() async {
    try {
      List<Users> users = await DatabaseService().getAllUsers(); // Fetch users data from the database
      setState(() {
        userList = users; // Update the userList with the fetched data
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
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
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
