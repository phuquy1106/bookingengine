import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHandler {
  static final FirebaseHandler _instance = FirebaseHandler._internal();
  factory FirebaseHandler() {
    return _instance;
  }
  FirebaseHandler._internal();

  static DocumentReference hotelRef = FirebaseFirestore.instance
      .collection('hotels')
      .doc(GeneralManager.idHotel);
}
