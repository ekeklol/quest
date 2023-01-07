import 'package:flutter/material.dart';
import 'package:quest/services/auth.dart';
import 'package:quest/shared/shared.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  var user = AuthService().user;
  @override
  Widget build(BuildContext context) {
    // return scaffold with top bar title Tasks
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
      ),
      drawer: const DrawerNav(),
      body: Center(
        child: Text(user.toString()),
      ),
    );
  }
}
