// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'odd_model.dart';

class Ticket {
  String id;
  final List<FreeOddModel>? odds;
  final String ticketDate;
  final DateTime postedDate;
  final String type;

  Ticket({
    this.id = '',
    this.odds,
    required this.ticketDate,
    required this.postedDate,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'odds': odds?.map((x) => x.toMap()).toList(),
      'ticketDate': ticketDate,
      'postedDate': postedDate.millisecondsSinceEpoch,
      'type': type,
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      id: map['id'] as String,
      odds: map['odds'] != null ? List<FreeOddModel>.from((map['odds'] as List).map<FreeOddModel?>((x) => FreeOddModel.fromMap(x as Map<String,dynamic>),),) : null,
      ticketDate: map['ticketDate'] as String,
      postedDate: DateTime.fromMillisecondsSinceEpoch(map['postedDate'] as int),
      type: map['type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Ticket.fromJson(String source) => Ticket.fromMap(json.decode(source) as Map<String, dynamic>);

  Ticket copyWith({
    String? id,
    List<FreeOddModel>? odds,
    String? ticketDate,
    DateTime? postedDate,
    String? type,
  }) {
    return Ticket(
      id: id ?? this.id,
      odds: odds ?? this.odds,
      ticketDate: ticketDate ?? this.ticketDate,
      postedDate: postedDate ?? this.postedDate,
      type: type ?? this.type,
    );
  }
}
