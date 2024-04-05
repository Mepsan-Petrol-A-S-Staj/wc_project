class Survey {
  final String comment, person, surveyDate;
  final int rating;
  final int deviceId;

  Survey({
    required this.rating,
    required this.comment,
    required this.person,
    required this.surveyDate,
    required this.deviceId,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      rating: json['rating'],
      comment: json['comment'],
      person: json['person'],
      surveyDate: json['surveyDate'],
      deviceId: json['deviceId']['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'person': person,
      'surveyDate': surveyDate,
      'deviceId': {'id': deviceId},
    };
  }
}
