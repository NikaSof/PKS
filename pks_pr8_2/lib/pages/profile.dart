import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;

  final TextEditingController fullNameController = TextEditingController(text: 'Боровская Вероника Вячеславовна');
  final TextEditingController groupController = TextEditingController(text: 'ЭФБО-03-22');
  final TextEditingController phoneNumberController = TextEditingController(text: '+7 (911) 111-11-11');
  final TextEditingController emailController = TextEditingController(text: 'borovskaya.v.v@edu.mirea.ru');

  void toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: toggleEdit,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileField('ФИО', fullNameController, isEditing),
            const SizedBox(height: 20),
            buildProfileField('Группа', groupController, isEditing),
            const SizedBox(height: 20),
            buildProfileField('Номер телефона', phoneNumberController, isEditing),
            const SizedBox(height: 20),
            buildProfileField('Почта', emailController, isEditing),
          ],
        ),
      ),
    );
  }

  Widget buildProfileField(String label, TextEditingController controller, bool isEditing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 5),
        isEditing
            ? TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        )
            : Text(controller.text, style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
