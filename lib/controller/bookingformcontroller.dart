import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/booking.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class BookingFormController extends ChangeNotifier {
  int? index;
  double? process;
  String raidoText = 'ck';
  TextEditingController? teName, teEmail, tePhone, teNotes;
  num total = 0;
  BookingFormController() {
    index = 0;
    process = 0;
    teName = TextEditingController(text: '');
    teEmail = TextEditingController(text: '');
    tePhone = TextEditingController(text: '');
    teNotes = TextEditingController(text: '');
  }
  setIndex() {
    index = index! + 1;
    print(index);
    setProcess();
    notifyListeners();
  }

  removeIndex() {
    index = index! - 1;
    print(index);
    setProcess();
    notifyListeners();
  }

  void setProcess() {
    if (index == 0) {
      process = 0;
    } else if (index == 1) {
      process = 400;
    } else {
      process = 800;
    }
    notifyListeners();
  }

  Future<String> getUrlPaymentVNPay(num amount, String idBooking) async {
    return await FirebaseFunctions.instance
        .httpsCallable("bookingengine-payemntVnPayBookingEngine")
        .call({
      'hotel_id': GeneralManager.idHotel,
      'amount': amount,
      'idBooking': idBooking
    }).then((value) {
      notifyListeners();
      return value.data;
    }).onError((error, stackTrace) {
      return (error as FirebaseFunctionsException).code;
    });
  }

  Future<String> sendEmail(String email) async {
    return await FirebaseFunctions.instance
        .httpsCallable("bookingengine-sendEmail")
        .call({
      'email': email,
    }).then((value) {
      notifyListeners();
      print(value);
      return value.data;
    }).onError((error, stackTrace) {
      print(error);
      return (error as FirebaseFunctionsException).code;
    });
  }

  Future<String> addBooking(
      int amount,
      DateTime inDate,
      DateTime outDate,
      RoomType roomType,
      int adult,
      int child,
      Map<String, Map<String, num>> teNums,
      int numberRoom,
      Map<String, Map<String, List<num>>>? pricePerNight) async {
    final name = teName!.text;
    final email = teEmail!.text;
    total = 0;
    num totalPrice = 0;
    num totalRoom = 0;
    print(teNums);
    print(pricePerNight);
    for (var key in pricePerNight!.keys) {
      if (teNums.containsKey(key)) {
        totalRoom = 0;
        for (var rateRoomT in pricePerNight[key]!.keys) {
          totalPrice = 0;
          for (var i = 0; i < pricePerNight[key]![rateRoomT]!.length; i++) {
            totalPrice += pricePerNight[key]![rateRoomT]![i];
          }
          totalRoom = totalPrice * teNums[key]![rateRoomT]!;
          total += totalRoom;
        }
      }
    }
    print(total);
    if (name.isEmpty) {
      return MessageUtil.getMessageByCode(MessageCodeUtil.INPUT_NAME);
    }
    if (email.isEmpty) {
      return MessageUtil.getMessageByCode(MessageCodeUtil.INPUT_NAME);
    }

    notifyListeners();
    final result = await Booking(
            group: false,
            ratePlanID: '',
            name: teName!.text.replaceAll(RegExp(r"\s\s+"), ' ').trim(),
            email: teEmail!.text,
            phone: tePhone!.text,
            room: '',
            inDate: inDate,
            inTime: inDate,
            teNums: teNums,
            outDate: outDate,
            outTime: outDate,
            roomTypeID: roomType.id,
            bed: '',
            payAtHotel: true,
            numberRoom: numberRoom,
            breakfast: false,
            lunch: false,
            dinner: false,
            adult: adult,
            child: child,
            pricePerNight: pricePerNight,
            sourceID: 'booking_engine',
            sID: '',
            status: 0,
            isTaxDeclare: false,
            declareGuests: [],
            typeTourists: '',
            country: '',
            bookingType: 0,
            notes: teNotes!.text,
            saler: '',
            externalSaler: '',
            isPriceFirstMonthly: false)
        .add();
    notifyListeners();
    return result;
  }
}
