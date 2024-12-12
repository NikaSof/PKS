import 'package:pks_pr11/auth/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final authService = AuthService();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void signUp() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (password != confirmPassword ) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords don't match"))
      );
      return;
    }

    try {
      await authService.signUpWithEmailAndPassword(email, password);

      Navigator.pop(context);

    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")));
      }
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Зарегистрируйтесь",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),


              TextField(
                scrollPadding: const EdgeInsets.only(bottom: 40),
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Почта',
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              TextField(
                scrollPadding: const EdgeInsets.only(bottom: 40),
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                ),
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              TextField(
                scrollPadding: const EdgeInsets.only(bottom: 40),
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  labelText: 'Подтвердите пароль',
                ),
                maxLines: 1,
              ),


              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Регистрация",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          )
      ),
    );
  }
}