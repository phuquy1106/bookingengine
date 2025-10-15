import 'dart:typed_data';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditRoomTypeController extends ChangeNotifier {
  Map<String, Uint8List> base64 = {};
  List<String> namePictureRoom = [];
  Uint8List? baseImg;
  bool isLoading = false;
  int number = 0;
  TextEditingController? nameImgRoom;
  String listDowloadURL = '';
  Map<String, bool> isElevated = {};
  EditRoomTypeController({RoomType? roomType, String? nameImg}) {
    if (roomType != null) {
      number = roomType.imgs!.length;
      for (var key in roomType.imgs!.keys) {
        isElevated[key] = false;
      }
    }
    if (nameImg != null) {
      nameImgRoom = TextEditingController(text: nameImg);
    } else {
      nameImgRoom = TextEditingController(text: '');
    }
  }

  void setElevated(String key, bool check) {
    isElevated[key] = check;
    notifyListeners();
  }

  Future<String> deleteImageFromFirestore(String name, String idRoom) async {
    print(name);
    isLoading = true;
    notifyListeners();
    try {
      String result = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-delteImgRoom')
          .call({
            'hotel_id': GeneralManager.hotel!.id,
            'idroom': idRoom,
            'name': name,
          })
          .then((value) => value.data)
          .onError((error, stackTrace) => error.toString());
      print('Tệp đã được xóa thành công từ Firebase Storage.');
      print('Mảng đã được cập nhật thành công trong Firestore.');
      if (result == '') {
        Reference storageRef = FirebaseStorage.instance.ref().child(
            'img_booking_engine/${GeneralManager.hotel!.id}/$idRoom/$name');
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

  Future<void> getURL(String id) async {
    if (baseImg != null) {
      try {
        // Tạo tham chiếu đến file
        final ref = FirebaseStorage.instance.ref(
            'img_booking_engine/${GeneralManager.hotel!.id}/$id/${nameImgRoom!.text}');

        // Tải lên ảnh
        await ref.putData(baseImg!);

        // Lấy URL tải xuống
        String downloadURL = await ref.getDownloadURL();

        // Lưu URL vào listDowloadURL
        listDowloadURL = downloadURL;

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

  String addImageToRoom(PlatformFile pickedFile) {
    baseImg = pickedFile.bytes!;
    notifyListeners();
    return MessageCodeUtil.SUCCESS;
  }

  Future<String> updatePictureRoom(String id) async {
    isLoading = true;
    notifyListeners();
    await getURL(id);
    if (listDowloadURL.isNotEmpty) {
      String result = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-updateImgRoom')
          .call({
            'hotel_id': GeneralManager.hotel!.id,
            'room_id': id,
            'nameImg': nameImgRoom!.text,
            'linkimg': listDowloadURL,
          })
          .then((value) => value.data)
          .onError((error, stackTrace) => error.toString());
      if (result == MessageCodeUtil.SUCCESS) {
        // for (var key in listDowloadURL.keys) {
        //   if (GeneralManager.hotel!.imgs!.length > int.parse(key)) {
        //     // GeneralManager.hotel!.imgs![int.parse(key)] = listDowloadURL[key];
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
