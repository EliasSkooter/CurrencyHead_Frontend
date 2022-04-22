class LogedUser {
  late final String username;
  late final String accessToken;
  late final String name;
  late final String surname;
  late final List currencies;

  LogedUser({
    required this.username,
    required this.accessToken,
    required this.name,
    required this.surname,
    required this.currencies,
  });

  LogedUser.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    accessToken = json['accessToken'];
    name = json['name'];
    surname = json['surname'];
    currencies = json['currencies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = username;
    data['accessToken'] = accessToken;
    data['name'] = name;
    data['surname'] = surname;
    data['currencies'] = currencies;
    return data;
  }

  LogedUser copyWith({
    String? username,
    String? accessToken,
    String? name,
    String? surname,
    List? currencies,
  }) {
    return LogedUser(
      username: username ?? this.username,
      accessToken: accessToken ?? this.accessToken,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      currencies: currencies ?? this.currencies,
    );
  }

  @override
  String toString() {
    return 'LogedUser( username: $username, accessToken: $accessToken, name: $name, surname: $surname)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LogedUser &&
        other.username == username &&
        other.accessToken == accessToken &&
        other.name == name &&
        other.surname == surname;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        accessToken.hashCode ^
        name.hashCode ^
        surname.hashCode;
  }
}
