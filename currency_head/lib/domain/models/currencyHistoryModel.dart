import 'dart:convert';

class CurrencyHistoryModel {
  final dynamic id;
  final dynamic value;
  final dynamic date;

  CurrencyHistoryModel({
    required this.id,
    required this.value,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'value': value,
      'date': date,
    };
  }

  factory CurrencyHistoryModel.fromMap(Map<String, dynamic> map) {
    return CurrencyHistoryModel(
      id: map['_id'],
      value: map['value'],
      date: map['date'],
    );
  }

  // String toJson() => json.encode(toMap());
  Map<String, dynamic> toJson() => {
        "_id": id,
        "value": value,
        "date": date,
      };

  factory CurrencyHistoryModel.fromJson(String source) =>
      CurrencyHistoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ceated history Model ===>\n' +
        'id: $id\n' +
        'value: $value\n' +
        'date: $date\n';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyHistoryModel &&
        // other.id == id &&
        other.value == value &&
        other.date == date;
  }

  @override
  int get hashCode {
    return
        // id.hashCode ^
        value.hashCode ^ date.hashCode;
  }
}
