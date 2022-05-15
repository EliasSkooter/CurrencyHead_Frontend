import 'dart:convert';

class MarketModel {
  final dynamic id;
  final dynamic userEmail;
  final dynamic currName;
  final dynamic currAmount;
  final List acceptedCurr;

  MarketModel({
    required this.id,
    required this.userEmail,
    required this.currName,
    required this.currAmount,
    required this.acceptedCurr,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'user_email': userEmail,
      'curr_name': currName,
      'curr_amount': currAmount,
      'accepted_curr': acceptedCurr
    };
  }

  factory MarketModel.fromMap(Map<String, dynamic> map) {
    return MarketModel(
        id: map['_id'],
        userEmail: map['user_email'],
        currName: map['curr_name'],
        currAmount: map['curr_amount'],
        acceptedCurr: map['accepted_curr']);
  }

  // String toJson() => json.encode(toMap());
  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_email": userEmail,
        "curr_name": currName,
        "curr_amount": currAmount,
        "accepted_curr": acceptedCurr,
      };

  factory MarketModel.fromJson(String source) =>
      MarketModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ceated history Model ===>\n'
        'id: $id\n'
        'userEmail: $userEmail\n'
        'currName: $currName\n'
        'currAmount $currAmount\n'
        'acceptedCurr $acceptedCurr\n';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MarketModel &&
        // other.id == id &&
        other.userEmail == userEmail &&
        other.currName == currName &&
        other.currAmount == currAmount &&
        other.acceptedCurr == acceptedCurr;
  }

  @override
  int get hashCode {
    return
        // id.hashCode ^
        userEmail.hashCode ^
            currName.hashCode ^
            currAmount.hashCode ^
            acceptedCurr.hashCode;
  }
}
