import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../logic/odds_controller.dart';
import 'widgets/ticket_item.dart';

class FreePage extends ConsumerStatefulWidget {
  final String title;
  final String type;
  const FreePage({super.key, required this.type, required this.title});

  @override
  ConsumerState<FreePage> createState() => _FreePageState();
}

class _FreePageState extends ConsumerState<FreePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
        ),
        backgroundColor: const Color.fromARGB(255, 13, 51, 4),
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ref.watch(freeTicketsProvider(widget.type)).when(
            data: (odds) {
              print(odds);
              return ListView.builder(
                itemCount: odds.length,
                itemBuilder: (context, index) {
                  final ticket = odds[index];
                  return TicketItem(ticket: ticket);
                },
              );
            },
            error: (error, stackTrace) {
              print(stackTrace);
              return const Center(
                child: Text(
                    "Something unexpected happened.\nContact us if this persists"),
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Color.fromARGB(255, 55, 207, 9),
      //   extendedPadding: const EdgeInsets.symmetric(
      //     horizontal: 50,
      //     vertical: 20,
      //   ),
      //   icon: const Icon(
      //     Icons.telegram,
      //     color: Colors.white,
      //   ),
      //   onPressed: () {
      //     _launchInBrowser("https://t.me/+TBBEkIiFJTE3Yzhk");
      //   },
      //   label: const Text(
      //     "Join Telegram",
      //     style: TextStyle(fontSize: 24, color: Colors.white),
      //   ),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //link launcher
  Future<void> _launchInBrowser(linkName) async {
    final uri = Uri.parse(linkName);
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      throw 'Could not launch $linkName';
    }
  }
}
