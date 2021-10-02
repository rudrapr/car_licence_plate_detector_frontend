import 'dart:io';

import 'package:car_number_plate_detection/models/detection_model.dart';
import 'package:dio/dio.dart';

class DetectionService {
  late Dio _dio;
  BaseOptions _options = new BaseOptions(
    baseUrl: 'https://car-number-plate-detector.herokuapp.com',
    contentType: Headers.jsonContentType,
    connectTimeout: 20000,
    receiveTimeout: 50000,
  );

  DetectionService() {
    _dio = Dio(_options);
  }

  Future<DetectionModel> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var response = await _dio.post("/detect_image", data: formData);
    print('responce: $response');
    return DetectionModel.fromJson(response.data);
  }
}
