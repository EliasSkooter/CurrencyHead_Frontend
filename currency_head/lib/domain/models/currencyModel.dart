import 'dart:convert';

import 'package:currency_head/domain/models/currencyHistoryModel.dart';

class CurrencyModel {
  final dynamic id;
  final dynamic name;
  final dynamic value;
  final dynamic updateDate;
  final dynamic fluctuation;
  final List<CurrencyHistoryModel> history;

  CurrencyModel({
    required this.id,
    required this.name,
    required this.value,
    required this.updateDate,
    required this.fluctuation,
    required this.history,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'value': value,
      'updateDate': updateDate,
      'fluctuation': fluctuation,
      'history': history,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      id: map['id'],
      name: map['name'],
      value: map['value'],
      updateDate: map['updateDate'],
      fluctuation: map['fluctuation'],
      history: map['history'],
    );
  }

  // String toJson() => json.encode(toMap());
  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "value": value,
        "updateDate": updateDate,
        "fluctuation": fluctuation,
        "history": history,
      };

  factory CurrencyModel.fromJson(String source) =>
      CurrencyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Ceated currency Model ===>\n' +
        'id: $id\n' +
        'name: $name\n' +
        'value: $value\n' +
        'updateDate: $updateDate\n' +
        'fluctuation: $fluctuation\n' +
        'history: $history\n';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyModel &&
        // other.id == id &&
        other.name == name &&
        other.value == value &&
        other.fluctuation == fluctuation &&
        other.updateDate == updateDate &&
        other.history == history;
  }

  @override
  int get hashCode {
    return
        // id.hashCode ^
        name.hashCode ^
            value.hashCode ^
            history.hashCode ^
            fluctuation.hashCode ^
            updateDate.hashCode;
  }
}
