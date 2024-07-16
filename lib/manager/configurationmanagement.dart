import 'dart:async';

import 'package:bookingengine_frontend/handler/firebasehandler.dart';
import 'package:flutter/material.dart';

class ConfigurationManagement extends ChangeNotifier {
  static final ConfigurationManagement _instance =
      ConfigurationManagement._singleton();
  ConfigurationManagement._singleton();
  factory ConfigurationManagement() {
    return _instance;
  }
  StreamSubscription? configurationSubscription;
  bool isConfigurationStreamed = false;
  Future<void> asyncData() async {
    if (isConfigurationStreamed) {
      return;
    }
    isConfigurationStreamed = true;

    print('asyncConfigurationsFromCloud: Init');
    configurationSubscription?.cancel();
    configurationSubscription = FirebaseHandler.hotelRef
        .collection('management')
        .doc('configurations')
        .snapshots()
        .listen((snapshots) {
      if (snapshots.exists) {
        notifyListeners();
      }
    });
  }

  void cancelStream() {
    configurationSubscription?.cancel();
    isConfigurationStreamed = false;
    print('asyncConfigurationAndItem: Cancelled');
  }
}
