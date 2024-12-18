import 'package:flutter/material.dart';
import 'package:pks_pr1415/services/auth/auth_service.dart';
import 'package:pks_pr1415/widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final void Function()? onTap;

  LoginPage({
    super.key,
    required this.onTap,
  });

  void login(BuildContext context) async {
    final authService = AuthService();
    
    try {
      await authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
    }
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          )
      );
    }
  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Добро пожаловать!'),
            const SizedBox(height: 25,),
            Textfield(
              controller: _emailController,
              hintText: 'Введите почту...',
              obscureText: false,
            ),
            const SizedBox(height: 16,),
            Textfield(
              controller: _passwordController,
              hintText: 'Введите пароль...',
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            MyButton(
                text: 'Вход',
                onTap: () => login(context),
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Нет аккаунта?  '),
                GestureDetector(
                  onTap: onTap,
                  child: const Text('Зарегистрироваться',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}