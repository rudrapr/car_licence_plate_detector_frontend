import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:car_number_plate_detection/models/detection_model.dart';
import 'package:car_number_plate_detection/service/detection_service.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'dart:ui' as UI;
import 'dart:async';
import 'dart:typed_data';

part 'detection_event.dart';

part 'detection_state.dart';

class DetectionBloc extends Bloc<DetectionEvent, DetectionState> {
  DetectionService _service = DetectionService();

  DetectionBloc() : super(DetectionInitial());

  @override
  Stream<DetectionState> mapEventToState(DetectionEvent event) async* {
    if (event is DetectionEventDetect) {
      yield* _mapDetectionEventDetectToState(event.file);
    } else if (event is DetectionEventClear) {
      yield* _mapDetectionEventClearToState();
    }
  }

  Future<UI.Image> loadUiImage(File file) {
    final Completer<UI.Image> completer = Completer();
    UI.decodeImageFromList(file.readAsBytesSync(), (UI.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Stream<DetectionState> _mapDetectionEventDetectToState(File file) async* {
    yield DetectionLoading();
    try {
      var res = await _service.uploadImage(file);
      var image = await loadUiImage(file);
      print(image.width);
      print(image.height);
      print('res $res');
      yield DetectionSuccess(res, image.width, image.height);
    } on DioError catch (e) {
      yield DetectionFailure(e.message);
    } catch (e) {
      print('err $e');
      yield DetectionFailure(e.toString());
    }
  }

  Stream<DetectionState> _mapDetectionEventClearToState() async* {
    yield DetectionClear();
  }
}
