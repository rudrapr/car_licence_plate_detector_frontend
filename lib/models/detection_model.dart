class DetectionModel {
  DetectionModel({
      this.bbBox, 
      this.prediction,});

  DetectionModel.fromJson(dynamic json) {
    bbBox = json['bb_box'] != null ? json['bb_box'].cast<double>() : [];
    prediction = json['prediction'];
  }
  List<double>? bbBox;
  String? prediction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bb_box'] = bbBox;
    map['prediction'] = prediction;
    return map;
  }

}