import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('URL_TO_PROFILE_PICTURE'),
              ),
            ),
          ),
          ListTile(
            title: const Text('Personal Information'),
            trailing: const Icon(Icons.edit),
            onTap: () {
              // Handle personal information edit
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Name'),
            subtitle: const Text('John Doe'),
            trailing: const Icon(Icons.edit),
            onTap: () {
              // Handle name edit
            },
          ),
          ListTile(
            title: const Text('Email'),
            subtitle: const Text('john.doe@example.com'),
            trailing: const Icon(Icons.edit),
            onTap: () {
              // Handle email edit
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle save button press
              },
              child: const Text('Save Changes'),
            ),
          ),
        ],
      ),
    );
  }
}
