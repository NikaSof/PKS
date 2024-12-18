import 'package:flutter/material.dart';
import 'package:pks_pr1415/services/auth/auth_service.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';


class RegisterPage extends StatelessWidget {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap
  });

  void register(BuildContext context){
    final auth = AuthService();

    if (_passwordController.text == _confirmPasswordController.text) {
      try{
      auth.signUnWithEmailPassword(
          _emailController.text,
          _passwordController.text
      );
      } catch (e) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(e.toString()),
              )
          );
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Пароли не совпадают!'),
          )
      );
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Создайте аккаунт'),
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
            const SizedBox(height: 16,),
            Textfield(
              controller: _confirmPasswordController,
              hintText: 'Подтвердите пароль...',
              obscureText: true,
            ),
            const SizedBox(height: 20,),
            MyButton(
              text: 'Зарегистрироваться',
              onTap: () => register(context),
            ),
            const SizedBox(height: 20,),
            GestureDetector(
              onTap: onTap,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Уже есть аккаунт?  '),
                  Text('Войти',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
