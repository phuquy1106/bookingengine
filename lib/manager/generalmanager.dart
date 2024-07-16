import 'package:bookingengine_frontend/gen/assets.gen.dart';
import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/handler/firebasehandler.dart';
import 'package:bookingengine_frontend/model/hotel.dart';
import 'package:bookingengine_frontend/model/policy.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneralManager extends ChangeNotifier {
  static final GeneralManager _instance = GeneralManager._singleton();
  GeneralManager._singleton();
  static Locale? locale;
  static int maxLengthStay = 31;
  static int maxLengthStayOta = 365;
  static double cellHeight = 40;
  static double bookingCellHeight = cellHeight - 6;
  static double bedCellWidth = 15;
  static HotelModel? hotel;
  static String linkBookingEngine = "";
  static String idHotel = '';
  static bool check = true;
  static List<dynamic>? listIdHotel;
  static List<Policy> listNewPolicy = [];
  static List<RoomType> listRoomTypes = [];
  static String fontText = listFontText[GeneralManager.hotel!.font]!;
  static Map<String, String> listFontText = {
    'aria': FontFamily.aria,
    'inter': FontFamily.inter,
    'overbole': FontFamily.orevBold,
    'static': FontFamily.static,
    'timesnewroman': FontFamily.timesNewRoman
  };
  static Map<String, String> listFacilitiesRoom = {
    UITitleCode.BATHTUB: Assets.icon.facilitiesRoomtype.bathtub,
    UITitleCode.COFFE_CUP: Assets.icon.facilitiesRoomtype.coffeeCup,
    UITitleCode.COMPUTER: Assets.icon.facilitiesRoomtype.computer,
    UITitleCode.FRIDGE: Assets.icon.facilitiesRoomtype.fridge,
    UITitleCode.HAIRDGE: Assets.icon.facilitiesRoomtype.hairdryer,
    UITitleCode.HOT_WATER: Assets.icon.facilitiesRoomtype.hotWater,
    UITitleCode.IRON: Assets.icon.facilitiesRoomtype.iron,
    UITitleCode.LED_TV: Assets.icon.facilitiesRoomtype.ledTv,
    UITitleCode.SHAMPOO: Assets.icon.facilitiesRoomtype.shampoo,
    UITitleCode.SHOWERGEL: Assets.icon.facilitiesRoomtype.showergel,
    UITitleCode.TOWEL: Assets.icon.facilitiesRoomtype.towel,
    UITitleCode.CURTAIN: Assets.icon.facilitiesRoomtype.curtain,
    UITitleCode.DESK: Assets.icon.facilitiesRoomtype.desk,
    UITitleCode.LANDINE: Assets.icon.facilitiesRoomtype.landline,
    UITitleCode.MIRROR: Assets.icon.facilitiesRoomtype.mirror,
    UITitleCode.RUG: Assets.icon.facilitiesRoomtype.rug,
    UITitleCode.SANDAL: Assets.icon.facilitiesRoomtype.sandal,
    UITitleCode.SOUNDPROOF: Assets.icon.facilitiesRoomtype.soundproof,
    UITitleCode.WARDROBE: Assets.icon.facilitiesRoomtype.wardrobe,
  };

  factory GeneralManager() {
    return _instance;
  }
  void rebuild() {
    notifyListeners();
  }

  void setLocale(String localeCode) async {
    if (localeCode == locale?.toLanguageTag()) return;
    final SharedPreferences shareRef = await SharedPreferences.getInstance();
    shareRef.setString('language', localeCode);
    locale = Locale(localeCode);
    notifyListeners();
  }

  static Future<void> getHotelUser(String uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((doc) {
      listIdHotel = doc.get('hotels') ?? [];
    });
  }

  static Future<void> getPolicy() async {
    listNewPolicy.clear();
    await FirebaseHandler.hotelRef
        .collection('management')
        .doc('policy')
        .get()
        .then((doc) {
      Map<String, dynamic> dataPolicy = (doc.data() as Map<String, dynamic>);
      for (var key in dataPolicy.keys) {
        listNewPolicy.add(Policy.fromSnapshot(dataPolicy[key], key));
      }
    });
  }

  static Future<void> getPolicy2() async {
    listNewPolicy.clear();
    await FirebaseFunctions.instance
        .httpsCallable('bookingengine-getPolicy')
        .call({'hotel_id': GeneralManager.idHotel}).then((doc) {
      Map<String, dynamic> dataPolicy = (doc.data as Map<String, dynamic>);
      for (var key in dataPolicy.keys) {
        listNewPolicy.add(Policy.fromSnapshot(dataPolicy[key], key));
      }
    });
  }

  static Future<List<RoomType>> getRoomTypes() async {
    listNewPolicy.clear();
    await FirebaseFunctions.instance
        .httpsCallable('bookingengine-getRoomtypes')
        .call({'hotel_id': GeneralManager.idHotel}).then((doc) {
      Map<String, dynamic> dataRoomtypes = (doc.data as Map<String, dynamic>);
      for (var key in dataRoomtypes.keys) {
        listRoomTypes
            .add(RoomType.fromSnapShot(snapshot: dataRoomtypes[key], key: key));
      }
    });
    return listRoomTypes;
  }

  static Future<void> getUsersOfHotel() async {
    await FirebaseFunctions.instance
        .httpsCallable('bookingengine-getHotel')
        .call({'hotel_id': GeneralManager.idHotel}).then((value) {
      print(value);
      Map<String, dynamic> data = value.data as Map<String, dynamic>;
      hotel = HotelModel.fromSnapshot(data, GeneralManager.idHotel);
    }).onError((error, stackTrace) {});
  }

  static addRoomType() {
    listRoomTypes.add(RoomType(
        id: '001',
        adult: 3,
        child: 2,
        beds: ['S'],
        describeRoom:
            '<blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: rgb(0, 0, 0);"><font size="5">StudioAllston Hotel is the ideal point of departure for your excursions in Boston(MA). Conveniently located on the Charles River near Harvard University, theproperty offers spacious accommodation, contemporary technology and amplefacilities for an excellent visit to historic Boston.</font></span></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: #000000 "><font size="5">Topfeatures of the property include complimentary parking on-site, full servicerestaurant serving breakfast, lunch and dinner and free wireless internetaccess. Enjoy nearby jogging and bicycle paths, while children will like theplay area across the street.</font></span></p><p class="MsoNormal" style="text-align: justify;"><font style=""><span style="color: rgb(0, 0, 0);"><font style="" size="5">&nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</font></span></font></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><font style=""><font style="" size="5"><span style="color: #000000 ">nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</span></font></font></p></blockquote><p class="MsoNormal" style="margin-bottom:0cm"></p>',
        facilitesRoom: [
          'airport-transport',
          'air-conditioning',
          'fitness-center'
        ],
        imgs: [
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b'
        ],
        name: 'N001',
        price: 200000,
        numberRoom: 3));
    listRoomTypes.add(RoomType(
        id: '002',
        adult: 3,
        child: 2,
        beds: ['S'],
        describeRoom:
            '<blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: rgb(0, 0, 0);"><font size="5">StudioAllston Hotel is the ideal point of departure for your excursions in Boston(MA). Conveniently located on the Charles River near Harvard University, theproperty offers spacious accommodation, contemporary technology and amplefacilities for an excellent visit to historic Boston.</font></span></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: #000000 "><font size="5">Topfeatures of the property include complimentary parking on-site, full servicerestaurant serving breakfast, lunch and dinner and free wireless internetaccess. Enjoy nearby jogging and bicycle paths, while children will like theplay area across the street.</font></span></p><p class="MsoNormal" style="text-align: justify;"><font style=""><span style="color: rgb(0, 0, 0);"><font style="" size="5">&nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</font></span></font></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><font style=""><font style="" size="5"><span style="color: #000000 ">nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</span></font></font></p></blockquote><p class="MsoNormal" style="margin-bottom:0cm"></p>',
        facilitesRoom: [
          'airport-transport',
          'air-conditioning',
          'fitness-center'
        ],
        imgs: [
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b'
        ],
        name: 'N002',
        price: 300000,
        numberRoom: 4));
    listRoomTypes.add(RoomType(
        id: '003',
        adult: 3,
        child: 2,
        beds: ['S'],
        describeRoom:
            '<blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: rgb(0, 0, 0);"><font size="5">StudioAllston Hotel is the ideal point of departure for your excursions in Boston(MA). Conveniently located on the Charles River near Harvard University, theproperty offers spacious accommodation, contemporary technology and amplefacilities for an excellent visit to historic Boston.</font></span></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: #000000 "><font size="5">Topfeatures of the property include complimentary parking on-site, full servicerestaurant serving breakfast, lunch and dinner and free wireless internetaccess. Enjoy nearby jogging and bicycle paths, while children will like theplay area across the street.</font></span></p><p class="MsoNormal" style="text-align: justify;"><font style=""><span style="color: rgb(0, 0, 0);"><font style="" size="5">&nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</font></span></font></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><font style=""><font style="" size="5"><span style="color: #000000 ">nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</span></font></font></p></blockquote><p class="MsoNormal" style="margin-bottom:0cm"></p>',
        facilitesRoom: [
          'airport-transport',
          'air-conditioning',
          'fitness-center'
        ],
        imgs: [
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b'
        ],
        name: 'N003',
        price: 400000,
        numberRoom: 2));
    listRoomTypes.add(RoomType(
        id: '004',
        adult: 3,
        child: 2,
        beds: ['S'],
        describeRoom:
            '<blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: rgb(0, 0, 0);"><font size="5">StudioAllston Hotel is the ideal point of departure for your excursions in Boston(MA). Conveniently located on the Charles River near Harvard University, theproperty offers spacious accommodation, contemporary technology and amplefacilities for an excellent visit to historic Boston.</font></span></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: #000000 "><font size="5">Topfeatures of the property include complimentary parking on-site, full servicerestaurant serving breakfast, lunch and dinner and free wireless internetaccess. Enjoy nearby jogging and bicycle paths, while children will like theplay area across the street.</font></span></p><p class="MsoNormal" style="text-align: justify;"><font style=""><span style="color: rgb(0, 0, 0);"><font style="" size="5">&nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</font></span></font></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><font style=""><font style="" size="5"><span style="color: #000000 ">nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</span></font></font></p></blockquote><p class="MsoNormal" style="margin-bottom:0cm"></p>',
        facilitesRoom: [
          'airport-transport',
          'air-conditioning',
          'fitness-center'
        ],
        imgs: [
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b'
        ],
        name: 'N004',
        price: 700000,
        numberRoom: 8));
    listRoomTypes.add(RoomType(
        id: '005',
        adult: 3,
        child: 2,
        beds: ['S'],
        describeRoom:
            '<blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: rgb(0, 0, 0);"><font size="5">StudioAllston Hotel is the ideal point of departure for your excursions in Boston(MA). Conveniently located on the Charles River near Harvard University, theproperty offers spacious accommodation, contemporary technology and amplefacilities for an excellent visit to historic Boston.</font></span></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: #000000 "><font size="5">Topfeatures of the property include complimentary parking on-site, full servicerestaurant serving breakfast, lunch and dinner and free wireless internetaccess. Enjoy nearby jogging and bicycle paths, while children will like theplay area across the street.</font></span></p><p class="MsoNormal" style="text-align: justify;"><font style=""><span style="color: rgb(0, 0, 0);"><font style="" size="5">&nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</font></span></font></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><font style=""><font style="" size="5"><span style="color: #000000 ">nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</span></font></font></p></blockquote><p class="MsoNormal" style="margin-bottom:0cm"></p>',
        facilitesRoom: [
          'airport-transport',
          'air-conditioning',
          'fitness-center'
        ],
        imgs: [
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b'
        ],
        name: 'N005',
        price: 500000,
        numberRoom: 5));
  }

  Future<void> loadLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final String localeCode = prefs.getString('language') ?? 'en';
    cellHeight = prefs.getDouble('cellHeight') ?? 40;
    locale = Locale(localeCode);
  }

  static Future<void> getHotel() async {
    return await FirebaseHandler.hotelRef.get().then((doc) async {
      Map<String, dynamic> data = doc as Map<String, dynamic>;
      hotel = HotelModel.fromSnapshot(data, GeneralManager.idHotel);
    });
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void unfocus(BuildContext context) {
    FocusScope.of(context).focusedChild?.unfocus();
  }

  String getNamePolicyById(String id) {
    return listNewPolicy
            .firstWhere(
              (element) => element.id == id,
            )
            .title ??
        "";
  }

  getRoomTypeNameByID(String id) {
    return listRoomTypes
            .firstWhere(
              (element) => element.id == id,
            )
            .name ??
        "";
  }
}
