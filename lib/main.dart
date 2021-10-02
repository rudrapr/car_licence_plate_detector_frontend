import 'package:car_number_plate_detection/bloc/detection_bloc/detection_bloc.dart';
import 'package:car_number_plate_detection/bloc/image_selection_bloc/image_selection_bloc.dart';
import 'package:car_number_plate_detection/views/detection_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
      create: (BuildContext context) => DetectionBloc(),
    ),
    BlocProvider(
      create: (BuildContext context) => ImageSelectionBloc(),
    )
  ], child: DetectionApp()));
}
