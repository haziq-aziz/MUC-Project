import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurantbooking/JsonModels/booking.dart';
import 'package:restaurantbooking/views/user_booking_edit.dart';
import '../services/database_service.dart';
import 'edit_profile.dart';
import 'home_screen_success.dart';
import 'landingpage.dart';
import 'package:restaurantbooking/Authentication/globals.dart' as globals;

class UserBookingList extends StatefulWidget {
  final int userId;

  const UserBookingList({Key? key, required this.userId}) : super(key: key);

  @override
  _UserBookingListState createState() => _UserBookingListState();
}

class _UserBookingListState extends State<UserBookingList> {
  List<MenuBook> bookingList = []; // Initialize an empty list of bookings

  @override
  void initState() {
    super.initState();
    _fetchUserBookings(); // Call the method to fetch user's bookings data from the database when the widget initializes
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<void> _fetchUserBookings() async {
    try {
      List<MenuBook> bookings = await DatabaseService().getUserMenuBookings(widget.userId); // Fetch user's bookings data from the database
      setState(() {
        bookingList = bookings; // Update the bookingList with the fetched data
      });
    } catch (e) {
      print('Error fetching user bookings: $e');
    }
  }

  Future<void> _deleteBooking(int bookId) async {
    try {
      await DatabaseService().deleteBooking(bookId);
      setState(() {
        bookingList.removeWhere((booking) => booking.bookId == bookId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete booking')),
      );
    }
  }

  Future<void> _confirmDeleteBooking(int bookId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this booking?'),
          actions: <Widget>[
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
                _deleteBooking(bookId);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildEditButton(MenuBook booking) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserBookingEdit(booking: booking)),
        );
      },
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
      MaterialPageRoute(builder: (context) => const LandingPage()),
          (route) => false,
    );
  }

  void _showDetailDialog(MenuBook booking) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking Detail'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                _buildDetailRow('Booking ID:', booking.bookId.toString()),
                _buildDetailRow('User ID:', booking.userId.toString()),
                _buildDetailRow('Booking Date:', DateFormat('dd-MM-yyyy').format(booking.bookDate)),
                _buildDetailRow('Booking Time:', DateFormat('HH:mm ').format(booking.bookTime)),
                _buildDetailRow('Event Date:', DateFormat('dd-MM-yyyy').format(booking.eventDate)),
                _buildDetailRow('Event Time:', DateFormat('HH:mm ').format(booking.eventTime)),
                _buildDetailRow('Menu Package:', booking.menuPackage),
                _buildDetailRow('Total Guests:', booking.numGuest.toString()),
                _buildDetailRow('Package Price:', 'RM${booking.packagePrice} '), // Example: Assuming packagePrice is in RM
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Edit'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserBookingEdit(booking: booking)),
                );
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmDeleteBooking(booking.bookId); // Show confirmation dialog before deletion
              },
            ),
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Your Booking"),
        backgroundColor: const Color.fromRGBO(43, 159, 148, 1.0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the desired page here
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreenSuccess()),
            );
          },
        ),
      ),
      body: ListView.builder(
        itemCount: bookingList.length,
        itemBuilder: (context, index) {
          final booking = bookingList[index];
          String formattedEventDate = DateFormat('dd-MM-yyyy').format(booking.eventDate);
          String formattedEventTime = DateFormat('HH:mm').format(booking.eventTime);

          return Card(
            child: ListTile(
              title: Text(booking.menuPackage),
              subtitle: Text('Event Date: $formattedEventDate\nEvent Time: $formattedEventTime'),
              onTap: () {
                _showDetailDialog(booking); // Show details on tap
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildEditButton(booking),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _confirmDeleteBooking(booking.bookId); // Show confirmation dialog before deletion
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(43, 159, 148, 1.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        globals.name ?? '', // Display current user's name
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        globals.email ?? '', // Display current user's email
                        style: const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profile'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfile(userId: globals.userId!)),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Booking List'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserBookingList(userId: globals.userId!)),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
      ),
    );
  }
}
