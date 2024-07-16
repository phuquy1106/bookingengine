import 'package:bookingengine_frontend/gen/assets.gen.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FacilitiesController extends ChangeNotifier {
  Map<String, SvgPicture> listHotelFacilities = {};
  List<dynamic> listFacilities = [];
  bool isLoading = false;
  Map<String, SvgPicture> hotelFacilities = {
    UITitleCode.AIR_CONDITIONING: SvgPicture.asset(
      Assets.icon.facilitiesHotel.airCon,
      height: 36,
    ),
    UITitleCode.AIRPORT_TRANSPORT: SvgPicture.asset(
      'assets/icon/facilities_hotel/AirportTransport.svg',
      height: 36,
    ),
    UITitleCode.FITNESS_CENTER: SvgPicture.asset(
      'assets/icon/facilities_hotel/FitnessCenter.svg',
      height: 36,
    ),
    UITitleCode.HEATER: SvgPicture.asset(
      'assets/icon/facilities_hotel/Heater.svg',
      height: 36,
    ),
    UITitleCode.INTERNET_WIFI: SvgPicture.asset(
      'assets/icon/facilities_hotel/InternetWifi.svg',
      height: 36,
    ),
    UITitleCode.PARKING: SvgPicture.asset(
      'assets/icon/facilities_hotel/Parking.svg',
      height: 36,
    ),
    UITitleCode.RESTAURANT: SvgPicture.asset(
      'assets/icon/facilities_hotel/Restaurant.svg',
      height: 36,
    ),
    UITitleCode.SMOKING_ROOM: SvgPicture.asset(
      'assets/icon/facilities_hotel//SmokingRoom.svg',
      height: 36,
    ),
    UITitleCode.WASHER_DRYNER: SvgPicture.asset(
      'assets/icon/facilities_hotel/Washer_Dryer.svg',
      height: 36,
    ),
    UITitleCode.ONLINE_RESERVATION: SvgPicture.asset(
      'assets/icon/facilities_hotel/booking-online.svg',
      height: 36,
    ),
    UITitleCode.HRS_SECURITY: SvgPicture.asset(
      'assets/icon/facilities_hotel/customer-service.svg',
      height: 36,
    ),
    UITitleCode.VENDING_MACHINE: SvgPicture.asset(
      'assets/icon/facilities_hotel/vending-machine.svg',
      height: 36,
    ),
    UITitleCode.LAUNDRY_SERVICE: SvgPicture.asset(
      'assets/icon/facilities_hotel/laundry.svg',
      height: 36,
    ),
    UITitleCode.PET: SvgPicture.asset(
      'assets/icon/facilities_hotel/pet.svg',
      height: 36,
    ),
    UITitleCode.SWIMMING_POOL: SvgPicture.asset(
      'assets/icon/facilities_hotel/swimming-pool.svg',
      height: 36,
    ),
    UITitleCode.SUITE_ROOM: SvgPicture.asset(
      'assets/icon/facilities_hotel/suiteroom.svg',
      height: 36,
    ),
    UITitleCode.BAR: SvgPicture.asset(
      'assets/icon/facilities_hotel/bar-counter.svg',
      height: 36,
    ),
    UITitleCode.LUGGAGE_STORAGE: SvgPicture.asset(
      'assets/icon/facilities_hotel/luggagestorage.svg',
      height: 36,
    ),
    UITitleCode.BREAKFAST: SvgPicture.asset(
      'assets/icon/facilities_hotel/breakfast.svg',
      height: 36,
    ),
    UITitleCode.COFFE_SHOP: SvgPicture.asset(
      'assets/icon/facilities_hotel/coffee-shop.svg',
      height: 36,
    ),
    UITitleCode.KEY_AND_CARD: SvgPicture.asset(
      'assets/icon/facilities_hotel/keyandcard.svg',
      height: 36,
    ),
    UITitleCode.SPA: SvgPicture.asset(
      'assets/icon/facilities_hotel/spa.svg',
      height: 36,
    ),
    UITitleCode.JACUZZI: SvgPicture.asset(
      'assets/icon/facilities_hotel/jacuzzi.svg',
      height: 36,
    ),
    UITitleCode.HOTEL_STAFF: SvgPicture.asset(
      'assets/icon/facilities_hotel/staff.svg',
      height: 36,
    ),
    UITitleCode.CAR_AND_BICYCLE_RENTAL: SvgPicture.asset(
      'assets/icon/facilities_hotel/car-rental.svg',
      height: 36,
    ),
  };
  FacilitiesController() {
    listFacilities = (GeneralManager.hotel!.hotelFacilities!);
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

  Future<String> updateFacilities() async {
    isLoading = true;
    notifyListeners();
    String result = await FirebaseFunctions.instance
        .httpsCallable('bookingengine-updateFacilites')
        .call({
          'hotel_id': GeneralManager.hotel!.id,
          'listfacilites': listFacilities,
        })
        .then((value) => value.data)
        .onError((error, stackTrace) => error.toString());
    if (result == MessageCodeUtil.SUCCESS) {
      GeneralManager.hotel!.hotelFacilities = listFacilities;
      GeneralManager().notifyListeners();
    }
    isLoading = false;
    notifyListeners();
    return result;
  }
}
