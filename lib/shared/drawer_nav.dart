import 'package:flutter/material.dart';
import 'package:quest/services/auth.dart';

class DrawerNav extends StatefulWidget {
  const DrawerNav({super.key});

  @override
  State<DrawerNav> createState() => _DrawerNavState();
}

class _DrawerNavState extends State<DrawerNav> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Quest'),
          ),
          ListTile(
            title: const Text('Tasks'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text('Groups'),
            onTap: () {
              Navigator.pushNamed(context, '/groups');
            },
          ),
          ListTile(
            title: const Text('Archive'),
            onTap: () {
              Navigator.pushNamed(context, '/archive');
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          const Divider(
            height: 10,
            color: Colors.black,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () async {
              await AuthService().signOut();
              if (mounted) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
