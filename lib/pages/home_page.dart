import 'package:flutter/material.dart';
import 'package:new_chat_app/pages/chat_page.dart';
import 'package:new_chat_app/services/chat/auth/auth_service.dart';
import 'package:new_chat_app/services/chat/chat_services.dart';
import '../components/my_drawer.dart';
import '../components/user_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  Map<String, dynamic>? _selectedUser;

  @override
  Widget build(BuildContext context) {
    final bool isWeb = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.teal,
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
      drawer: isWeb ? null : const MyDrawer(),
      body: isWeb ? _buildWebLayout() : _buildUserList(false),
    );
  }

  Widget _buildUserList(bool isWeb) {
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
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: ListView(
              children: snapshot.data!
                  .map<Widget>((userData) => _buildUserListItem(userData,
                      context, MediaQuery.of(context).size.width > 800))
                  .toList(),
            ),
          );
        });
  }

  Widget _buildWebLayout() {
    return Row(
      children: [
        const SizedBox(
          width: 300,
          child: MyDrawer(),
        ),
        const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
        SizedBox(
          width: 400,
          child: _buildUserList(true),
        ),
        const VerticalDivider(width: 1, thickness: 1, color: Colors.grey),
        Expanded(
          child: _selectedUser != null
              ? ChatPage(
                  recieverEmail: _selectedUser!['name'],
                  recieverID: _selectedUser!['uid'])
              : const Center(
                  child: Text(
                    'Select a user to start chat',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
        )
      ],
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context, bool isWeb) {
    //display all user except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
          text: userData['name'],
          onTap: () {
            if (isWeb) {
              setState(() {
                _selectedUser = userData;
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          recieverEmail: userData['name'],
                          recieverID: userData['uid'],
                        )),
              );
            }
          });
    } else {
      return Container();
    }
  }
}
