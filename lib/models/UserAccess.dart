class UserAccess {
  String? username;
  String? accessToken;
  String? refreshToken;

  UserAccess({this.accessToken, this.refreshToken, this.username});

  String? get getAccessToken {
    return accessToken;
  }

  String? get getRefreshToken {
    return refreshToken;
  }

  String? get getUsername {
    return username;
  }

  void set setAccessToken(String value) {
    accessToken = value;
  }

  void set setRefreshToken(String value) {
    refreshToken = value;
  }

  void set setUsername(String value) {
    username = value;
  }
}
