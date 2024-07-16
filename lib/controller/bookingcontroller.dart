import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/dateutil.dart';
import 'package:bookingengine_frontend/util/neutrontextformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingController extends ChangeNotifier {
  TextEditingController? teName, teEmail, tePhone, teNotes;
  String? roomTypeID;
  NeutronInputNumberController? teAdult = NeutronInputNumberController(
          TextEditingController(text: 0.toString())),
      teChild = NeutronInputNumberController(
          TextEditingController(text: 0.toString()));
  late DateTime inDate, outDate;
  List<String> listRoomTypeName = [];
  BookingController() {
    final now = Timestamp.now().toDate();
    roomTypeID = GeneralManager.listRoomTypes.first.name!;
    inDate = now;
    outDate = inDate.add(const Duration(days: 1));
  }
  List<String> getRoomTypeNames() {
    listRoomTypeName.clear();

    for (var element in GeneralManager.listRoomTypes) {
      listRoomTypeName.add(element.name!);
    }
    return listRoomTypeName;
  }

  void setInDate(DateTime inDate, TimeOfDay? newStart) async {
    // if (statusBookingType == BookingType.hourly && newStart != null) {
    //   inDateHour = DateTime(inDate.year, inDate.month, inDate.day,
    //       newStart.hour, newStart.minute);
    //   if (inDateHour!.isAfter(outDateHour!) ||
    //       TimeOfDayUtil.compare(newStart, hourFrameEnd) == 0) {
    //     outDateHour = DateTime(inDate.year, inDate.month, inDate.day,
    //         newStart.hour + 1, newStart.minute);
    //   }
    //   notifyListeners();
    // }
    if (DateUtil.equal(inDate, this.inDate)) {
      return;
    }
    // updating = true;
    this.inDate = DateUtil.to12h(inDate);
    notifyListeners();
    if (outDate.compareTo(this.inDate) <= 0) {
      outDate = this.inDate.add(const Duration(days: 1));
    }
  }

  void setOutDate(DateTime outDate, TimeOfDay? newEnd) async {
    // if (statusBookingType == BookingType.hourly && newEnd != null) {
    //   outDateHour = DateTime(
    //       outDate.year, outDate.month, outDate.day, newEnd.hour, newEnd.minute);
    //   if (outDateHour!.isBefore(inDateHour!)) {
    //     inDateHour = DateTime(outDate.year, outDate.month, outDate.day,
    //         newEnd.hour - 1, newEnd.minute);
    //     inDate = DateUtil.to12h(outDate);
    //     this.outDate = DateUtil.to12h(outDate.add(const Duration(days: 1)));
    //   }
    //   notifyListeners();
    // }
    if (DateUtil.equal(outDate, this.outDate)) {
      return;
    }
    if (!outDate.isAfter(inDate)) {
      return;
    }
    // updating = true;
    notifyListeners();
    final outDate12h = DateUtil.to12h(outDate);
    if (outDate12h.compareTo(inDate) <= 0) {
      // updating = false;
      notifyListeners();
      return;
    }
    this.outDate = outDate12h;
  }

  DateTime getFirstDate() {
    final now = Timestamp.now().toDate();
    final now12h = DateUtil.to12h(now);
    if (now.compareTo(now12h) >= 0) {
      return now12h;
    } else {
      return now12h.subtract(const Duration(days: 1));
    }
  }

  DateTime getLastInDate() {
    return inDate.add(Duration(days: GeneralManager.maxLengthStayOta));
  }

  DateTime getLastDate() {
    return inDate.add(Duration(days: GeneralManager.maxLengthStayOta));
  }

  String getNameRoomTypeById(String id) {
    return GeneralManager.listRoomTypes
            .firstWhere((element) => element.id == id)
            .name ??
        "";
  }
}
