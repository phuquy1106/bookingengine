import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/booking.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class CancelBookingController extends ChangeNotifier {
  Booking? booking;
  bool? isLoad = false;
  CancelBookingController();

  Future<void> getRoomTypes(String idBooking) async {
    await FirebaseFunctions.instance
        .httpsCallable('bookingengine-getBooking')
        .call({
      'hotel_id': GeneralManager.idHotel,
      'idBooking': idBooking
    }).then((doc) {
      Map<String, dynamic> data = doc.data as Map<String, dynamic>;
      print('data:-------------$data');
      if (data['isGroup'] ?? false) {
        booking = Booking.fromBookingGroup(data);
      } else {
        booking = Booking.fromBooking(data);
      }
    }).onError((error, stackTrace) {
      print(error);
    });
  }

  Future<String> cancel(
      String id, bool group, String sID, String idPayemnt) async {
    isLoad = true;
    notifyListeners();
    return await FirebaseFunctions.instance
        .httpsCallable('bookingengine-cancelBookingEngine')
        .call({
      'hotel_id': GeneralManager.idHotel,
      'booking_id': id,
      'group': group,
      'sid': sID,
      'idPayemnt': idPayemnt,
    }).then((value) {
      isLoad = false;
      notifyListeners();
      return value.data;
    }).catchError((onError) {
      isLoad = false;
      notifyListeners();
      return (onError as FirebaseFunctionsException).message;
    });
  }

  Future cancelGroup(String idBooking, String idPayemnt) async {
    isLoad = true;
    notifyListeners();
    return await FirebaseFunctions.instance
        .httpsCallable('bookingengine-cancelGroupBookingEngine')
        .call({
      'hotel_id': GeneralManager.idHotel,
      'booking_id': idBooking,
      'idPayemnt': idPayemnt,
    }).then((value) {
      isLoad = false;
      notifyListeners();
      return value.data;
    }).onError((error, stackTrace) {
      isLoad = false;
      notifyListeners();
      return (error as FirebaseFunctionsException).message;
    });
  }
}
