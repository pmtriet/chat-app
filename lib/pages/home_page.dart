import 'package:chat_app/auth/auth_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logOut() {
    //get auth service
    final _auth= AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          //log out button
          IconButton(onPressed: logOut, icon: const Icon(Icons.logout)),
        ]
      ),
    );
  }
}
