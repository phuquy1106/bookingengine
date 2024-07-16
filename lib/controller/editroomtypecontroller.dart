import 'dart:typed_data';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EditRoomTypeController extends ChangeNotifier {
  List<String> listPictureRoom = [];
  Map<String, dynamic> listPicture = {};
  Map<String, Uint8List> base64 = {};
  List<String> namePictureRoom = [];
  Uint8List? baseImg;
  bool isLoading = false;
  int number = 0;
  Map<String, String> listDowloadURL = {};
  EditRoomTypeController({List<dynamic>? listPictureRoomWidget}) {
    number = listPictureRoomWidget!.length;
    for (var element in listPictureRoomWidget) {
      listPictureRoom.add(element);
    }
    getPictureRoom();
  }

  void getPictureRoom() {
    if (listPictureRoom.isNotEmpty) {
      for (var i = 0; i < listPictureRoom.length; i++) {
        listPicture['$i'] = listPictureRoom[i];
      }
    }
  }

  String setImageToRoom(PlatformFile pickedFile, String nameNewPictureRoom) {
    namePictureRoom.add(nameNewPictureRoom);
    base64[nameNewPictureRoom] = pickedFile.bytes!;
    notifyListeners();
    return MessageCodeUtil.SUCCESS;
  }

  Future<Map<String, String>> getURL(String id) async {
    String downloadURL = '';
    if (base64.isNotEmpty) {
      try {
        List<Future<void>> futures = base64.keys.map(
          (key) async {
            await FirebaseStorage.instance
                .ref(
                    'img_booking_engine/${GeneralManager.hotel!.id}/$id/anh$key')
                .putData(base64[key]!);
            downloadURL = await FirebaseStorage.instance
                .ref(
                    'img_booking_engine/${GeneralManager.hotel!.id}/$id/anh$key')
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

  String addImageToRoom(PlatformFile pickedFile) {
    baseImg = pickedFile.bytes!;
    listPicture['$number'] = '';
    base64[(number).toString()] = baseImg!;
    namePictureRoom.add((number).toString());
    number++;
    notifyListeners();
    return MessageCodeUtil.SUCCESS;
  }

  Future<String> updatePictureRoom(String id) async {
    isLoading = true;
    notifyListeners();
    listDowloadURL = await getURL(id);
    if (listDowloadURL.isNotEmpty) {
      String result = await FirebaseFunctions.instance
          .httpsCallable('bookingengine-updateImgRoom')
          .call({
            'hotel_id': GeneralManager.hotel!.id,
            'room_id': id,
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
