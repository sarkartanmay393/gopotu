class TipsSendModel {
  final int tips;
  String type;
  // Add this line

  TipsSendModel({required this.tips, required this.type});

  Map<String, dynamic> toJson() {
    return {
      'tips': tips,
      'type': type,
      // Add this line
    };
  }
}
