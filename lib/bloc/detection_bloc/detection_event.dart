part of 'detection_bloc.dart';

@immutable
abstract class DetectionEvent {}

class DetectionEventDetect extends DetectionEvent {
  final File file;

  DetectionEventDetect(this.file);
}

class DetectionEventClear extends DetectionEvent {}
