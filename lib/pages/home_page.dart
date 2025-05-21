import 'package:flutter/material.dart';
import 'package:new_chat_app/pages/chat_page.dart';
import 'package:new_chat_app/services/chat/auth/auth_service.dart';
import 'package:new_chat_app/services/chat/chat_services.dart';
import '../components/my_drawer.dart';
import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'CHATS',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.person))],
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading...');
          }

          //return listview
          return ListView(
            children: snapshot.data!
                .map<Widget>(
                    (userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    //display all user except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
          text: userData['name'],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        recieverEmail: userData['name'],
                        recieverID: userData['uid'],
                      )),
            );
          });
    } else {
      return Container();
    }
  }
}
