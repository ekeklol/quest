import 'package:flutter/material.dart';
import 'package:quest/services/auth.dart';
import 'package:quest/shared/shared.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({super.key});

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  var user = AuthService().user;
  @override
  Widget build(BuildContext context) {
    // return scaffold with top bar title Tasks
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archive'),
      ),
      drawer: const DrawerNav(),
      body: Center(
        child: Text(user.toString()),
      ),
    );
  }
}
