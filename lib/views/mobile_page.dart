
import 'package:car_number_plate_detection/bloc/detection_bloc/detection_bloc.dart';
import 'package:car_number_plate_detection/bloc/image_selection_bloc/image_selection_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MobileDetectorPage extends StatefulWidget {
  MobileDetectorPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MobileDetectorPageState createState() => _MobileDetectorPageState();
}

class _MobileDetectorPageState extends State<MobileDetectorPage> {
  BoxDecoration decoration = BoxDecoration(
      border: Border.all(color: Colors.blue, width: 4),
      borderRadius: BorderRadius.all(Radius.circular(8)));

  Widget _drawBoundingBox(DetectionState state) {
    if (state is DetectionSuccess) {
      double factorX = (400 / 224).abs();
      double factorY = (400 / 224).abs();

      return Container(
          child: Positioned(
              left: (state.model.bbBox![2]) * factorX,
              top: (state.model.bbBox![3]) * factorY,
              width: (state.model.bbBox![0] - state.model.bbBox![2]) * factorX,
              height: (state.model.bbBox![1] - state.model.bbBox![3]) * factorY,
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                color: Colors.greenAccent,
                width: 2,
              )))));
    }
    return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocConsumer<DetectionBloc, DetectionState>(
            listener: (context, detectionState) {
          if (detectionState is DetectionFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(detectionState.message)));
          }
        }, builder: (context, detectionState) {
          return BlocConsumer<ImageSelectionBloc, ImageSelectionState>(
              listener: (context, selectionState) {},
              builder: (context, selectionState) {
                return Column(
                  children: [
                    Container(
                        height: 400,
                        width: 400,
                        margin: EdgeInsets.all(5),
                        decoration: decoration,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            selectionState is ImageSelectionSuccess
                                ? Image.file(
                                    selectionState.imageFile,
                                    fit: BoxFit.fill,
                                    height: double.infinity,
                                    width: double.infinity,
                                  )
                                : ElevatedButton.icon(
                                    icon: Icon(Icons.image),
                                    // style: style,
                                    label: Text('choose image'),
                                    onPressed: () async {
                                      context
                                          .read<ImageSelectionBloc>()
                                          .add(ImageSelectionSelect());
                                    },
                                  ),
                            _drawBoundingBox(detectionState),
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.redAccent.shade200,
                                              width: 2)),
                                      padding: EdgeInsets.all(4),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.redAccent.shade200,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        context
                                            .read<ImageSelectionBloc>()
                                            .add(ImageSelectionClear());
                                        context
                                            .read<DetectionBloc>()
                                            .add(DetectionEventClear());
                                      });
                                    },
                                  ),
                                ))
                          ],
                        )),
                    Container(
                        height: 100,
                        width: double.infinity,
                        margin: EdgeInsets.all(5),
                        decoration: decoration,
                        child: Center(
                            child: Text(detectionState is DetectionSuccess
                                ? detectionState.model.prediction!
                                : ''))),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: detectionState is DetectionLoading
                          ? CircularProgressIndicator()
                          : SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  child: Text('DETECT NUMBER PLATE'),
                                  onPressed: selectionState
                                          is ImageSelectionSuccess
                                      ? () {
                                          context.read<DetectionBloc>().add(
                                              DetectionEventDetect(
                                                  selectionState.imageFile));
                                        }
                                      : null),
                            ),
                    ),
                  ],
                );
              });
        }));
  }
}
