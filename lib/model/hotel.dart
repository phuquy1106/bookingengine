import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';

class HotelModel {
  String? id;
  String? nameHotel;
  String? phone;
  String? email;
  String? font;
  Map<String, dynamic>? colors;
  List<RoomType>? roomType;
  List<dynamic>? hotelFacilities;
  String? layoutHotel;
  String? layoutRoom;
  Map<String, dynamic>? imgs;
  String? describe;
  HotelModel(
      {this.id,
      this.nameHotel,
      this.phone,
      this.layoutHotel,
      this.layoutRoom,
      this.describe,
      this.hotelFacilities,
      this.roomType,
      this.email,
      this.imgs,
      this.colors,
      this.font});
  // factory HotelModel.fromSnapshot(DocumentSnapshot doc) {
  //   final data = doc.data() as Map<String, dynamic>;
  //   List<RoomType> listNewRoomType = [];
  //   if (data.containsKey('room_types')) {
  //     Map<String, dynamic> dataRoomType =
  //         (doc.get('room_types') as Map<String, dynamic>);
  //     for (var key in dataRoomType.keys) {
  //       listNewRoomType
  //           .add(RoomType.fromSnapShot2(id: key, snapshot: dataRoomType[key]));
  //     }
  //   }
  //   return HotelModel(
  //     id: doc.id,
  //     nameHotel: data.containsKey('name') ? doc.get('name') : '',
  //     email: data.containsKey('email') ? doc.get('email') : '',
  //     phone: data.containsKey('phone') ? doc.get('phone') : '',
  //     describe: data.containsKey('describe') ? doc.get('describe') : '',
  //     imgs: data.containsKey('imghotel') ? doc.get('imghotel') : [],
  //     hotelFacilities: data.containsKey('hotelfacilities')
  //         ? doc.get('hotelfacilities')
  //         : [
  //             UITitleCode.AIR_CONDITIONING,
  //             UITitleCode.AIRPORT_TRANSPORT,
  //             UITitleCode.FITNESS_CENTER,
  //             UITitleCode.HEATER,
  //             UITitleCode.INTERNET_WIFI,
  //             UITitleCode.PARKING,
  //             UITitleCode.RESTAURANT,
  //             UITitleCode.SMOKING_ROOM,
  //             UITitleCode.WASHER_DRYNER
  //           ],
  //     colors: data.containsKey('colors') ? doc.get('colors') : {},
  //     roomType: listNewRoomType,
  //     font: data.containsKey('font') ? doc.get('font') : 'static',
  //     layoutHotel:
  //         data.containsKey('layouthotel') ? doc.get('layouthotel') : 'layout01',
  //     layoutRoom:
  //         data.containsKey('layoutroom') ? doc.get('layoutroom') : 'layout01',
  //   );
  // }
  factory HotelModel.fromSnapshot(Map<String, dynamic> doc, String id) {
    // List<RoomType> listNewRoomType = [];
    return HotelModel(
      id: id,
      nameHotel: doc['name'] ?? '',
      email: doc['email'] ?? '',
      phone: doc['phone'] ?? '',
      describe: doc['describe'] ?? '',
      imgs: doc['imghotel'] ?? {},
      hotelFacilities: doc['hotelfacilities'] ??
          [
            UITitleCode.AIR_CONDITIONING,
            UITitleCode.AIRPORT_TRANSPORT,
            UITitleCode.FITNESS_CENTER,
            UITitleCode.HEATER,
            UITitleCode.INTERNET_WIFI,
            UITitleCode.PARKING,
            UITitleCode.RESTAURANT,
            UITitleCode.SMOKING_ROOM,
            UITitleCode.WASHER_DRYNER
          ],
      colors: doc['colors'] ?? {},
      // roomType: listNewRoomType,
      font: doc['font_text'] ?? 'static',
      layoutHotel: doc['layouthotel'] ?? 'layout01',
      layoutRoom: doc['layoutroom'] ?? 'layout01',
    );
  }
}
