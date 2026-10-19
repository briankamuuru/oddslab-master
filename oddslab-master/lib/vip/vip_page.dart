import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../logic/odds_controller.dart';
import '../../logic/payments.dart';
import '../models/odd_model.dart';
import '../odd_item.dart';
import '../widgets/ticket_item.dart';

class VipPage extends ConsumerStatefulWidget {
  final String type;
  final String sectionId;
  final String itemName;
  final String weeklyPrice;
  final String monthlyPrice;
  const VipPage({
    super.key,
    required this.sectionId,
    required this.itemName,
    required this.type,
    required this.monthlyPrice,
    required this.weeklyPrice,
  });

  @override
  ConsumerState<VipPage> createState() => _VipPageState();
}

class _VipPageState extends ConsumerState<VipPage> {
  Offering? offering;
  @override
  initState() {
    super.initState();
    fetchOffering();
  }

  Future<void> fetchOffering() async {
    final f = await PurchaseApi.getOffers(widget.sectionId);
    if (f != null) {
      setState(() {
        offering = f;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final revenueCatProvider = ref.watch(revenuecatProvider);
    final sectionDetails = allSections
        .firstWhere((section) => section.sectionId == widget.sectionId);
    final entitlement =
        revenueCatProvider.sectionEntitlements[widget.sectionId] ??
            sectionDetails.defaultEntitlement;

    if (offering == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        title: Text("\n${widget.itemName.toUpperCase()}"),
        backgroundColor: const Color.fromRGBO(3, 14, 0, 1),
        elevation: 0,
        foregroundColor: Colors.white,
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
        child: SizedBox(
          child: buildSubscriptionItem(entitlement),
        ),
      ),
    );
  }

  Widget buildSubscriptionItem(Entitlement entitlement) {
    switch (entitlement) {
      case Entitlement.free:
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ref.watch(vipTicketsProvider(widget.type)).when(
              data: (odds) {
                return ListView.builder(
                  itemCount: odds.length,
                  itemBuilder: (context, index) {
                    final ticket = odds[index];
                    return TicketItem(ticket: ticket);
                  },
                );
              },
              error: (error, stackTrace) {
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
        );

      case Entitlement.vip_tips:
        return buildPaywall();
    }
  }

  Future fetchandPurchaseOffering(
    BuildContext context,
    int index,
  ) async {
    final messenger = ScaffoldMessenger.of(context);

    final offering = await PurchaseApi.getOffers(widget.sectionId);
    if (offering == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('No offerings available'),
        ),
      );
    } else {
      final requiredPackage = offering.availablePackages[index];

      await PurchaseApi.purchasePackage(requiredPackage);

      setState(() {});
    }
  }

  Widget buildPaywall() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "SUBSCRIBE TO ${widget.itemName.toUpperCase()}",
            style: const TextStyle(
              fontSize: 18,
              //uppercase
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              buildVipItem(
                name: "GET WEEKLY VIP",
                price: offering!.availablePackages[0].storeProduct.priceString,
                context: context,
                index: 0,
              ),
              buildVipItem(
                name: "GET MONTHLY VIP",
                price: offering!.availablePackages[1].storeProduct.priceString,
                context: context,
                index: 1,
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'App subscription will renew automatically.You can turn off this in your Google Play payments profile.\n If you cancel, you can still use the subscription until the current billing period ends.\nIf you have any questions or need help, please contact us at:\ngikutha7@gmail.com',
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildVipItem({
    required String name,
    required String price,
    required BuildContext context,
    required int index,
  }) {
    return GestureDetector(
      onTap: () => fetchandPurchaseOffering(context, index),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: const Color.fromARGB(255, 55, 29, 117),

          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 138, 114, 9),
              Colors.blueGrey,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              price,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
