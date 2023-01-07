import 'package:quest/archive/archive.dart';
import 'package:quest/home/home.dart';
import 'package:quest/login/login.dart';
import 'package:quest/profile/profile.dart';
import 'package:quest/quests/quests.dart';
import 'package:quest/register/register.dart';
import 'package:quest/groups/groups.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/quests': (context) => const QuestsScreen(),
  '/archive': (context) => const ArchiveScreen(),
  '/groups': (context) => const GroupsScreen(),
  '/profile': (context) => const ProfileScreen(),
};
