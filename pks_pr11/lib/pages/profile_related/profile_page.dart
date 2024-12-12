import 'package:pks_pr11/auth/auth_service.dart';
import 'package:pks_pr11/pages/profile_related/logout_confirm_dialog.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final authService = AuthService();

  void logout() async {
    await authService.signOut();

  }



  @override
  Widget build(BuildContext context) {

    final userId = authService.getUserId();
    final userEmail = authService.getUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) => LogoutConfirmDialog(
                  onConfirm: () {
                    logout();
                    Navigator.pop(context);
                  },
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Вы вошли в аккаунт!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "ID:$userId",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "Email:$userEmail",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 60),
            ],
          )
      ),
    );
  }
}