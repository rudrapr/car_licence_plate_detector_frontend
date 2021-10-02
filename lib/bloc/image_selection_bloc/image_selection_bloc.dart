import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_selection_event.dart';

part 'image_selection_state.dart';

class ImageSelectionBloc
    extends Bloc<ImageSelectionEvent, ImageSelectionState> {
  ImageSelectionBloc() : super(ImageSelectionInitial()) {
    on<ImageSelectionSelect>(_onImageSelectionSelect);
    on<ImageSelectionClear>(_onImageSelectionClear);
  }

  ImagePicker _picker = ImagePicker();

  Future<void> _onImageSelectionSelect(
      ImageSelectionSelect event, Emitter<ImageSelectionState> emit) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('image path: ${image.path}');
      emit(ImageSelectionSuccess(File(image.path)));
    } else {
      emit(ImageSelectionFailure(message: 'ImageSelection Failed'));
    }
  }

  _onImageSelectionClear(
      ImageSelectionClear event, Emitter<ImageSelectionState> emit) {
    emit(ImageSelectionCleared());
  }
}
