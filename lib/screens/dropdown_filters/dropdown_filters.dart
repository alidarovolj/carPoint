import 'package:flutter/material.dart';

class DropdownFilters extends StatelessWidget {
  const DropdownFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F2F4),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'Доступно сейчас',
                  borderRadius: BorderRadius.circular(16.0),
                  items: <String>['Доступно сейчас', 'Option 1', 'Option 2']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              color: Color.fromRGBO(69, 75, 84, 1.0))),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  dropdownColor: const Color(0xFFF1F2F4),
                  style:
                      const TextStyle(color: Color.fromRGBO(69, 75, 84, 1.0)),
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color(0xFF454B54)),
                  iconSize: 24,
                  isDense: true,
                  isExpanded: false,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F2F4),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'Тип мойки',
                  items: <String>['Тип мойки', 'Option 1', 'Option 2']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              color: Color.fromRGBO(69, 75, 84, 1.0))),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  dropdownColor: const Color(0xFFF1F2F4),
                  style:
                      const TextStyle(color: Color.fromRGBO(69, 75, 84, 1.0)),
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color(0xFF454B54)),
                  iconSize: 24,
                  isDense: true,
                  isExpanded: false,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1F2F4),
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: 'Рейтинг',
                  items: <String>['Рейтинг', 'Option 1', 'Option 2']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(
                              color: Color.fromRGBO(69, 75, 84, 1.0))),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  dropdownColor: const Color(0xFFF1F2F4),
                  style:
                      const TextStyle(color: Color.fromRGBO(69, 75, 84, 1.0)),
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color(0xFF454B54)),
                  iconSize: 24,
                  isDense: true,
                  isExpanded: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
