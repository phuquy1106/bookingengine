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
    'static': FontFamily.static,
    'timesnewroman': FontFamily.timesNewRoman,
    'orev': FontFamily.orev,
    'chivo': FontFamily.chivo,
    'mont': FontFamily.mont,
    'mijas': FontFamily.mijas,
    'nabila': FontFamily.nabila,
    'pony': FontFamily.pony,
    'merri': FontFamily.merri,
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
      print(GeneralManager.hotel!.colors?['background']['main'] == []);
      print('--------------');
    }).onError((error, stackTrace) {});
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
