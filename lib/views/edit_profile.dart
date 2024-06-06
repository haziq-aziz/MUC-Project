// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:restaurantbooking/services/database_service.dart';
import 'package:restaurantbooking/JsonModels/session.dart';
import 'package:restaurantbooking/views/home_screen_success.dart';

class EditProfile extends StatefulWidget {
  final int userId;

  const EditProfile({super.key, required this.userId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  Users _user = Users(username: '', password: '');

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final db = DatabaseService();
    final dbInstance = await db.database;
    List<Map<String, dynamic>> results = await dbInstance.query(
      'users',
      where: 'userid = ?',
      whereArgs: [widget.userId],
    );

    if (results.isNotEmpty) {
      setState(() {
        _user = Users.fromMap(results.first);
        _nameController.text = _user.name ?? '';
        _emailController.text = _user.email ?? '';
        _phoneController.text = _user.phone?.toString() ?? '';
        _passwordController.text =
            _user.password; // Load password into the controller
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color.fromRGBO(43, 159, 148, 1.0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop the EditProfile route
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomeScreenSuccess()));
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        AssetImage('assets/images/default_pfp.png'),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(Icons.person, 'Full Name', _nameController),
                  const SizedBox(height: 20),
                  _buildTextField(Icons.email, 'E-Mail', _emailController),
                  const SizedBox(height: 20),
                  _buildTextField(Icons.phone, 'Phone No', _phoneController),
                  const SizedBox(height: 20),
                  _buildTextField(Icons.lock, 'Password', _passwordController,
                      obscureText: _obscurePassword),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _updateProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(43, 159, 148, 1.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      IconData icon, String label, TextEditingController controller,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: const Color.fromRGBO(43, 159, 148, 1.0)),
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black),
        ),
        suffixIcon: label == 'Password'
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: const Color.fromRGBO(43, 159, 148, 1.0),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      // Update the user object with new data
      Users updatedUser = Users(
        username: _user.username,
        password: _passwordController.text,
        userid: widget.userId,
        name: _nameController.text,
        email: _emailController.text,
        phone: int.tryParse(_phoneController.text),
      );

      // Update user data in the database
      final db = DatabaseService();
      await db.updateUsers(updatedUser);

      // Show a snackbar indicating success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );

      // Navigate to the HomeScreenSuccess
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenSuccess()),
      );
    }
  }
}
