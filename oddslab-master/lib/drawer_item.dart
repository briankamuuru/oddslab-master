import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget drawerItem(
    {required String name, required IconData myIcon, required String link}) {
  Future<void> launchInBrowser(linkName) async {
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

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: ListTile(
      tileColor: Color.fromARGB(255, 0, 0, 0),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      trailing: Icon(
        myIcon,
        size: 28,
        color: Colors.white,
      ),
      onTap: () {
        launchInBrowser(link);
      },
    ),
  );
}
