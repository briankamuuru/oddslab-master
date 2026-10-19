import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'drawer_item.dart';
import 'firebase_options.dart';
import 'logic/payments.dart';
import 'logic/odds_controller.dart';
import 'widgets/free_item.dart';
import 'widgets/ticket_item.dart';
import 'widgets/vip_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PurchaseApi.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Permission.notification.isDenied.then(
    (value) {
      if (value) {
        Permission.notification.request();
      }
    },
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

//background handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OddsLab VIP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: 'Ubuntu',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 19,
          ),
          bodyLarge: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        centerTitle: true,
        title: const Text(
          'ODDSLAB VIP',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 13, 51, 4),
        elevation: 0,
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: const Color.fromARGB(255, 13, 51, 4),
          child: Column(
            children: [
              drawerItem(
                name: "Privacy Policy",
                myIcon: Icons.policy,
                link:
                    "https://www.freeprivacypolicy.com/live/209354b9-7aae-4967-905f-131158536416",
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(3, 14, 0, 1),
              Color.fromARGB(255, 20, 85, 6),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Text('FREE TIPS',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2)),
              ),
              Expanded(
                flex: 5,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.1,
                  children: const [
                    HomeItem(itemName: 'Daily Free Matches', type: 'free'),
                    HomeItem(itemName: 'Sure Draws History', type: 'drhist'),
                    HomeItem(
                        itemName: '2 Sure Odds History', type: '2oddshist'),
                    HomeItem(itemName: 'HT/FT History', type: 'htfthist'),
                    HomeItem(itemName: 'Correct Score History', type: 'cshist'),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 4, top: 12, bottom: 8),
                child: Text('VIP TIPS',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2)),
              ),
              Expanded(
                flex: 5,
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.6,
                  children: const [
                    VipItem(
                        itemName: 'SURE DRAWS VIP',
                        type: 'sd',
                        weeklyPrice: '20',
                        monthlyPrice: '30'),
                    VipItem(
                        itemName: '2 SURE ODDS FIXED',
                        type: 'ov',
                        weeklyPrice: '10',
                        monthlyPrice: '20'),
                    VipItem(
                        itemName: 'FIXED HT/FT VIP',
                        type: 'fo',
                        weeklyPrice: '12',
                        monthlyPrice: '25'),
                    VipItem(
                        itemName: 'CORRECT SCORE FIXED VIP',
                        type: 'cs',
                        weeklyPrice: '40',
                        monthlyPrice: '60'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 55, 207, 9),
        extendedPadding: const EdgeInsets.symmetric(
          horizontal: 50,
          vertical: 20,
        ),
        icon: const Icon(
          Icons.telegram,
          color: Colors.white,
        ),
        onPressed: () {
          _launchInBrowser("https://t.me/oddlab22");
        },
        label: const Text(
          "Join Telegram",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
