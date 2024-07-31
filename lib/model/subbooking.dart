class Subbooking {
  String? id;
  String? roomTpye;
  String? room;
  num? status;
  List<dynamic>? price;

  Subbooking({this.id, this.roomTpye, this.price, this.room, this.status});

  factory Subbooking.snapshot({String? id, Map<String, dynamic>? data}) {
    return Subbooking(
        id: id,
        roomTpye: data!['room_type'] ?? '',
        room: data['room'] ?? '',
        status: data['status'] ?? 0,
        price: (data['price']) ?? []);
  }
}
