import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class HtmlController extends ChangeNotifier {
  String describe = '';
  bool isLoading = false;

  HtmlController();

  Future<String> addDescribe(String txt, RoomType? roomType) async {
    isLoading = true;
    notifyListeners();
    if (txt.isNotEmpty) {
      if (txt == GeneralManager.hotel!.describe) {
        isLoading = false;
        notifyListeners();
        return MessageCodeUtil.STILL_NOT_CHANGE_VALUE;
      }
      describe = txt;
      if (roomType == null) {
        String result = await FirebaseFunctions.instance
            .httpsCallable('bookingengine-updateDescribe')
            .call({
              'hotel_id': GeneralManager.hotel!.id,
              'describe': describe,
            })
            .then((value) => value.data)
            .onError((error, stackTrace) => error.toString());
        if (result == MessageCodeUtil.SUCCESS) {
          GeneralManager.hotel!.describe = describe;
          GeneralManager().notifyListeners();
        }
        isLoading = false;
        notifyListeners();
        return result;
      } else {
        String result = await FirebaseFunctions.instance
            .httpsCallable('bookingengine-updateDescribeRoom')
            .call({
              'hotel_id': GeneralManager.hotel!.id,
              'room_id': roomType.id,
              'describe': describe,
            })
            .then((value) => value.data)
            .onError((error, stackTrace) => error.toString());
        if (result == MessageCodeUtil.SUCCESS) {
          for (var room in GeneralManager.listRoomTypes) {
            if (room.id == roomType.id) {
              room.describeRoom = describe;
            }
          }
        }
        isLoading = false;
        notifyListeners();
        return result;
      }
    } else {
      isLoading = false;
      notifyListeners();
      return MessageCodeUtil.NO_DATA;
    }
  }
}
