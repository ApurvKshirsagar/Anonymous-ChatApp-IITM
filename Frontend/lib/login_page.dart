import 'package:flinnit/anonymous/data/chat_users.dart';
import 'package:flinnit/anonymous/models/chat_users.dart';
import 'package:flinnit/tabs.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ChatUsers source;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatUsers.length,
        itemBuilder: (ctx, index) => InkWell(
          child: Card(
            child: Text(chatUsers[index].name),
          ),
          onTap: () {
            print(chatUsers[index].id);
            source = chatUsers[index];
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => TabsScreen(
                  source: source,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
