class Survey {
  final int rating;
  final int deviceId;
  final String? comment, person, surveyDate;

  Survey({
    required this.rating,
    required this.deviceId,
    this.comment,
    this.person,
    this.surveyDate,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    return Survey(
      rating: json['rating'],
      comment: json['comment'],
      person: json['person'],
      surveyDate: json['surveyDate'],
      deviceId: json['device']['id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'person': person,
      'surveyDate': surveyDate,
      'device': {'id': deviceId},
    };
  }
}
