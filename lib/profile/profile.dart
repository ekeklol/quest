import 'package:flutter/material.dart';
import 'package:quest/services/auth.dart';
import 'package:quest/shared/shared.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var user = AuthService().user;
  @override
  Widget build(BuildContext context) {
    // return scaffold with top bar title Tasks
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: const DrawerNav(),
      body: Center(
        child: Text(user.toString()),
      ),
    );
  }
}
