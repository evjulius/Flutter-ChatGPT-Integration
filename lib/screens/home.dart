import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../hive_model/chat_item.dart';
import '../shared/api_key_dialog.dart';
import 'chat_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ChatItem> chats = [];

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
      body: ValueListenableBuilder(
          valueListenable: Hive.box('chats').listenable(),
          builder: (context, box, _) {
            if (box.isEmpty) return const Center(child: Text('No chats yet'));
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                final chatItem = box.getAt(index) as ChatItem;
                return ListTile(
                  title: Text(chatItem.title),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ChatPage(chatItem: chatItem);
                    }));
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      box.deleteAt(index);
                    },
                  ),
                );
              },
            );
          }),
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

          // create hive object
          final messagesBox = Hive.box('messages');
          final newChatTitle =
              'New Chat ${DateFormat('d/M/y').format(DateTime.now())}';
          var chatItem = ChatItem(newChatTitle, HiveList(messagesBox));

          // add to hive
          Hive.box('chats').add(chatItem);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatPage(chatItem: chatItem),
            ),
          );
        },
        label: const Text('New chat'),
        icon: const Icon(Icons.message_outlined),
      ),
    );
  }
}
