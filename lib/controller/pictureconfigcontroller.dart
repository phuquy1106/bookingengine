import 'dart:typed_data';

import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PictureConfigController extends ChangeNotifier {
  Map<String, String> listPicture = {};
  Map<String, Uint8List> base64 = {};
  Map<String, bool> isElevated = {};
  Uint8List? baseImg;
  int number = 0;
  Map<String, String> listDowloadURL = {};
  List<String> listImg = [
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh1.jpg?alt=media&token=932859eb-ec17-434e-b933-4ef3089c9cee',
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh2.jpg?alt=media&token=22459229-f0b1-4d3f-8420-a384a04aac7b',
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh3.jpg?alt=media&token=a59b4053-f328-4fb1-8e27-e81b1dd8da9f',
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh4.jpg?alt=media&token=a7a232f5-9c67-4278-8418-d4a6a524cc74',
    // 'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
    // 'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
  ];
  List<String> namePicture = [];
  bool isLoading = false;
  PictureConfigController() {
    getListPicture();
  }

  void getListPicture() {
    number = listImg.length;
    for (var i = 0; i < listImg.length; i++) {
      listPicture['$i'] = listImg[i];
      isElevated[i.toString()] = false;
    }
  }

  void setElevated(String key, bool check) {
    isElevated[key] = check;
    notifyListeners();
  }

  String addImageToHotel(PlatformFile pickedFile) {
    baseImg = pickedFile.bytes!;
    listPicture['$number'] = '';
    base64[(number).toString()] = baseImg!;
    namePicture.add((number).toString());
    number++;
    notifyListeners();
    return MessageCodeUtil.SUCCESS;
  }

  String setImageToHotel(PlatformFile pickedFile, String nameNewPicture) {
    namePicture.add(nameNewPicture);
    base64[nameNewPicture] = pickedFile.bytes!;
    notifyListeners();
    return MessageCodeUtil.SUCCESS;
  }

  Future<String> deleteImageFromFirestore(String linkImg, String name) async {
    print(name);
    listDowloadURL = {};
    isLoading = true;
    notifyListeners();
    try {
      // Tham chiếu tới tài liệu
      DocumentReference documentRef = FirebaseFirestore.instance
          .collection('booking_engine')
          .doc(GeneralManager.idHotel);

      // Lấy mảng đường dẫn hình ảnh từ field
      DocumentSnapshot documentSnapshot = await documentRef.get();
      List<dynamic> imagePaths = documentSnapshot.get('imghotel');

      // Xóa đường dẫn hình ảnh khỏi mảng
      imagePaths.remove(linkImg);

      print(listDowloadURL);
      // Xóa hình ảnh từ Firebase Storage
      Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('img_booking_engine/${GeneralManager.hotel!.id}/anh$name');
      await storageRef.delete();
      for (var i = 0; i < imagePaths.length; i++) {
        listDowloadURL[i.toString()] = imagePaths[i];
      }
      String result = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-updateImg')
          .call({
            'hotel_id': GeneralManager.hotel!.id,
            'listimg': listDowloadURL,
          })
          .then((value) => value.data)
          .onError((error, stackTrace) => error.toString());
      print('Tệp đã được xóa thành công từ Firebase Storage.');
      print('Mảng đã được cập nhật thành công trong Firestore.');
      return result;
    } catch (e) {
      print('Có lỗi xảy ra khi xóa tệp hoặc cập nhật mảng: $e');
      return MessageCodeUtil.UNDEFINED_ERROR;
    }
  }

  Future<Map<String, String>> getURL() async {
    String downloadURL = '';
    if (base64.isNotEmpty) {
      try {
        List<Future<void>> futures = base64.keys.map(
          (key) async {
            print('img_booking_engine/${GeneralManager.hotel!.id}/anh$key');
            await FirebaseStorage.instance
                .ref('img_booking_engine/${GeneralManager.hotel!.id}/anh$key')
                .putData(base64[key]!);
            downloadURL = await FirebaseStorage.instance
                .ref('img_booking_engine/${GeneralManager.hotel!.id}/anh$key')
                .getDownloadURL();
            listDowloadURL[key] = downloadURL;
          },
        ).toList();
        await Future.wait(futures);
        print('File uploaded successfully');
        print('Download URL: $listDowloadURL');
      } catch (e) {
        print('Error: $e');
        if (e is FirebaseException) {
          print('FirebaseException code: ${e.code}');
          print('FirebaseException message: ${e.message}');
        }
      }
      return listDowloadURL;
    }
    return listDowloadURL;
  }

  Future<String> updateImg() async {
    isLoading = true;
    notifyListeners();
    listDowloadURL = await getURL();
    if (listDowloadURL.isNotEmpty) {
      String result = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-updateImg')
          .call({
            'hotel_id': GeneralManager.hotel!.id,
            'listimg': listDowloadURL,
          })
          .then((value) => value.data)
          .onError((error, stackTrace) => error.toString());
      if (result == MessageCodeUtil.SUCCESS) {
        for (var key in listDowloadURL.keys) {
          if (GeneralManager.hotel!.imgs!.length > int.parse(key)) {
            GeneralManager.hotel!.imgs![int.parse(key)] = listDowloadURL[key];
          } else {
            GeneralManager.hotel!.imgs!.add(listDowloadURL[key]);
          }
        }
      }
      isLoading = false;
      notifyListeners();
      return result;
    }
    return MessageCodeUtil.STILL_NOT_CHANGE_VALUE;
  }
}
