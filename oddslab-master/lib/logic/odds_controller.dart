import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ticket_model.dart';
import 'odds_repository.dart';

final oddsControllerProvider =
    StateNotifierProvider<OddsController, bool>((ref) {
  return OddsController(oddsRepository: ref.watch(oddsRepositoryProvider));
});

final freeTicketsProvider = StreamProvider.family((ref, String type) {
  return ref
      .watch(oddsControllerProvider.notifier)
      .getTickets(collection: "oddslab", type: type);
});
final vipTicketsProvider = StreamProvider.family((ref, String type) {
  return ref
      .watch(oddsControllerProvider.notifier)
      .getTickets(collection: "oddslabvip", type: type);
});

class OddsController extends StateNotifier<bool> {
  final OddsRepository _oddsRepository;
  OddsController({required OddsRepository oddsRepository})
      : _oddsRepository = oddsRepository,
        super(false);
  Stream<List<Ticket>> getTickets(
      {required String collection, required String type}) {
    return _oddsRepository.getTickets(collection, type);
  }
}
