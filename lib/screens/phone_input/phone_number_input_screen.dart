import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class PhoneNumberInputScreen extends StatefulWidget {
  const PhoneNumberInputScreen({super.key});

  @override
  _PhoneNumberInputScreenState createState() => _PhoneNumberInputScreenState();
}

class _PhoneNumberInputScreenState extends State<PhoneNumberInputScreen> {
  final MaskedTextController _phoneController = MaskedTextController(mask: '(000) 000-00-00');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            const Text('Введите номер телефона', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('На данный номер будет отправлен СМС-код для подтверждения', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 99, 106, 107))),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(color: const Color(0xFFF4F4F4), borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(border: Border(right: BorderSide(color: Colors.grey.shade300))),
                    child: const Text('+7', style: TextStyle(fontSize: 18)),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10), border: InputBorder.none),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/code', arguments: _phoneController.text.isNotEmpty ? _phoneController.text : '');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text('Получить код'),
            ),
            const SizedBox(height: 16),
            // Commented out fetched data section
            // SizedBox(height: 16),
            // Text('Fetched Data:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // SizedBox(height: 8),
            // FutureBuilder<List<TestData>>(
            //   future: _fetchedDataFuture,
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}');
            //     } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            //       return Text('No data found');
            //     } else {
            //       return Expanded(
            //         child: ListView.builder(
            //           itemCount: snapshot.data!.length,
            //           itemBuilder: (context, index) {
            //             final item = snapshot.data![index];
            //             return ListTile(
            //               title: Text(item.title),
            //               subtitle: Text('ID: ${item.id} - Completed: ${item.completed}'),
            //             );
            //           },
            //         ),
            //       );
            //     }
            //   },
            // ),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}
