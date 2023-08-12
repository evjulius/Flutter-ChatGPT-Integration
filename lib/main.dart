import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'hive_model/chat_item.dart';
import 'hive_model/message_item.dart';
import 'hive_model/message_role.dart';
import 'screens/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ChatItemAdapter());
  Hive.registerAdapter(MessageItemAdapter());
  Hive.registerAdapter(MessageRoleAdapter());
  await Hive.openBox('chats');
  await Hive.openBox('messages');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT',
      theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}
