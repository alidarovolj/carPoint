import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startup_app/stores/test_data_fetch/models/test_data.dart';

class CarWashItem extends StatelessWidget {
  final TestData data;

  const CarWashItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color.fromRGBO(241, 242, 244, 1.0), width: 1.0), // Set the border at the top
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        5,
                            (index) {
                          return Icon(
                            Icons.star,
                            size: 16,
                            color: index < data.overallRating
                                ? Colors.amber
                                : Colors.grey,
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${data.overallRating} (${data.reviews.length} отзывов)',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Открыто до ${data.workingTime['friday']} • 120 м',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(241, 242, 244, 1.0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'В среднем',
                    style: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(98, 105, 106, 1.0)),
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '4000-10000 тг',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.images.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(data.images[index],
                          width: 96, height: 96, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(226, 240, 255, 1),
                    foregroundColor: const Color.fromRGBO(37, 95, 153, 1.0),
                  ),
                  child: const Text('Забронировать'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(241, 242, 244, 1.0),
                    foregroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.directions_car, size: 16),
                      SizedBox(width: 4),
                      Text('4 минуты'),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(241, 242, 244, 1.0),
                    foregroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
                  ),
                  child: const Icon(Icons.bookmark_border, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}