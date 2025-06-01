// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:new_chat_app/services/chat/auth/auth_service.dart';
import 'package:new_chat_app/components/my_button.dart';
import 'package:new_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //email, username and pw controllers
  final _emailController = TextEditingController();

  final _userNameController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;

  bool _confirmObscurePassword = true;

  //register method
  void _register(BuildContext context) async {
    final _auth = AuthService();

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();
    final username = _userNameController.text.trim();

    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Passwords do not match"),
        ),
      );
      return;
    }

    if (username.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text(
            "Username cannot be empty",
          ),
        ),
      );
      return;
    }

    try {
      await _auth.createUserWithEmailAndPassword(email, password, username);

      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Account Created Successfully"),
        ),
      );
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            e.toString().contains("username-taken")
                ? "Username already taken"
                : "Signup failed: ${e.toString()}",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isWideScreen ? 380 : screenWidth * 0.85,
            maxHeight: screenHeight * 0.8, // Limits height, preventing overflow
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                Icon(
                  Icons.message,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
          
                const SizedBox(
                  height: 50,
                ),
          
                //welcome message
                Text(
                  "Let's create an account for you",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 16),
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //email
                MyTextfield(
                    hintText: "Email",
                    obscureText: false,
                    controller: _emailController),
          
                const SizedBox(
                  height: 25,
                ),
          
                //username
                MyTextfield(
                  hintText: "Username",
                  obscureText: false,
                  controller: _userNameController,
                  // suffixIcon: IconButton(onPressed: () {
                  //   setState( (){
                  //     _obscurePassword =! _obscurePassword;
                  //   });
                  // }, icon: Icon(
                  //     _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  //     color: Theme.of(context).colorScheme.primary
                  // )),
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //pw
                MyTextfield(
                  hintText: "Password",
                  obscureText: _obscurePassword,
                  controller: _passwordController,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).colorScheme.primary)),
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //confirm pw
                MyTextfield(
                  hintText: "Confirm Password",
                  obscureText: _confirmObscurePassword,
                  controller: _confirmPasswordController,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _confirmObscurePassword = !_confirmObscurePassword;
                        });
                      },
                      icon: Icon(
                          _confirmObscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Theme.of(context).colorScheme.primary)),
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //login button
                MyButton(
                  onPressed: () => _register(context),
                  text: "Register",
                ),
          
                const SizedBox(
                  height: 25,
                ),
          
                //register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already a member? ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
