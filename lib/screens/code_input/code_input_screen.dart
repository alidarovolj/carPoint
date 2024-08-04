import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeInputScreen extends StatelessWidget {
  final TextEditingController _codeController = TextEditingController();

  CodeInputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = ModalRoute.of(context)?.settings.arguments as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 32),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/map');
            },
            child: const Text(
              'Пропустить',
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Код из смс', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(text: 'Мы отправили код на номер ', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 99, 106, 107))),
                  TextSpan(text: '+7 $phoneNumber', style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                // Handle incorrect number action
              },
              child: const Text(
                'Неправильный номер?',
                style: TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(8)),
              child: TextField(
                controller: _codeController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(4),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  border: InputBorder.none,
                  hintText: '----',
                  hintStyle: TextStyle(fontSize: 18, letterSpacing: 16, color: Colors.grey),
                ),
                style: const TextStyle(fontSize: 18, letterSpacing: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle confirm action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text('Подтвердить код'),
            ),
            const Spacer(),
            const Text('Отправить код еще раз через 4:45', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 99, 106, 107))),
          ],
        ),
      ),
    );
  }
}