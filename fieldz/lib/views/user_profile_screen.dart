import 'package:flutter/material.dart';

class User {
  String username;
  String email;
  String phoneNumber;
  String avatarUrl;

  User({
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
  });
}

// Dummy user for demonstration
final User currentUser = User(
  username: 'John Doe',
  email: 'john.doe@example.com',
  phoneNumber: '+1234567890',
  avatarUrl: 'https://via.placeholder.com/150',
);

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _avatarController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: currentUser.username);
    _emailController = TextEditingController(text: currentUser.email);
    _phoneController = TextEditingController(text: currentUser.phoneNumber);
    _avatarController = TextEditingController(text: currentUser.avatarUrl);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CircleAvatar(
                radius: 75,
                backgroundImage: NetworkImage(_avatarController.text),
              ),
              const SizedBox(height: 18),
              TextFormField(
                controller: _avatarController,
                decoration: const InputDecoration(
                  labelText: 'Avatar URL',
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    currentUser.username = _usernameController.text;
                    currentUser.email = _emailController.text;
                    currentUser.phoneNumber = _phoneController.text;
                    currentUser.avatarUrl = _avatarController.text;
                  });
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
