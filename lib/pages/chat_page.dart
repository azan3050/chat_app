import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_chat_app/components/chat_bubble.dart';
import 'package:new_chat_app/components/my_textfield.dart';
import 'package:new_chat_app/services/chat/auth/auth_service.dart';
import 'package:new_chat_app/services/chat/chat_services.dart';

class ChatPage extends StatelessWidget {
  final String recieverEmail;
  final String recieverID;

  ChatPage({super.key, required this.recieverEmail, required this.recieverID});

  //text controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(recieverID, _messageController.text);

      //clear message controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(recieverEmail),
        centerTitle: true,
        elevation: 0,
        // backgroundColor: Colors.transparent,
        // foregroundColor: Colors.grey,
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(recieverID, senderID),
        builder: (context, snapshot) {
          //errors
          if (snapshot.hasError) {
            return const Text("ERROR");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("LOADING...");
          }

          //return listview
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageListItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //current user
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    //align message to the right if user is current user otherwise left
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(message: data['message'], isCurrentUser: isCurrentUser),
          ],
        ));
  }

  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, right: 12),
      child: Row(
        children: [
          Expanded(
              child: MyTextfield(
                  hintText: 'type a message',
                  obscureText: false,
                  controller: _messageController)),

          //send button
          Container(
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: Colors.green),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.arrow_upward,
                      color: Colors.white, size: 38)))
        ],
      ),
    );
  }
}
