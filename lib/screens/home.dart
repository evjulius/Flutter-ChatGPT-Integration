import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../shared/api_key_dialog.dart';
import 'chat_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> contacts = [];

  @override
  void initState() {
    super.initState();
    setApiKeyOnStartup();
  }

  Future<void> setApiKeyOnStartup() async {
    final sp = await SharedPreferences.getInstance();
    var key = sp.getString(spOpenApiKey);
    if (key == null || key.isEmpty) return;
    OpenAI.apiKey = key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatGPT Flutter'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context, builder: (_) => const ApiKeyDialog());
              },
              tooltip: 'Add/Update OpenAI key',
              icon: const Icon(Icons.key))
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text(contacts[index][0]),
            ),
            title: Text(contacts[index]),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return ChatPage(
                  name: contacts[index],
                );
              }));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          try {
            OpenAI.instance;
          } on MissingApiKeyException {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Can't start the chat. API key not added."),
                action: SnackBarAction(
                    label: 'Add key',
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => const ApiKeyDialog());
                    }),
              ),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatPage()),
          );
        },
        label: const Text('New chat'),
        icon: const Icon(Icons.message_outlined),
      ),
    );
  }
}
