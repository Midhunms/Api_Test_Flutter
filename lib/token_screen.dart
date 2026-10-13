import 'package:flutter/material.dart';

class TokenScreen extends StatelessWidget {
  const TokenScreen({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login successful')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Token'),
            const SizedBox(height: 8),
            SelectableText(token),
          ],
        ),
      ),
    );
  }
}
