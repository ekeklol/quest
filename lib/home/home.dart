import 'package:flutter/material.dart';
import 'package:quest/login/login.dart';
import 'package:quest/services/auth.dart';
// import 'package:quest/shared/shared.dart';
import 'package:quest/quests/quests.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('Loading..'),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('HasError...'),
          );
        } else if (snapshot.hasData) {
          return const QuestsScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
