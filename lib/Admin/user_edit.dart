// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:restaurantbooking/Admin/user_list.dart';
import 'package:restaurantbooking/JsonModels/session.dart'; // Import the Users model
import 'package:restaurantbooking/services/database_service.dart'; // Import the DatabaseService

class UserEdit extends StatefulWidget {
  final Users user;

  const UserEdit({super.key, required this.user});

  @override
  _UserEditState createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _phoneController = TextEditingController(text: widget.user.phone?.toString() ?? '');
    _usernameController = TextEditingController(text: widget.user.username);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  Future<void> _saveUser() async {
  if (_formKey.currentState!.validate()) {
    try {
      Users updatedUser = Users(
        userid: widget.user.userid,
        name: _nameController.text,
        email: _emailController.text,
        phone: int.tryParse(_phoneController.text),
        username: _usernameController.text,
        password: _passwordController.text,
      );

      await DatabaseService().updateUsers(updatedUser);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User updated successfully')));
      
      // Navigate back to the dashboard
      Navigator.pop(context); // Pop the user edit screen
      Navigator.pop(context); // Pop the previous screen (user details screen)

      // Push the dashboard screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserList()),
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to update user')));
    }
  }
}


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUser,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
