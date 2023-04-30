import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../utils/link_launcher.dart';

class ApiKeyDialog extends StatefulWidget {
  const ApiKeyDialog({super.key});

  @override
  State<ApiKeyDialog> createState() => _ApiKeyDialogState();
}

class _ApiKeyDialogState extends State<ApiKeyDialog> {
  final TextEditingController apiKeyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Open API key'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(),
                  );
                }
                final String? action = snapshot.data!.getString(spOpenApiKey);
                apiKeyController.text = action ?? '';

                return TextField(controller: apiKeyController);
              }),
          TextButton(
            onPressed: () {
              LinkLauncher.launch(
                  'https://platform.openai.com/account/api-keys/');
            },
            child: const Text('Get API key'),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel')),
        TextButton(
            onPressed: () async {
              if (apiKeyController.text.isEmpty) return;
              var prefs = await SharedPreferences.getInstance();
              debugPrint('Entered ket: ${apiKeyController.text}');

              OpenAI.apiKey = apiKeyController.text;

              await prefs.setString(spOpenApiKey, apiKeyController.text);

              Navigator.pop(context);
            },
            child: const Text('Save')),
      ],
    );
  }
}
