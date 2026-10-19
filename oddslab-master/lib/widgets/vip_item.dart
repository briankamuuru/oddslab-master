import 'package:flutter/material.dart';
import '../vip/vip_page.dart';

class VipItem extends StatelessWidget {
  final String type;
  final String itemName;
  final String weeklyPrice;
  final String monthlyPrice;
  const VipItem({
    super.key,
    required this.itemName,
    required this.type,
    required this.monthlyPrice,
    required this.weeklyPrice,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VipPage(
            sectionId: type,
            itemName: itemName,
            type: type,
            weeklyPrice: weeklyPrice,
            monthlyPrice: monthlyPrice,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color.fromARGB(255, 138, 114, 9), Colors.blueGrey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: Colors.amber.withOpacity(0.4), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock, color: Colors.amber, size: 20),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                itemName,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
