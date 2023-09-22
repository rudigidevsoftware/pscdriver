class CallData {
  String? id;
  String? callerName;
  String? handle;
  bool? hasVideo;
  double? duration;
  bool? isAccepted;
  Extra? extra;
  CallData(
      {required this.id,
      required this.callerName,
      required this.handle,
      required this.hasVideo,
      required this.duration,
      required this.isAccepted,
      required this.extra});
  factory CallData.fromJson(Map<String, dynamic> object) => CallData(
      id: object['id'],
      callerName: object['callerName'],
      handle: object['handle'],
      hasVideo: object['hasVideo'],
      duration: object['duration'],
      isAccepted: object['isAccepted'],
      extra: Extra.fromJson(object['extra']));
}

class Extra {
  String? tokenOrder;
  Extra({required this.tokenOrder});
  factory Extra.fromJson(Map<String, dynamic> object) =>
      Extra(tokenOrder: object['tokenOrder']);
}
