import 'dart:ui';

import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';

class ColorUtil {
  static Color colorBackgroudMain =
      GeneralManager.hotel!.colors?['background']?['main'] != null
          ? Color(GeneralManager.hotel!.colors!['background']['main'])
          : ColorManagement.white;
  static Color colorBackgroudText =
      GeneralManager.hotel!.colors?['background']?['text'] != null
          ? Color(GeneralManager.hotel!.colors!['background']['text'])
          : ColorManagement.textBlack;

  static Color colorAppBarMain =
      GeneralManager.hotel!.colors?['appbar']?['main'] != null
          ? Color(GeneralManager.hotel!.colors!['appbar']['main'])
          : ColorManagement.textBlack;

  static Color colorAppBarText =
      GeneralManager.hotel!.colors?['appbar']?['text'] != null
          ? Color(GeneralManager.hotel!.colors!['appbar']['text'])
          : ColorManagement.textBlack;
  static Color colorButtonrMain =
      GeneralManager.hotel!.colors?['button']?['main'] != null
          ? Color(GeneralManager.hotel!.colors!['button']['main'])
          : ColorManagement.textBlack;

  static Color coloButtonText =
      GeneralManager.hotel!.colors?['button']?['text'] != null
          ? Color(GeneralManager.hotel!.colors!['button']['text'])
          : ColorManagement.textBlack;
}
