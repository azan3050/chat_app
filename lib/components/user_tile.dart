import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const UserTile({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 25),
        padding: const EdgeInsets.all(20),
        child: Row(children: [
          //Icon
          const Icon(Icons.person),

          const SizedBox(width: 25,),

          //userName
          Text(text),
        ]),
      ),
    );
  }
}
