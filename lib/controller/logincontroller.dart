import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../validator/stringvalidator.dart';

class LoginController extends ChangeNotifier {
  bool? isRememberMe;
  bool isShowPassword = false;
  bool isLoadding = false;
  TextEditingController? emailController;
  TextEditingController? passwordController;

  LoginController() {
    emailController = TextEditingController(text: '');
    passwordController = TextEditingController(text: '');
    isRememberMe = true;
  }

  void setRememberMe(bool value) {
    isRememberMe = value;
    notifyListeners();
  }

  void toggleShowPasswordStatus() {
    if (passwordController!.text.isEmpty) {
      isShowPassword = false;
    } else {
      isShowPassword = !isShowPassword;
    }
    notifyListeners();
  }

  Future<String> login() async {
    String? validdateEmail =
        StringValidator.validateRequiredEmail(emailController!.text);
    if (validdateEmail != null) {
      return validdateEmail;
    }
    String? validdatePassword =
        StringValidator.validatePassword(passwordController!.text);
    if (validdatePassword != null) {
      return validdatePassword;
    }
    isLoadding = true;
    notifyListeners();

    if (kIsWeb) {
      Persistence persistence =
          isRememberMe! ? Persistence.LOCAL : Persistence.SESSION;
      await FirebaseAuth.instance.setPersistence(persistence).onError(
          (error, stackTrace) =>
              print('setPersistence Error: ${error.toString()}'));
    }
    notifyListeners();
    String result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController!.text, password: passwordController!.text)
        .then((value) async {
      return await GeneralManager.getHotelUser(value.user?.uid ?? "")
          .then((value) async {
        if (!GeneralManager.listIdHotel!.contains(GeneralManager.idHotel)) {
          await GeneralManager.signOut();
          isLoadding = false;
          notifyListeners();
          return MessageCodeUtil.NOT_HOTEL_MEMBER;
        } else {
          isLoadding = false;
          notifyListeners();
          return MessageCodeUtil.SUCCESS;
        }
      });
    }).catchError((e) {
      isLoadding = false;
      notifyListeners();
      return (e as FirebaseAuthException).code;
    });
    return MessageUtil.getMessageByCode(result);
  }
}
