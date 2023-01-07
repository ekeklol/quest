import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quest/services/auth.dart';
import 'package:quest/services/db.dart';
import 'package:quest/shared/shared.dart';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  var user = AuthService().user;

  @override
  Widget build(BuildContext context) {
    // return streambuilder
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('tasks')
          .where('user', isEqualTo: user!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tasks'),
            ),
            drawer: const DrawerNav(),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.hasData) {
          Iterable<Map<String, dynamic>> list =
              snapshot.data!.docs.map((doc) => doc.data());
          debugPrint(list.toString());
          return Scaffold(
            appBar: AppBar(
              title: const Text('Tasks'),
            ),
            drawer: const DrawerNav(),
            body: Center(
              child: Text(user.toString()),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tasks'),
          ),
          drawer: const DrawerNav(),
          body: const Center(
            child: Text('No tasks found'),
          ),
        );
      },
    );
  }
}
