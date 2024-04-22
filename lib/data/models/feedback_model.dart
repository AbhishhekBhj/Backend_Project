class FeedbackModel {
  String title;
  String message;
  String feedBackProvidedBy;

  FeedbackModel(
      {required this.title,
      required this.message,
      required this.feedBackProvidedBy});

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      title: json['title'],
      message: json['message'],
      feedBackProvidedBy: json['feedback_provided_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'feedback_provided_by': feedBackProvidedBy,
    };
  }
}
