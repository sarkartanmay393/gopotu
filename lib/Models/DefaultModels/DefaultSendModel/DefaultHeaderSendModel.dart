// To parse this JSON data, do
//
//     final authorizationModel = authorizationModelFromJson(jsonString);

class DefaultHeaderSendModel {
  DefaultHeaderSendModel({
    this.authorization,
    this.guestToken,
  });

  final String? authorization;
  final String? guestToken;
  factory DefaultHeaderSendModel.fromJson(Map<String, dynamic> json) =>
      DefaultHeaderSendModel(
        authorization:
            json["Authorization"] == null ? null : json["Authorization"],
      );

  Map<String, String> toHeader() => {
        "Authorization": authorization!,
        // "guest-token": guestToken!,
      };
}
