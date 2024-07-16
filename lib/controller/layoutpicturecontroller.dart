import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class LayOutPictureController extends ChangeNotifier {
  String? layoutHotel;
  String? layoutRoom;
  bool isInProgress = false;
  LayOutPictureController() {
    layoutHotel = GeneralManager.hotel?.layoutHotel!;
    layoutRoom = GeneralManager.hotel?.layoutRoom!;
  }
  Future<String> updateLayout() async {
    Map<String, String> dataUpdate = {};
    dataUpdate['hotel'] = layoutHotel!;
    dataUpdate['room'] = layoutRoom!;
    isInProgress = true;
    notifyListeners();
    String result = await FirebaseFunctions.instance
        .httpsCallable('bookingengine-updateLayout')
        .call({
          'hotel_id': GeneralManager.idHotel,
          'hotel': layoutHotel,
          'room': layoutRoom
        })
        .then((value) => value.data)
        .onError((error, stackTrace) => error.toString());
    if (result == MessageCodeUtil.SUCCESS) {
      GeneralManager.hotel!.layoutHotel = dataUpdate['hotel'];
      GeneralManager.hotel!.layoutRoom = dataUpdate['room'];
      GeneralManager().notifyListeners();
    }
    isInProgress = false;
    notifyListeners();
    return result;
  }
}
