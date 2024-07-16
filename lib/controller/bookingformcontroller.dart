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

  Future<String> getUrlPaymentVNPay(num amount) async {
    return await FirebaseFunctions.instance
        .httpsCallable("bookingengine-payemntVnPayBookingEngine")
        .call({'hotel_id': GeneralManager.idHotel, 'amount': amount}).then(
            (value) {
      notifyListeners();
      return value.data;
    }).onError((error, stackTrace) {
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
      int numberDay,
      int numberRoom) async {
    bool isAddBooking = true;
    List<num> listAmount = [];
    for (var i = 0; i < numberDay; i++) {
      listAmount.add(amount);
    }

    if (isAddBooking) {
      final name = teName!.text;
      final email = teEmail!.text;
      if (name.isEmpty) {
        return MessageUtil.getMessageByCode(MessageCodeUtil.INPUT_NAME);
      }
      // String? validateSid = StringValidator.validateSid(tesid);
      if (email.isEmpty) {
        return MessageUtil.getMessageByCode(MessageCodeUtil.INPUT_NAME);
      }
      // String? validateSid = StringValidator.validateSid(tesid);
      // if (validateSid != null && tesid.isNotEmpty) {
      //   return validateSid;
      // }

      Map<String, dynamic> mapInvoiceDetail = {};

      // updating = true;
      notifyListeners();
      // export backup here
      final result = await Booking(
              group: false,
              price: listAmount,
              ratePlanID: '',
              name: teName!.text.replaceAll(RegExp(r"\s\s+"), ' ').trim(),
              email: teEmail!.text,
              phone: tePhone!.text,
              room: '',
              inDate: inDate,
              inTime: inDate,
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
              sourceID: 'booking_engine',
              sID: '',
              status: 0,
              isTaxDeclare: false,
              declareGuests: [],
              declareInfo: mapInvoiceDetail,
              typeTourists: '',
              country: '',
              bookingType: 0,
              notes: teNotes!.text,
              saler: '',
              externalSaler: '',
              isPriceFirstMonthly: false)
          .add();
      notifyListeners();
      return MessageUtil.getMessageByCode(result);
    }
  }
}
