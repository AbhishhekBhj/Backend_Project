class ProfilePictureUploadResponse {
  final int status;
  final String message;
  final String profilePictureUrl; // Modify data field to profilePictureUrl

  ProfilePictureUploadResponse({
    required this.status,
    required this.message,
    required this.profilePictureUrl, // Update field name
  });

  factory ProfilePictureUploadResponse.fromJson(Map<String, dynamic> json) {
    return ProfilePictureUploadResponse(
      status: json['status'],
      message: json['message'],
      profilePictureUrl: json['data']['profile_picture'], // Update field name
    );
  }
}


class ProfilePictureData {
  final String profilePicture;

  ProfilePictureData({
    required this.profilePicture,
  });
}
