import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class EditFacilitiesRoomController extends ChangeNotifier {
  List<dynamic> listFacilities = [];
  bool isLoading = false;

  EditFacilitiesRoomController({List<dynamic>? listFacilitiesRoom}) {
    listFacilities = listFacilitiesRoom!;
  }
  void setFacilities(String key, bool check) {
    if (check) {
      if (!listFacilities.contains(key)) {
        listFacilities.add(key);
      }
    } else {
      listFacilities.remove(key);
    }
    notifyListeners();
  }

  Future<String> updateFacilitiesRoom(String roomId) async {
    isLoading = true;
    notifyListeners();
    String result = await FirebaseFunctions.instance
        .httpsCallable('bookingengine-updateFacilitesRoom')
        .call({
          'hotel_id': GeneralManager.hotel!.id,
          'room_id': roomId,
          'listfacilites': listFacilities,
        })
        .then((value) => value.data)
        .onError((error, stackTrace) => error.toString());
    if (result == MessageCodeUtil.SUCCESS) {
      GeneralManager.hotel!.hotelFacilities = listFacilities;
      GeneralManager().notifyListeners();
    }
    isLoading = false;
    notifyListeners();
    return result;
  }
}
