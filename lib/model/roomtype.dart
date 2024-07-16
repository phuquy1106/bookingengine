import 'package:bookingengine_frontend/model/rateroomtypes.dart';

class RoomType {
  final String? name;
  String? describeRoom;
  final int? adult;
  final int? child;
  final List<dynamic>? beds;
  final num? price;
  final List<dynamic>? imgs;
  final List<dynamic>? facilitesRoom;
  String? id;
  final int? numberRoom;
  final bool? isDelete;
  final List<RateRoomTypes>? listRateRoomTypes;
  RoomType(
      {this.adult = 0,
      this.child = 0,
      this.imgs,
      this.facilitesRoom,
      this.describeRoom = '',
      this.beds = const [],
      this.name = '',
      this.price = 0,
      this.id,
      this.isDelete = false,
      this.numberRoom,
      this.listRateRoomTypes});

  factory RoomType.fromSnapShot({dynamic snapshot, String? key}) {
    List<RateRoomTypes> listNewRateRoomType = [];
    if (snapshot['rate_romtype'] != null) {
      Map<String, dynamic> dataRoomType =
          (snapshot['rate_romtype'] as Map<String, dynamic>);
      for (var key in dataRoomType.keys) {
        listNewRateRoomType
            .add(RateRoomTypes.fromSnapShot(key: key, doc: dataRoomType[key]));
      }
    }
    return RoomType(
        id: key,
        name: snapshot['name'] ?? '',
        describeRoom: snapshot['describeroom'] ??
            '<blockquote style="margin: 0 0 0 40px; border: none; padding: 0px;"><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: rgb(0, 0, 0);"><font size="6">StudioAllston Hotel is the ideal point of departure for your excursions in Boston(MA). Conveniently located on the Charles River near Harvard University, theproperty offers spacious accommodation, contemporary technology and amplefacilities for an excellent visit to historic Boston.</font></span></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><span style="color: #000000 "><font size="6">Topfeatures of the property include complimentary parking on-site, full servicerestaurant serving breakfast, lunch and dinner and free wireless internetaccess. Enjoy nearby jogging and bicycle paths, while children will like theplay area across the street.</font></span></p><p class="MsoNormal" style="text-align: justify;"><font style=""><span style="color: rgb(0, 0, 0);"><font style=""><font size="6">&nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</font></font></span></font></p><p class="MsoNormal" style="text-align: justify; margin-bottom: 0cm;"><font style=""><font style=""><span style="color: #000000 "><font size="6">nbsp;All rooms exude an atmosphereof total peace and harmony that feature thoughtful amenities to ensure anunparalleled sense of comfort for the guests such as air conditioning, heating,satellite/cable channels, ironing facilities and toiletries. Studio AllstonHotel is an ideal place of stay for travelers seeking charm, comfort andconvenience in Boston (MA).</font></span></font></font></p></blockquote><p class="MsoNormal" style="margin-bottom:0cm"></p>',
        price: snapshot['price'] ?? 0,
        adult: snapshot['guest'] ?? 0,
        imgs: snapshot['imgroom'] ?? [],
        facilitesRoom: snapshot['facilitiesroom'] ??
            [
              'bathtub',
              'coffe-cup',
              'computer',
              'fridge',
              'hairdge',
              'hot-water',
              'iron',
              'led-tv',
            ],
        child: snapshot['child'] ?? 0,
        beds: snapshot['beds'] ?? [],
        isDelete: snapshot['is_delete'] ?? false,
        numberRoom: snapshot['num'] ?? 0,
        listRateRoomTypes: listNewRateRoomType);
  }
  String getFirstBed() {
    try {
      if (beds!.contains('?')) {
        return '?';
      }
      return beds!.first.toString();
    } catch (e) {
      return '?';
    }
  }
}
