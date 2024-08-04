import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:startup_app/stores/test_data_fetch/models/test_data.dart';

class TestDataFetch {
  Future<List<TestData>> testDataFetch() async {
    try {
      final response = await Dio().get('https://6282500ded9edf7bd882691b.mockapi.io/car_washers');
      final data = response.data as List<dynamic>;

      // Map the response data to a list of TestData objects
      final testDataPool = data.map((item) => TestData.fromJson(item)).toList();

      return testDataPool; // Return the list of TestData objects
    } catch (e) {
      debugPrint('Error fetching data: $e');
      return []; // Return an empty list in case of error
    }
  }
}
