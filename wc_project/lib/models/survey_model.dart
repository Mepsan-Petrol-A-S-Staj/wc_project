class Survey {
  final int surveyId;
  final int deviceId;
  final int userId;
  final int surveyType;
  final int surveyResult;
  final String surveyDate;
  final String surveyTime;
  final String surveyNote;

  Survey({
    required this.surveyId,
    required this.deviceId,
    required this.userId,
    required this.surveyType,
    required this.surveyResult,
    required this.surveyDate,
    required this.surveyTime,
    required this.surveyNote,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      surveyId: json['surveyId'],
      deviceId: json['deviceId'],
      userId: json['userId'],
      surveyType: json['surveyType'],
      surveyResult: json['surveyResult'],
      surveyDate: json['surveyDate'],
      surveyTime: json['surveyTime'],
      surveyNote: json['surveyNote'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surveyId': surveyId,
      'deviceId': deviceId,
      'userId': userId,
      'surveyType': surveyType,
      'surveyResult': surveyResult,
      'surveyDate': surveyDate,
      'surveyTime': surveyTime,
      'surveyNote': surveyNote,
    };
  }
}
