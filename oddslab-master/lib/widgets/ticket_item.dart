import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ticket_model.dart';
import '../odd_item.dart';

class TicketItem extends ConsumerStatefulWidget {
  final Ticket ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  ConsumerState<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends ConsumerState<TicketItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5)
          .copyWith(bottom: 15),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 13, 51, 4),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: ${widget.ticket.ticketDate}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                if (widget.ticket.odds != null)
                  Text(
                    "Total Odds: ${widget.ticket.odds!.fold<double>(
                          1,
                          (previousValue, element) =>
                              previousValue * double.parse(element.odds),
                        ).toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ],
            ),
          ),

          if (widget.ticket.odds != null)
            for (var odd in widget.ticket.odds!)
              OddItem(
                odd: odd,
              ),
          //get total odds. Multiply all odds if odds is not empty -to 2 decimal places
        ],
      ),
    );
  }
}
