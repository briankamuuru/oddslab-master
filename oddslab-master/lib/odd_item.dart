import 'package:flutter/material.dart';

import 'models/odd_model.dart';

class OddItem extends StatelessWidget {
  final FreeOddModel odd;
  const OddItem({super.key, required this.odd});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
      height: 110,
      decoration: BoxDecoration(
        color: const Color.fromARGB(26, 55, 221, 18),
        borderRadius: BorderRadius.circular(5),
        //very thin shadow on the bottom
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.3),
        //     spreadRadius: 1,
        //     blurRadius: 1,
        //     offset: const Offset(0, 1),
        //   ),
        // ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(odd.matchTime),
                    Text(odd.leagueName),
                    odd.isWon
                        ? const Icon(
                            Icons.check_circle_rounded,
                            color: Color.fromARGB(255, 7, 10, 3),
                          )
                        : const Icon(
                            Icons.pending,
                            color: Color.fromARGB(179, 0, 0, 0),
                          ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      odd.homeTeam,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      odd.awayTeam,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 40, 129, 43),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "Pick: ${odd.tip}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 40, 129, 43),
                        ),
                      ),
                    ),
                    Text(
                      odd.scores,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            odd.odds,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
