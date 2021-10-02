part of 'detection_bloc.dart';

@immutable
abstract class DetectionState {}

class DetectionInitial extends DetectionState {}

class DetectionLoading extends DetectionState {}

class DetectionClear extends DetectionState {}

class DetectionSuccess extends DetectionState {
  final DetectionModel model;
  final String? message;
  final int imageWidth;
  final int imageHeight;

  DetectionSuccess(this.model, this.imageWidth, this.imageHeight,
      {this.message});
}

class DetectionFailure extends DetectionState {
  final String message;

  DetectionFailure(this.message);
}
