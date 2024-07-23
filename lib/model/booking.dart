import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/dateutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Booking {
  String? id;
  String? name;
  String? email;
  String? phone;
  DateTime? inDate;
  DateTime? outDate;
  DateTime? inTime;
  DateTime? outTime;
  DateTime? cancelled;
  Map<String, dynamic>? subBookings;
  int? status;
  int? bookingType;
  String? roomTypeID;
  String? room;
  List<num>? price;
  int? lengthStay;
  int? lengthRender;
  String? bed;
  bool? breakfast = false;
  bool? lunch = false;
  bool? dinner = false;
  bool? payAtHotel = true;
  int? extraBed;
  Timestamp? created;
  List<dynamic>? staydays;
  bool? group;
  String? ratePlanID;
  num? adult;
  num? child;
  num? numberRoom;
  String? sourceID;
  String? sID;
  num? discount = 0;
  bool? isBasic;
  bool? isEmpty = false;
  bool? isVirtual = false;
  bool? isTaxDeclare = false;
  bool? hasDeclaration = false;
  bool? statusinvoice = false;
  bool? isPriceFirstMonthly = false;
  List<dynamic>? declareGuests = [];
  Map<String, dynamic>? declareInfo = {};
  Map<String, dynamic>? pricePerNight = {};
  Map<String, dynamic>? paymentDetails = {};
  Map<String, dynamic>? costDetails = {};
  Map<String, dynamic>? discountDetails = {};
  Map<String, dynamic>? depositDetails = {};
  Map<String, dynamic>? electricityDetails = {};
  Map<String, dynamic>? waterDetails = {};
  Map<String, Map<String, num>>? teNums = {};
  num? totalDepositPayment;
  num? totalRoomCharge;
  num? deposit;
  num? minibar;
  num? insideRestaurant;
  num? outsideRestaurant;
  num? extraGuest;
  late num laundry;
  num? bikeRental;
  num? other;
  num? transferring;
  num? transferred;
  num? otaDeposit;
  num? electricity;
  num? water;
  String? country;
  String? typeTourists;
  String? notes;
  num? rentingBikes;
  num? totalCost;
  int? statusPayment;
  String? creator;
  String? saler;
  String? externalSaler;

  // String? get sourceName => SourceManager().getSourceNameByID(sourceID!);

  Booking({
    this.id,
    this.ratePlanID,
    this.staydays,
    this.name,
    this.email,
    this.phone,
    this.inDate,
    this.outDate,
    this.inTime,
    this.outTime,
    this.numberRoom,
    this.cancelled,
    this.teNums,
    this.status,
    this.bookingType,
    this.roomTypeID,
    this.room,
    this.rentingBikes,
    this.price,
    this.transferring = 0,
    this.transferred = 0,
    this.bed,
    this.breakfast = false,
    this.lunch = false,
    this.dinner = false,
    this.payAtHotel = true,
    this.adult = 0,
    this.child = 0,
    this.sourceID,
    this.sID,
    this.totalRoomCharge = 0,
    this.discount = 0,
    this.extraBed,
    this.created,
    this.deposit = 0,
    this.minibar = 0,
    this.electricity = 0,
    this.water = 0,
    this.insideRestaurant = 0,
    this.outsideRestaurant = 0,
    this.extraGuest = 0,
    this.laundry = 0,
    this.bikeRental = 0,
    this.other = 0,
    this.totalDepositPayment = 0,
    this.group = false,
    this.isBasic = false,
    this.isVirtual = false,
    this.isTaxDeclare = false,
    this.hasDeclaration = false,
    this.statusinvoice = false,
    this.isPriceFirstMonthly = false,
    this.declareGuests,
    this.declareInfo,
    this.paymentDetails,
    this.depositDetails,
    this.costDetails,
    this.discountDetails,
    this.electricityDetails,
    this.waterDetails,
    this.pricePerNight,
    this.otaDeposit,
    this.notes,
    this.subBookings,
    this.country,
    this.typeTourists,
    this.totalCost,
    this.statusPayment,
    this.creator,
    this.saler,
    this.externalSaler,
  }) {
    lengthStay = outDate!.difference(inDate!).inDays;
    lengthRender = lengthStay;
  }

  Future<String> add() async {
    if (lengthStay! > GeneralManager.maxLengthStay) {
      return MessageCodeUtil.OVER_MAX_LENGTHDAY_31;
    }

    if (outDate!.compareTo(inDate!) <= 0) {
      return MessageCodeUtil.OUTDATE_MUST_LARGER_THAN_INDATE;
    }
    final now = Timestamp.now();
    final now12h = DateUtil.to12h(now.toDate());
    final yesterday = now12h.subtract(const Duration(days: 1));
    if (inDate!.compareTo(yesterday) < 0 ||
        (inDate!.compareTo(yesterday) == 0 &&
            now.toDate().compareTo(now12h) >= 0)) {
      return MessageCodeUtil.INDATE_MUST_NOT_IN_PAST;
    }
    final bookingAdd = {
      'hotel_id': GeneralManager.idHotel,
      'rate_plan_id': ratePlanID,
      'name': name,
      'bed': bed,
      'in_date': inDate.toString(),
      'out_date': outDate.toString(),
      'in_time': inTime.toString(),
      'out_time': outTime.toString(),
      'room_id': room,
      'room_type_id': roomTypeID,
      'list_room_type': {roomTypeID: numberRoom},
      'source': sourceID,
      'sid': sID,
      'teNums': teNums,
      'phone': phone,
      'email': email,
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
      'pay_at_hotel': payAtHotel,
      'adult': adult,
      'child': child,
      'status': status,
      'group': group,
      'price': price,
      'price_per_night': pricePerNight,
      'tax_declare': isTaxDeclare,
      'list_guest_declaration': declareGuests,
      'declaration_invoice_detail': declareInfo,
      'type_tourists': typeTourists,
      'country': country,
      'notes': notes,
      'saler': saler,
      'external_saler': externalSaler,
      'booking_type': bookingType,
      "isfristmonthly": isPriceFirstMonthly
    };
    try {
      String res = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-addBookingBookingEngine')
          .call(bookingAdd)
          .then((value) {
        String result = value.data as String;
        return result;
      });
      return res;
    } on FirebaseFunctionsException catch (error) {
      return error.message!;
    }
  }
}
