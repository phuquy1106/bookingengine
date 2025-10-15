import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/rateroomtypes.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/dateutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextformfield.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeController extends ChangeNotifier {
  Map<String, String> listPrictureHotel = {};
  Map<String, Map<String, String>> listPrictureRoom = {};
  GlobalKey globalKey = GlobalKey();
  ScrollController scrollController = ScrollController();

  TextEditingController? teName, teEmail, tePhone, teNotes;
  Map<String, Map<String, NeutronInputNumberController>>? teNums = {};
  Map<String, dynamic> data = {};
  Map<String, Map<String, List<num>>> pricePerNight = {};
  List<DateTime> listDate = [];
  Map<String, dynamic> listMonthAndDay = {};
  DateTime? inDate, outDate;
  String? languageLocacl = GeneralManager.locale?.toLanguageTag();
  num total = 0;
  Map<String, dynamic> listNumberRoom = {};
  List<RoomType> listRoomTypes = [];
  Map<String, String> numberR = {};
  Map<String, List<String>> listRoom = {};
  bool isLoading = false;
  String startDay = '';
  String endDay = '';
  NeutronInputNumberController? teAdult = NeutronInputNumberController(
          TextEditingController(text: 0.toString())),
      teChild = NeutronInputNumberController(
          TextEditingController(text: 0.toString())),
      teNumberRoom = NeutronInputNumberController(
          TextEditingController(text: 0.toString()));
  List<dynamic> listFacilities = [];
  Map<String, String> hotelFacilities = {
    UITitleCode.AIR_CONDITIONING: 'assets/icon/facilities_hotel/air-con.svg',
    UITitleCode.AIRPORT_TRANSPORT:
        'assets/icon/facilities_hotel/AirportTransport.svg',
    UITitleCode.FITNESS_CENTER:
        'assets/icon/facilities_hotel/FitnessCenter.svg',
    UITitleCode.HEATER: 'assets/icon/facilities_hotel/Heater.svg',
    UITitleCode.INTERNET_WIFI: 'assets/icon/facilities_hotel/InternetWifi.svg',
    UITitleCode.PARKING: 'assets/icon/facilities_hotel/Parking.svg',
    UITitleCode.RESTAURANT: 'assets/icon/facilities_hotel/Restaurant.svg',
    UITitleCode.SMOKING_ROOM: 'assets/icon/facilities_hotel//SmokingRoom.svg',
    UITitleCode.WASHER_DRYNER: 'assets/icon/facilities_hotel/Washer_Dryer.svg',
    UITitleCode.ONLINE_RESERVATION:
        'assets/icon/facilities_hotel/booking-online.svg',
    UITitleCode.HRS_SECURITY:
        'assets/icon/facilities_hotel/customer-service.svg',
    UITitleCode.VENDING_MACHINE:
        'assets/icon/facilities_hotel/vending-machine.svg',
    UITitleCode.LAUNDRY_SERVICE: 'assets/icon/facilities_hotel/laundry.svg',
    UITitleCode.PET: 'assets/icon/facilities_hotel/pet.svg',
    UITitleCode.SWIMMING_POOL: 'assets/icon/facilities_hotel/swimming-pool.svg',
    UITitleCode.SUITE_ROOM: 'assets/icon/facilities_hotel/suiteroom.svg',
    UITitleCode.BAR: 'assets/icon/facilities_hotel/bar-counter.svg',
    UITitleCode.LUGGAGE_STORAGE:
        'assets/icon/facilities_hotel/luggagestorage.svg',
    UITitleCode.BREAKFAST: 'assets/icon/facilities_hotel/breakfast.svg',
    UITitleCode.COFFE_SHOP: 'assets/icon/facilities_hotel/coffee-shop.svg',
    UITitleCode.KEY_AND_CARD: 'assets/icon/facilities_hotel/keyandcard.svg',
    UITitleCode.SPA: 'assets/icon/facilities_hotel/spa.svg',
    UITitleCode.JACUZZI: 'assets/icon/facilities_hotel/jacuzzi.svg',
    UITitleCode.HOTEL_STAFF: 'assets/icon/facilities_hotel/staff.svg',
    UITitleCode.CAR_AND_BICYCLE_RENTAL:
        'assets/icon/facilities_hotel/car-rental.svg',
  };
  static final HomeController _instance =
      HomeController._localizationController();

  HomeController._localizationController() {
    inDate = null;
    outDate = null;
    teName = TextEditingController(text: '');
    teEmail = TextEditingController(text: '');
    tePhone = TextEditingController(text: '');
    teNotes = TextEditingController(text: '');

    addListPricture();
  }

  factory HomeController() {
    return _instance;
  }
  void rebuild() {
    notifyListeners();
  }

  void clear() {
    teAdult = NeutronInputNumberController(TextEditingController(text: "0"));
    teChild = NeutronInputNumberController(TextEditingController(text: "0"));
    teNumberRoom =
        NeutronInputNumberController(TextEditingController(text: "0"));
    notifyListeners();
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

  setNumberRoom(int numberRoom, String roomTypeId) {
    listRoom[roomTypeId] = [];
    List<String> listNumber = [];
    for (var i = 0; i <= numberRoom; i++) {
      listNumber.add(i.toString());
    }
    listRoom[roomTypeId] = listNumber;
    notifyListeners();
  }

  setNumberRateRoom(List<RateRoomTypes>? list) {
    if (list != null) {
      for (var value in list) {
        numberR[value.id!] = '0';
      }
    }

    notifyListeners();
  }

  setRoom(String number, String roomTypeID, String rateId, int totalNumberRoom,
      num priceRoom) {
    if (number == numberR[rateId]) {
      return;
    }
    List<num> listPrice = [];

    num totalRoom = 0;
    if (teNums!.isNotEmpty) {
      if (!teNums!.containsKey(roomTypeID)) {
        teNums!.addAll({
          roomTypeID: {
            rateId: NeutronInputNumberController(
                TextEditingController(text: number))
          }
        });
      }
      for (var element in teNums!.keys) {
        if (teNums![element]!.keys.contains(rateId)) {
          teNums![element]![rateId] =
              NeutronInputNumberController(TextEditingController(text: number));
        } else {
          if (element == roomTypeID) {
            teNums![element]!.addAll({
              rateId: NeutronInputNumberController(
                  TextEditingController(text: number))
            });
          }
        }
        for (var value in teNums![element]!.values) {
          if (element == roomTypeID) {
            totalRoom = totalRoom + value.getNumber()!;
          }
        }
        if (totalRoom > totalNumberRoom) {
          teNums![element]![rateId] = NeutronInputNumberController(
              TextEditingController(text: numberR[rateId]));
          return;
        }
      }
    } else {
      teNums = {
        roomTypeID: {
          rateId:
              NeutronInputNumberController(TextEditingController(text: number))
        }
      };
    }
    if (int.parse(number) == 0) {
      if (pricePerNight.containsKey(roomTypeID)) {
        if (pricePerNight[roomTypeID]!.containsKey(rateId)) {
          pricePerNight[roomTypeID]!.remove(rateId);
          if (pricePerNight[roomTypeID]!.isEmpty) {
            pricePerNight.remove(roomTypeID);
          }
        }
      }
    } else {
      for (var i = 1; i < listDate.length; i++) {
        listPrice.add(priceRoom);
      }
      if (pricePerNight.containsKey(roomTypeID)) {
        if (pricePerNight[roomTypeID]!.containsKey(rateId)) {
          pricePerNight[roomTypeID]![rateId] = listPrice;
        } else {
          pricePerNight[roomTypeID]!.addAll({rateId: listPrice});
        }
      } else {
        pricePerNight.addAll({
          roomTypeID: {rateId: listPrice}
        });
      }
    }
    print(pricePerNight);
    numberR[rateId] = number;
    notifyListeners();
  }

  setLanguage(String codeLocal) {
    languageLocacl = codeLocal;
    GeneralManager().setLocale(languageLocacl!);
    notifyListeners();
  }

  addListPricture() async {
    List<String> listImg = [];
    if (GeneralManager.hotel!.imgs!.isEmpty) {
      listImg.addAll([
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh1.jpg?alt=media&token=932859eb-ec17-434e-b933-4ef3089c9cee',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh2.jpg?alt=media&token=22459229-f0b1-4d3f-8420-a384a04aac7b',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh3.jpg?alt=media&token=a59b4053-f328-4fb1-8e27-e81b1dd8da9f',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh4.jpg?alt=media&token=a7a232f5-9c67-4278-8418-d4a6a524cc74',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b'
      ]);
      for (int i = 0; i < listImg.length; i++) {
        listPrictureHotel['$i'] = listImg[i];
      }
    } else {
      for (var key in GeneralManager.hotel!.imgs!.keys) {
        listPrictureHotel[key] = GeneralManager.hotel!.imgs![key];
      }
    }

    notifyListeners();
  }

  Future<void> addListPrictureRoom(
      String id, Map<String, dynamic> mapImg) async {
    List<String> listImg = [];
    Map<String, String> img = {};
    if (mapImg.isEmpty) {
      listImg.addAll([
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh4.jpg?alt=media&token=a7a232f5-9c67-4278-8418-d4a6a524cc74',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh2.jpg?alt=media&token=22459229-f0b1-4d3f-8420-a384a04aac7b',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh2.jpg?alt=media&token=22459229-f0b1-4d3f-8420-a384a04aac7b',
        'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh2.jpg?alt=media&token=22459229-f0b1-4d3f-8420-a384a04aac7b',
      ]);
      for (var i = 0; i < listImg.length; i++) {
        img[i.toString()] = listImg[i];
      }
    } else {
      for (var key in mapImg.keys) {
        img[key] = mapImg[key];
      }
    }
    listPrictureRoom[id] = img;
  }

  void setInDate(DateTime? inDate2) async {
    if (inDate2 == null) {
      inDate = null;
      startDay = '';
      notifyListeners();
      return;
    }
    if (inDate != null) {
      if (DateUtil.equal(inDate2, inDate!)) {
        return;
      }
    }
    inDate = DateUtil.to12h(inDate2);
    startDay = DateFormat('EEEE', 'vi').format(inDate!);

    notifyListeners();
    if (outDate != null) {
      if (outDate!.compareTo(inDate!) <= 0) {
        outDate = inDate!.add(const Duration(days: 1));
        endDay = DateFormat('EEEE', 'vi').format(outDate!);
      }
    }
  }

  void setOutDate(DateTime? outDate2) async {
    listMonthAndDay = {};
    if (outDate2 == null) {
      outDate = null;
      endDay = '';
      notifyListeners();
      return;
    }
    // if (outDate != null) {
    //   if (DateUtil.equal(outDate2, outDate!)) {
    //     return;
    //   }
    // }

    if (!outDate2.isAfter(inDate!)) {
      return;
    }
    notifyListeners();
    final outDate12h = DateUtil.to12h(outDate2);

    if (outDate12h.compareTo(inDate!) <= 0) {
      notifyListeners();
      return;
    }
    outDate = outDate12h;
    List<int> day2 = [];
    String code2 = '';
    listDate = DateUtil.getStaysDay(inDate!, outDate!);
    for (var i = 0; i < listDate.length; i++) {
      String code = DateUtil.dateToShortStringYearMonth(
          listDate[i].subtract(const Duration(days: 1)));
      if (i + 1 < listDate.length) {
        code2 = DateUtil.dateToShortStringYearMonth(
            listDate[i + 1].subtract(const Duration(days: 1)));
      }
      if (i - 1 < 0) {
        day2.add(listDate[0].day);
      } else {
        if (!day2.contains(listDate[i - 1].day)) {
          day2.add(listDate[i - 1].day);
          if (i == listDate.length - 1) {
            day2.add(listDate[i].day);
          }
        } else {
          if (listDate.length > 1) {
            day2.add(listDate[i].day);
          }
        }
      }
      if (code != code2) {
        String startMonth = DateUtil.dateToShortStringYearMonth(
            listDate[i].subtract(const Duration(days: 1)));
        listMonthAndDay[startMonth] = day2;
        day2 = [];
      } else {
        listMonthAndDay[code] = day2;
      }
    }
    print(listMonthAndDay);
    endDay = DateFormat('EEEE', 'vi').format(outDate!);
    notifyListeners();
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

  String getNameRoomTypeById(String id) {
    return GeneralManager.listRoomTypes
            .firstWhere((element) => element.id == id)
            .name ??
        "";
  }

  void addInformation(String code) {
    switch (code) {
      case UITitleCode.SIDEBAR_ROOM:
        num numberRoom = teNumberRoom!.getNumber()! + 1;
        if (teAdult!.getNumber()! <= teNumberRoom!.getNumber()!) {
          num numberRoom = teAdult!.getNumber()! + 1;
          teAdult = NeutronInputNumberController(
              TextEditingController(text: numberRoom.toString()));
        }
        teNumberRoom = NeutronInputNumberController(
            TextEditingController(text: numberRoom.toString()));
        break;
      case UITitleCode.TABLEHEADER_ADULT:
        num numberRoom = teAdult!.getNumber()! + 1;
        teAdult = NeutronInputNumberController(
            TextEditingController(text: numberRoom.toString()));
        break;
      case UITitleCode.TABLEHEADER_CHILD:
        num numberRoom = teChild!.getNumber()! + 1;
        teChild = NeutronInputNumberController(
            TextEditingController(text: numberRoom.toString()));
        break;
      default:
    }
    notifyListeners();
  }

  void removeInformation(String code) {
    switch (code) {
      case UITitleCode.SIDEBAR_ROOM:
        if (teNumberRoom!.getNumber()! <= 0) {
          return;
        }
        num numberRoom = teNumberRoom!.getNumber()! - 1;
        teNumberRoom = NeutronInputNumberController(
            TextEditingController(text: numberRoom.toString()));
        break;
      case UITitleCode.TABLEHEADER_ADULT:
        if (teAdult!.getNumber()! <= 0) {
          return;
        }
        if (teAdult!.getNumber()! <= teNumberRoom!.getNumber()!) {
          return;
        }
        num numberRoom = teAdult!.getNumber()! - 1;
        teAdult = NeutronInputNumberController(
            TextEditingController(text: numberRoom.toString()));
        break;
      case UITitleCode.TABLEHEADER_CHILD:
        if (teChild!.getNumber()! <= 0) {
          return;
        }
        num numberRoom = teChild!.getNumber()! - 1;
        teChild = NeutronInputNumberController(
            TextEditingController(text: numberRoom.toString()));
        break;
      default:
    }
    notifyListeners();
  }

  Future<String> search() async {
    // listRoomTypes.clear();
    if (listMonthAndDay.isEmpty) {
      return 'Vui lòng chọn ngày';
    }
    if (teAdult!.getNumber() == 0) {
      return 'Vui lòng nhập số lượng người ở';
    }
    if (teNumberRoom!.getNumber() == 0) {
      return 'Vui lòng nhập số phòng';
    }
    isLoading = true;
    notifyListeners();
    listRoomTypes = GeneralManager.listRoomTypes;
    for (var i = 0; i < listRoomTypes.length; i++) {
      await addListPrictureRoom(
          listRoomTypes[i].id!, listRoomTypes[i].imgs ?? {});
    }

    String result = await FirebaseFunctions.instance
        .httpsCallable('bookingengine-getnumberroom')
        .call({
      'hotel_id': GeneralManager.idHotel,
      'listmonthanđay': listMonthAndDay
    }).then((doc) {
      listNumberRoom = (doc.data as Map<String, dynamic>);
      return MessageCodeUtil.SUCCESS;
    }).onError((error, stackTrace) {
      return (error as FirebaseFunctionsException).message.toString();
    });
    isLoading = false;
    notifyListeners();
    return result;
  }

  Future<String> addBooking() async {
    int day = outDate!.day - inDate!.day;
    String? name = '';
    num totalRoom = 0;
    // for (var key in teNums.keys) {
    //   totalRoom += int.parse(teNums[key]!.getRawString());
    //   if (name != '') {
    //     name = '$name, ${GeneralManager().getRoomTypeNameByID(key)}';
    //   } else {
    //     name = '${GeneralManager().getRoomTypeNameByID(key)}';
    //   }
    // }
    data['indate'] = inDate;
    data['outdate'] = outDate;
    data['day'] = day;
    data['adult'] = teAdult!.getRawString();
    data['child'] = teChild!.getRawString();
    data['name'] = teName!.text;
    data['phone'] = tePhone!.text;
    data['email'] = teEmail!.text;
    data['roomtype'] = name;
    data['totalroom'] = totalRoom;
    data['note'] = teNotes!.text;
    data['totalprice'] = total;
    return MessageCodeUtil.SUCCESS;
  }

  void scrollToUiRoom() {
    if (scrollController.hasClients) {
      final RenderBox renderBox =
          globalKey.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero).dy -
          AppBar().preferredSize.height;
      print(position);
      scrollController.animateTo(
        1878.72,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
