import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

  final void Function()? onPressed;
  final String text;

  const MyButton({
    super.key, required this.onPressed, required this.text,
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          side: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
            width: 1.0,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          //elevation: 6.0,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 18,
          ),
        )
      ),
    );
  }
}
