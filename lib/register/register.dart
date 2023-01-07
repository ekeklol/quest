import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quest/services/auth.dart';
import 'package:quest/services/db.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  initUserDocument() async {
    var user = AuthService().user;
    if (user != null) {
      await DatabaseService().createUserDocument(
        nameController.text,
        emailAddressController.text,
        user.uid,
      );
    }
  }

  initGroupDocument() async {
    var user = AuthService().user;
    if (user != null) {
      var groupName = nameController.text;
      return await DatabaseService().createGroupDocument(
        '$groupName group',
      );
    }
  }

  initUserGroupDocument(groupId) async {
    var user = AuthService().user;
    if (user != null) {
      await DatabaseService().createUserGroupDocument(
        user.uid,
        groupId,
        'admin',
      );
    }
  }

  registerUser() async {
    var password = passwordController.text;
    var passwordConfirm = passwordConfirmController.text;
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));

    if (password.length < 6) {
      print('Password is too short, use at least 6 characters');
      return;
    }
    if (passwordConfirm != password) {
      print('Password confirm do not match.');
      return;
    }
    if (!hasUppercase) {
      print('Password should containt at least 1 uppercased character');
      return;
    }
    if (!hasLowercase) {
      print('Password should containt at least 1 lowercased character');
      return;
    }

    try {
      await AuthService().signUpWithEmailAndPassword(
        nameController.text,
        emailAddressController.text,
        password,
      );

      await initUserDocument();
      var groupId = await initGroupDocument();
      await initUserGroupDocument(groupId);

      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
      }
    } on Exception catch (e) {
      // TODO
      print('registerUser error');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Flexible(
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: emailAddressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email Address',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Password'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                obscureText: true,
                controller: passwordConfirmController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password'),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: RegisterButton(
                  icon: FontAwesomeIcons.userPlus,
                  text: 'Sign Up',
                  registerMethod: () => registerUser(),
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Flexible(
              child: TextButton(
                child: const Text('Login'),
                onPressed: () => Navigator.pop(context, '/'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function registerMethod;

  const RegisterButton({
    super.key,
    required this.text,
    required this.icon,
    required this.color,
    required this.registerMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        onPressed: () => registerMethod(),
        icon: Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
        label: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
