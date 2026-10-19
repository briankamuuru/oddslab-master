import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/odd_model.dart';
import '../models/ticket_model.dart';

final oddsRepositoryProvider = Provider((ref) {
  return OddsRepository();
});

class OddsRepository {
 Stream<List<Ticket>> getTickets(String collection, String type) {
    return FirebaseFirestore.instance
        .collection(collection)
        .orderBy("postedDate", descending: true)
        .where("type", isEqualTo: type)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Ticket.fromMap(doc.data())).toList());
  }
}
