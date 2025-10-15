import 'dart:typed_data';

import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PictureConfigController extends ChangeNotifier {
  Map<String, String> listPicture = {};
  Map<String, Uint8List> base64 = {};
  Map<String, bool> isElevated = {};
  TextEditingController? nameImg;
  Uint8List? baseImg;
  int number = 0;
  String linkUrl = '';
  String linkPicture = '';
  bool isLoading = false;
  PictureConfigController({String? name}) {
    if (name != null) {
      nameImg = TextEditingController(text: name);
    } else {
      nameImg = TextEditingController(text: '');
    }
    getListPicture();
  }

  void getListPicture() {
    number = GeneralManager.hotel!.imgs!.length;
    for (var key in GeneralManager.hotel!.imgs!.keys) {
      listPicture[key] = GeneralManager.hotel!.imgs![key];
      isElevated[key] = false;
    }
  }

  void setElevated(String key, bool check) {
    isElevated[key] = check;
    notifyListeners();
  }

  String addImageToHotel(PlatformFile pickedFile) {
    baseImg = pickedFile.bytes!;
    notifyListeners();
    return MessageCodeUtil.SUCCESS;
  }

  Future<String> deleteImageFromFirestore(String name) async {
    print(name);
    isLoading = true;
    notifyListeners();
    try {
      // Xóa hình ảnh từ Firebase Storage

      String result = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-delteImg')
          .call({
            'hotel_id': GeneralManager.hotel!.id,
            'name': name,
          })
          .then((value) => value.data)
          .onError((error, stackTrace) => error.toString());
      print('Tệp đã được xóa thành công từ Firebase Storage.');
      print('Mảng đã được cập nhật thành công trong Firestore.');
      if (result == '') {
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child('img_booking_engine/${GeneralManager.hotel!.id}/$name');
        await storageRef.delete();
      }
      isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      print('Có lỗi xảy ra khi xóa tệp hoặc cập nhật mảng: $e');
      isLoading = false;
      notifyListeners();
      return MessageCodeUtil.UNDEFINED_ERROR;
    }
  }

  Future<void> getURL() async {
    if (baseImg != null) {
      try {
        // Tạo tham chiếu đến file
        final ref = FirebaseStorage.instance.ref(
            'img_booking_engine/${GeneralManager.hotel!.id}/${nameImg!.text}');

        // Tải lên ảnh
        await ref.putData(baseImg!);

        // Lấy URL tải xuống
        String downloadURL = await ref.getDownloadURL();

        // Lưu URL vào listDowloadURL
        linkUrl = downloadURL;

        print('Image uploaded successfully: $downloadURL');
      } catch (e) {
        print('Error: $e');
        if (e is FirebaseException) {
          print('FirebaseException code: ${e.code}');
          print('FirebaseException message: ${e.message}');
        }
      }
    }
  }

  Future<String> updateImg() async {
    if (nameImg?.text == '') {
      return 'vui lòng nhập tên ảnh';
    }
    isLoading = true;
    notifyListeners();
    await getURL();
    if (linkUrl.isNotEmpty) {
      String result = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-updateImg')
          .call({
            'hotel_id': GeneralManager.hotel!.id,
            'nameImg': nameImg!.text,
            'linkImg': linkUrl,
          })
          .then((value) => value.data)
          .onError((error, stackTrace) => error.toString());
      if (result == MessageCodeUtil.SUCCESS) {
        // for (var key in listDowloadURL.keys) {
        //   if (GeneralManager.hotel!.imgs!.length > int.parse(key)) {
        //     // GeneralManager.hotel!.imgs![nameImg!.text] = listDowloadURL[key];
        //   } else {
        //     // GeneralManager.hotel!.imgs!.add(listDowloadURL[key]);
        //   }
        // }
      }
      isLoading = false;
      notifyListeners();
      return result;
    }
    return MessageCodeUtil.STILL_NOT_CHANGE_VALUE;
  }
}
