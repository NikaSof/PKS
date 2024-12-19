import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pks_pr1415/services/auth/auth_service.dart';
import 'package:pks_pr1415/services/chat/chat_service.dart';
import '../widgets/user_tile.dart';
import 'chat_page.dart';

class ChatsListPage extends StatelessWidget {
  ChatsListPage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список чатов'),
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    const String supportEmail = 'support@mail.ru';
    final currentEmail = _authService.getCurentUser()!.email;

    if (currentEmail == supportEmail) {
      return StreamBuilder(
        stream: _chatService.getUsersWithChatsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Произошла ошибка.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет активных чатов.'));
          }

          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) =>
                _buildUserListItem(userData, context))
                .toList(),
          );
        },
      );
    } else {
      return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Users')
            .where('email', isEqualTo: supportEmail)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Произошла ошибка.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Поддержка не доступна.'));
          }

          final supportUserData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
          return ListView(
            children: [
              _buildUserListItem(supportUserData, context),
            ],
          );
        },
      );
    }
  }

  Widget _buildUserListItem(Map<String, dynamic> userData, BuildContext context) {
    return UserTile(
      text: userData["email"],
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverID: userData["uid"],
              receiverEmail: userData["email"],
            ),
          ),
        );
      },
    );
  }
}
