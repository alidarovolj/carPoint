import 'package:flutter/material.dart';
import 'package:startup_app/screens/search_bar/search_bar.dart' as custom;
import 'package:startup_app/screens/dropdown_filters/dropdown_filters.dart';
import 'package:startup_app/widgets/car_wash_item.dart';
import 'package:startup_app/stores/test_data_fetch/models/test_data.dart';

class DraggableSheet extends StatelessWidget {
  final double currentExtent;
  final ScrollController scrollController;
  final List<TestData> testDataList;
  final bool Function(DraggableScrollableNotification) onNotification;

  const DraggableSheet({
    Key? key,
    required this.currentExtent,
    required this.scrollController,
    required this.testDataList,
    required this.onNotification,
  }) : super(key: key);

  bool get isSheetFullyOpen => currentExtent == 1.0;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: onNotification,
      child: DraggableScrollableSheet(
        initialChildSize: 0.2,
        minChildSize: 0.2,
        maxChildSize: 0.9,
        snapSizes: const [0.2, 0.9],
        snap: true,
        builder: (BuildContext context, ScrollController scrollController) {
          return AnimatedPadding(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.only(
              top: 0.0,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    const SizedBox(height: 10.0), // Add space at the top
                    Container(
                      width: 50,
                      height: 7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey[300],
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: const custom.SearchBar(),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      child: const DropdownFilters(),
                    ),
                    if (testDataList.isEmpty)
                      const Center(child: CircularProgressIndicator())
                    else
                      ListView.builder(
                        controller: scrollController,
                        itemCount: testDataList.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final item = testDataList[index];
                          return CarWashItem(data: item);
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
