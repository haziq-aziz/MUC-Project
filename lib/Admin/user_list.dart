// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurantbooking/views/landingpage.dart';
import 'package:restaurantbooking/Admin/dashboard.dart';

import 'package:restaurantbooking/Admin/user_edit.dart';
import 'package:restaurantbooking/JsonModels/session.dart'; // Import the Users model
import 'package:restaurantbooking/services/database_service.dart'; // Import the DatabaseService
import 'package:restaurantbooking/Admin/booking_list.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

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
          MaterialPageRoute(builder: (context) => const AdminDashboard()), // Navigate to the UserList screen
        );
        break;
      case 1:
        break;
      case 2:
        // Navigate to Bookings screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingList()), // Navigate to the BookingList screen
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
      if (kDebugMode) {
        print('Error fetching users: $e');
      }
    }
  }

  Future<void> _deleteUser(int? userId) async {
    if (userId != null) {
      try {
        await DatabaseService().deleteUser(userId); // Delete the user from the database
        _fetchUsers(); // Refresh the user list after deletion
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User deleted successfully')));
      } catch (e) {
        if (kDebugMode) {
          print('Error deleting user: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to delete user')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User ID is null')));
    }
  }

  void _logout() {
    // Implement your logout logic here
    // For now, let's navigate back to the landing page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LandingPage()), // Navigate to the landing page
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Users List")),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
        automaticallyImplyLeading: false, // Remove the back button
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.email, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(user.email ?? '', overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 16),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(user.phone != null ? user.phone.toString().padLeft(10, '0') : '', overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserEdit(user: user)),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Delete User'),
                            content: const Text('Are you sure you want to delete this user?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _deleteUser(user.userid);
                                },
                              ),
                            ],
                          );
                        },
                      );
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