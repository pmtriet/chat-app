import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_textfiled.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //tap to go to login page
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) async {
    final auth = AuthService();
    if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Passwords do not match"),
              ));
      return;
    }

    try {
      await auth.registerWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      //check whether context valid after an async call
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(
              height: 50,
            ),

            //welcome back message
            Text(
              "Let's get you started!",
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            //email textfield
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(
              height: 10,
            ),
            //password textfield
            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: _passwordController,
            ),

            const SizedBox(
              height: 10,
            ),

            //confirm password textfield
            MyTextField(
              hintText: "Confirm Password",
              obscureText: true,
              controller: _confirmPasswordController,
            ),

            const SizedBox(
              height: 25,
            ),

            //login button
            MyButton(
              text: "Register",
              onTap: () => register(context),
            ),

            const SizedBox(
              height: 25,
            ),

            //register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login Now!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
