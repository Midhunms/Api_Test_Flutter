class User {
  User({String? userName, String? token}) {
    _userName = userName;
    _token = token;
  }

  User.fromJson(dynamic json) {
    _userName = json['userName'];
    _token = json['token'];
  }
  String? _userName;
  String? _token;
  User copyWith({String? userName, String? token}) =>
      User(userName: userName ?? _userName, token: token ?? _token);
  String? get userName => _userName;
  String? get token => _token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userName'] = _userName;
    map['token'] = _token;
    return map;
  }
}
