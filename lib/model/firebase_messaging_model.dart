class ResponseFirebaseMessaging {
  String? tokenOrder;
  ResponseFirebaseMessaging({required this.tokenOrder});
  factory ResponseFirebaseMessaging.fromJsonApi(Map<String, dynamic> object) =>
      ResponseFirebaseMessaging(tokenOrder: object['report_path']);
}
