// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/booking.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class BookingFormController extends ChangeNotifier {
  int? index;
  double? process;
  String raidoText = 'ck';
  TextEditingController? teName, teEmail, tePhone, teNotes;
  num total = 0;
  bool isLoad = false;
  bool isPayment = false;
  bool isCheck = false;
  StreamSubscription? activityStream;
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
    setProcess();
    notifyListeners();
  }

  removeIndex() {
    index = index! - 1;
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
    isLoad = true;
    notifyListeners();
    return await FirebaseFunctions.instance
        .httpsCallable("bookingengine-payemntVnPayBookingEngine")
        .call({
      'hotel_id': GeneralManager.idHotel,
      'amount': amount,
      'idBooking': idBooking
    }).then((value) {
      isLoad = false;
      notifyListeners();
      return value.data;
    }).onError((error, stackTrace) {
      isLoad = false;
      notifyListeners();
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

  void cancel() {
    activityStream!.cancel();
  }

  Future<void> isCheckPayment(
    String idBooking,
    int amount,
    DateTime inDate,
    DateTime outDate,
    RoomType roomType,
    int adult,
    int child,
    Map<String, Map<String, num>> teNums,
    int numberRoom,
    Map<String, Map<String, List<num>>>? pricePerNight,
  ) async {
    FirebaseFirestore.instance
        .collection('vnpay')
        .where(FieldPath.documentId, isEqualTo: idBooking)
        .snapshots()
        .listen((event) async {
      if (event.docs.isNotEmpty) {
        print(event.docs.first['status']);
        isCheck = event.docs.first['status'];
        if (isCheck && !isPayment) {
          print('---------------');
          String value = await addBooking(amount, inDate, outDate, roomType,
              adult, child, teNums, numberRoom, pricePerNight, idBooking);
          isPayment = true;
          print(value);
        }
        notifyListeners();
      }
    });
    isLoad = false;
    notifyListeners();
  }

  Future<void> getTotal(
    Map<String, Map<String, num>> teNums,
    Map<String, Map<String, List<num>>>? pricePerNight,
  ) async {
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
      Map<String, Map<String, List<num>>>? pricePerNight,
      String idBookingVnPay) async {
    final name = teName!.text;
    final email = teEmail!.text;
    if (name.isEmpty) {
      return MessageUtil.getMessageByCode(MessageCodeUtil.INPUT_NAME);
    }
    if (email.isEmpty) {
      return MessageUtil.getMessageByCode(MessageCodeUtil.INPUT_NAME);
    }
    isLoad = true;
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
            totalAmount: total,
            bed: '',
            payAtHotel: total == 0 ? true : false,
            numberRoom: numberRoom,
            breakfast: false,
            idBookingVnPay: idBookingVnPay,
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
    isLoad = false;
    notifyListeners();
    return result;
  }
}
