import 'package:car_number_plate_detection/views/mobile_page.dart';
import 'package:flutter/material.dart';

class DetectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MobileDetectorPage(title: 'Detector Page'),
    );
  }
}
