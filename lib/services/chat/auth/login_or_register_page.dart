import 'package:new_chat_app/pages/login_page.dart';
import 'package:new_chat_app/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {

  //intitially show login page
  bool _showLoginPage = true;

  //toggle between pages
  void _togglePages() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (_showLoginPage) {
      return LoginPage(
        onTap: _togglePages,
      );
    } else {
      return RegisterPage(
        onTap: _togglePages,
      );
    }
  }
}
