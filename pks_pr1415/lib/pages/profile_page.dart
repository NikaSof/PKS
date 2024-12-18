import 'package:flutter/material.dart';
import 'package:pks_pr1415/services/auth/auth_service.dart';
import 'package:pks_pr1415/services/chat/chat_service.dart';

import '../widgets/user_tile.dart';
import 'chat_page.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();


  void logout(){
    final auth = AuthService();
    auth.singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed: logout,
              icon: const Icon(Icons.logout)
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList(){
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError){
            return const Text('Error');
          }

          if (snapshot.connectionState == ConnectionState.waiting){
            return const Text('Loading...');
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => _buildUserListItem(userData, context))
                .toList(),
          );
        },
    );
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurentUser()!.email) {
      return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverID: userData["uid"],
                  receiverEmail: userData["email"],
                )
            )
        );
      },
      );
    } else {
      return Container();
    }
  }

}


