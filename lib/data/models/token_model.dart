class TokenModel {
  String? token;
  String? refreshToken;
  int? lifetime;

  TokenModel({required this.token, required this.refreshToken, this.lifetime});

  TokenModel.fromJson(Map<String, dynamic> json) {
    token = json['access'];
    refreshToken = json['refresh'];
    lifetime = json['lifetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access'] = this.token;
    data['refresh'] = this.refreshToken;
    data['lifetime'] = this.lifetime;
    return data;
  }
}
