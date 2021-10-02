part of 'image_selection_bloc.dart';

@immutable
abstract class ImageSelectionEvent {}

class ImageSelectionSelect extends ImageSelectionEvent {}

class ImageSelectionClear extends ImageSelectionEvent {}
