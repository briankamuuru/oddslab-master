// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FreeOddModel {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String leagueName;
  final String tip;
  final String matchTime;
  final String scores;
  final String odds;
  final bool isWon;
  final bool isLost;

  FreeOddModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.leagueName,
    required this.tip,
    required this.matchTime,
    required this.scores,
    required this.odds,
    required this.isWon,
    required this.isLost,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'homeTeam': homeTeam,
      'awayTeam': awayTeam,
      'leagueName': leagueName,
      'tip': tip,
      'matchTime': matchTime,
      'scores': scores,
      'odds': odds,
      'isWon': isWon,
      'isLost': isLost,
    };
  }

  factory FreeOddModel.fromMap(Map<String, dynamic> map) {
    return FreeOddModel(
      id: map['id'] as String,
      homeTeam: map['homeTeam'] as String,
      awayTeam: map['awayTeam'] as String,
      leagueName: map['leagueName'] as String,
      tip: map['tip'] as String,
      matchTime: map['matchTime'] as String,
      scores: map['scores'] as String,
      odds: map['odds'] as String,
      isWon: map['isWon'] as bool,
      isLost: map['isLost'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory FreeOddModel.fromJson(String source) => FreeOddModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FreeOddModel copyWith({
    String? id,
    String? homeTeam,
    String? awayTeam,
    String? leagueName,
    String? tip,
    String? matchTime,
    String? scores,
    String? odds,
    bool? isWon,
    bool? isLost,
  }) {
    return FreeOddModel(
      id: id ?? this.id,
      homeTeam: homeTeam ?? this.homeTeam,
      awayTeam: awayTeam ?? this.awayTeam,
      leagueName: leagueName ?? this.leagueName,
      tip: tip ?? this.tip,
      matchTime: matchTime ?? this.matchTime,
      scores: scores ?? this.scores,
      odds: odds ?? this.odds,
      isWon: isWon ?? this.isWon,
      isLost: isLost ?? this.isLost,
    );
  }
}
