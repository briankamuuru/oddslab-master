import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkItem extends StatelessWidget {
  final String icon;
  final String link;

  final String itemName;

  const LinkItem({
    super.key,
    required this.itemName,
    required this.link,
    required this.icon,
  });
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchInBrowser(link);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 55, 29, 117).withOpacity(0.95),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.amberAccent,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    itemName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    icon,
                    height: 45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
