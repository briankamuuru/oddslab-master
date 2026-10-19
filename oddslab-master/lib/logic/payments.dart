import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static Future<void> init() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup('goog_EQqQSVRPzMATztVtsmYSoVkqUxf');
  }

  static Future<Offering?> getOffers(String identifier) async {
    try {
      final offerings = await Purchases.getOfferings();
      final ourOffering = offerings.all[identifier];

      return ourOffering;
    } on PlatformException catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

enum Entitlement { free, vip_tips }

class SectionDetails {
  final String sectionId;
  final String displayName;
  final Entitlement defaultEntitlement;

  SectionDetails({
    required this.sectionId,
    required this.displayName,
    required this.defaultEntitlement,
  });
}

final List<SectionDetails> allSections = [
  
  SectionDetails(
    sectionId: "ov",
    displayName: "ov",
    defaultEntitlement: Entitlement.free,
  ),
   SectionDetails(
    sectionId: "sd",
    displayName: "sd",
    defaultEntitlement: Entitlement.free,
  ),
   SectionDetails(
    sectionId: "fo",
    displayName: "fo",
    defaultEntitlement: Entitlement.free,
  ),
   SectionDetails(
    sectionId: "cs",
    displayName: "cs",
    defaultEntitlement: Entitlement.free,
  ),
   

];

class RevenueCatProvider extends ChangeNotifier {
  Map<String, Entitlement> _sectionEntitlements = {};
  Map<String, Entitlement> get sectionEntitlements => _sectionEntitlements;

  RevenueCatProvider() {
    init();
  }

  Future init() async {
    Purchases.addCustomerInfoUpdateListener((purchaserInfo) {
      updatePurchaseStatus();
    });
  }

  Future updatePurchaseStatus() async {
    final purchaserInfo = await Purchases.getCustomerInfo();
    _sectionEntitlements = {};

    for (var section in allSections) {
      final entitlement =
          purchaserInfo.entitlements.active[section.sectionId] != null
              ? Entitlement.vip_tips
              : section.defaultEntitlement;
      _sectionEntitlements[section.sectionId] = entitlement;
    }

    notifyListeners();
  }
}

final revenuecatProvider =
    ChangeNotifierProvider((ref) => RevenueCatProvider());
