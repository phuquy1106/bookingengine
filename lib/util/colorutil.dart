import 'dart:ui';

import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';

class ColorUtil {
  static Color colorBackgroudMain = GeneralManager.hotel!.colors!.isEmpty
      ? ColorManagement.white
      : Color(GeneralManager.hotel!.colors!['background']['main']);
  static Color colorBackgroudText = GeneralManager.hotel!.colors!.isEmpty
      ? ColorManagement.textBlack
      : Color(GeneralManager.hotel!.colors!['background']['text']);

  static Color colorAppBarMain = GeneralManager.hotel!.colors!.isEmpty
      ? ColorManagement.mainBackground
      : Color(GeneralManager.hotel!.colors!['appbar']['main']);

  static Color colorAppBarText = GeneralManager.hotel!.colors!.isEmpty
      ? ColorManagement.lightColorText
      : Color(GeneralManager.hotel!.colors!['appbar']['text']);

  static Color colorButtonrMain = GeneralManager.hotel!.colors!.isEmpty
      ? ColorManagement.greenColor
      : Color(GeneralManager.hotel!.colors!['appbar']['main']);

  static Color coloButtonText = GeneralManager.hotel!.colors!.isEmpty
      ? ColorManagement.blueColor
      : Color(GeneralManager.hotel!.colors!['appbar']['text']);
}
