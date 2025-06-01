// ignore_for_file: use_build_context_synchronously

import 'package:new_chat_app/services/chat/auth/auth_service.dart';
import 'package:new_chat_app/components/my_button.dart';
import 'package:new_chat_app/components/my_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //email and pw controllers
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  //login method
  void _login(BuildContext context) async {

    try {
      await AuthService().signInWithEmailAndPassword(_emailController.text, _passwordController.text);

      showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Login Successful"),
      ),
    );
    }

    catch (e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString()),
      ));
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
          maxHeight: screenHeight * 0.6,
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
            
                const SizedBox(height: 50,),
            
                //welcome message
                Text(
                  "Welcome back, you've been missed",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 16
                  ),
                ),
            
                const SizedBox(height: 25,),
            
                //email
                MyTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: _emailController
                ),
            
                const SizedBox(height: 25,),
            
                //pw
                MyTextfield(
                  hintText: "Password",
                  obscureText: _obscurePassword,
                  controller: _passwordController,
                  suffixIcon: IconButton(onPressed: () {
                    setState( (){
                    _obscurePassword =! _obscurePassword;
                  });
                  }, icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Theme.of(context).colorScheme.surface
                  )),
                ),
            
                const SizedBox(height: 25,),
            
                //login button
                MyButton(
                  onPressed: () => _login(context),
                  text: "Login",
                ),
            
                const SizedBox(height: 25,),
            
                //register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?", style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text("Register Now!", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),),
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
