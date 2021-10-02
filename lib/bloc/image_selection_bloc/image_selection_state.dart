part of 'image_selection_bloc.dart';

@immutable
abstract class ImageSelectionState {}

class ImageSelectionInitial extends ImageSelectionState {}

class ImageSelectionSuccess extends ImageSelectionState {
  final File imageFile;

  ImageSelectionSuccess(this.imageFile);
}

class ImageSelectionCleared extends ImageSelectionState {}

class ImageSelectionFailure extends ImageSelectionState {
  final String? message;

  ImageSelectionFailure({this.message});
}
