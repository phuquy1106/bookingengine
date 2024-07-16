import 'package:bookingengine_frontend/constants.dart';
import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/homecontroller.dart';
import 'package:bookingengine_frontend/controller/neutrontextheader.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ColorConfigDialog extends StatefulWidget {
  const ColorConfigDialog({Key? key}) : super(key: key);

  @override
  State<ColorConfigDialog> createState() => _ColorConfigDialogState();
}

class _ColorConfigDialogState extends State<ColorConfigDialog> {
  final ColorConfigController colorConfigController = ColorConfigController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManagement.lightMainBackground,
      child: SizedBox(
          width: kMobileWidth,
          child: SingleChildScrollView(
            child: ChangeNotifierProvider<ColorConfigController>.value(
              value: colorConfigController,
              child: Consumer<ColorConfigController>(
                builder: (_, controller, __) => controller.isInProgress
                    ? Container(
                        height: kMobileWidth,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                            color: ColorManagement.greenColor),
                      )
                    : Stack(
                        children: [
                          Positioned(
                              top: 10,
                              right: 20,
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ))),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //header
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                    vertical:
                                        SizeManagement.topHeaderTextSpacing),
                                child: NeutronTextHeader(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.SIDEBAR_COLOR),
                                ),
                              ),
                              //background
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeManagement
                                        .cardOutsideHorizontalPadding,
                                    vertical: SizeManagement.rowSpacing),
                                child: NeutronTextTitle(
                                  isPadding: false,
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TABLEHEADER_BACKGROUND),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                      width: SizeManagement
                                          .cardOutsideHorizontalPadding),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _buildColorPicker(
                                                  context,
                                                  'background',
                                                  'text',
                                                  colorConfigController));
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 4),
                                      color: controller
                                          .colors['background']!['text'],
                                    ),
                                  ),
                                  Expanded(
                                    child: NeutronTextContent(
                                      message: UITitleUtil.getTitleByCode(
                                          UITitleCode.TABLEHEADER_TEXT_COLOR),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _buildColorPicker(
                                                  context,
                                                  'background',
                                                  'main',
                                                  colorConfigController));
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 4),
                                      color: controller
                                          .colors['background']!['main'],
                                    ),
                                  ),
                                  Expanded(
                                    child: NeutronTextContent(
                                      message: UITitleUtil.getTitleByCode(
                                          UITitleCode.TABLEHEADER_BACKGROUND),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: SizeManagement
                                          .cardOutsideHorizontalPadding),
                                ],
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SizeManagement.rowSpacing),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      width: 100,
                                      height: GeneralManager.bookingCellHeight,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                color: controller.colors[
                                                    'background']!['main'],
                                                child: Text(
                                                  'Text',
                                                  style: TextStyle(
                                                      color: controller.colors[
                                                              'background']![
                                                          'text'],
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      decoration:
                                                          TextDecoration.none),
                                                )),
                                          )
                                        ],
                                      ))),
                              const Divider(
                                  color: ColorManagement.borderCell,
                                  thickness: 1,
                                  height: 4),
                              //button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeManagement
                                        .cardOutsideHorizontalPadding,
                                    vertical: SizeManagement.rowSpacing),
                                child: NeutronTextTitle(
                                  isPadding: false,
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.BUTTON),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                      width: SizeManagement
                                          .cardOutsideHorizontalPadding),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _buildColorPicker(
                                                  context,
                                                  'button',
                                                  'text',
                                                  colorConfigController));
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 4),
                                      color:
                                          controller.colors['button']!['text'],
                                    ),
                                  ),
                                  Expanded(
                                    child: NeutronTextContent(
                                      message: UITitleUtil.getTitleByCode(
                                          UITitleCode.TABLEHEADER_TEXT_COLOR),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _buildColorPicker(
                                                  context,
                                                  'button',
                                                  'main',
                                                  colorConfigController));
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 4),
                                      color:
                                          controller.colors['button']!['main'],
                                    ),
                                  ),
                                  Expanded(
                                    child: NeutronTextContent(
                                      message: UITitleUtil.getTitleByCode(
                                          UITitleCode.TABLEHEADER_BACKGROUND),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: SizeManagement
                                          .cardOutsideHorizontalPadding),
                                ],
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SizeManagement.rowSpacing),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      width: 100,
                                      height: GeneralManager.bookingCellHeight,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                color: controller
                                                    .colors['button']!['main'],
                                                child: Text(
                                                  'Button Text',
                                                  style: TextStyle(
                                                      color: controller.colors[
                                                          'button']!['text'],
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      decoration:
                                                          TextDecoration.none),
                                                )),
                                          )
                                        ],
                                      ))),
                              //appbar
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: SizeManagement
                                        .cardOutsideHorizontalPadding,
                                    vertical: SizeManagement.rowSpacing),
                                child: NeutronTextTitle(
                                  isPadding: false,
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.APP_BAR),
                                ),
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                      width: SizeManagement
                                          .cardOutsideHorizontalPadding),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _buildColorPicker(
                                                  context,
                                                  'appbar',
                                                  'text',
                                                  colorConfigController));
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 4),
                                      color:
                                          controller.colors['appbar']!['text'],
                                    ),
                                  ),
                                  Expanded(
                                    child: NeutronTextContent(
                                      message: UITitleUtil.getTitleByCode(
                                          UITitleCode.TABLEHEADER_TEXT_COLOR),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              _buildColorPicker(
                                                  context,
                                                  'appbar',
                                                  'main',
                                                  colorConfigController));
                                    },
                                    child: Container(
                                      height: 15,
                                      width: 15,
                                      margin: const EdgeInsets.only(right: 4),
                                      color:
                                          controller.colors['appbar']!['main'],
                                    ),
                                  ),
                                  Expanded(
                                    child: NeutronTextContent(
                                      message: UITitleUtil.getTitleByCode(
                                          UITitleCode.TABLEHEADER_BACKGROUND),
                                    ),
                                  ),
                                  const SizedBox(
                                      width: SizeManagement
                                          .cardOutsideHorizontalPadding),
                                ],
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: SizeManagement.rowSpacing),
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                      width: 100,
                                      height: GeneralManager.bookingCellHeight,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                width: double.infinity,
                                                height: double.infinity,
                                                alignment: Alignment.centerLeft,
                                                padding: const EdgeInsets.only(
                                                    left: 8),
                                                color: controller
                                                    .colors['appbar']!['main'],
                                                child: Text(
                                                  'Appbar Text',
                                                  style: TextStyle(
                                                      color: controller.colors[
                                                          'appbar']!['text'],
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      decoration:
                                                          TextDecoration.none),
                                                )),
                                          )
                                        ],
                                      ))),
                            ],
                          ),
                          Positioned(
                            bottom: -10,
                            left: -10,
                            right: -10,
                            child: NeutronButton(
                              onPressed: () async {
                                String? result = await controller.updateColor();
                                if (!mounted) {
                                  return;
                                }
                                if (result == MessageCodeUtil.SUCCESS) {
                                  bool? confirmResult =
                                      await MaterialUtil.showConfirm(
                                          context,
                                          MessageUtil.getMessageByCode(
                                              MessageCodeUtil
                                                  .TEXTALERT_CHANGE_COLOR_SUCCESS_AND_RELOAD));
                                  if (confirmResult == null || !confirmResult) {
                                    return;
                                  }
                                  HomeController().rebuild();
                                } else {
                                  MaterialUtil.showAlert(context,
                                      MessageUtil.getMessageByCode(result));
                                }
                              },
                              icon: Icons.save,
                              tooltip: UITitleUtil.getTitleByCode(
                                  UITitleCode.TOOLTIP_SAVE),
                            ),
                          )
                        ],
                      ),
              ),
            ),
          )),
    );
  }

  Dialog _buildColorPicker(BuildContext context, String type, String component,
      ColorConfigController colorConfigController) {
    Color tempColor = colorConfigController.colors[type]![component]!;
    return Dialog(
      backgroundColor: ColorManagement.lightMainBackground,
      child: Theme(
        data: ThemeData.dark(),
        child: SizedBox(
          width: kMobileWidth,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialPicker(
                  enableLabel: true,
                  onColorChanged: (Color color) {
                    tempColor = color;
                  },
                  pickerColor: tempColor,
                ),
                NeutronButton(
                  tooltip1:
                      UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CANCEL),
                  tooltip2:
                      UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_SAVE),
                  icon1: Icons.cancel,
                  onPressed1: () {
                    Navigator.pop(context);
                  },
                  icon2: Icons.save,
                  onPressed2: () {
                    colorConfigController.setColor(type, component, tempColor);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ColorConfigController extends ChangeNotifier {
  bool isInProgress = false;
  Map<String, Map<String, Color>> colors = {};

  ColorConfigController() {
    colors['background'] = <String, Color>{};
    colors['button'] = <String, Color>{};
    colors['appbar'] = <String, Color>{};
    print(GeneralManager.hotel!.colors!);
    if (GeneralManager.hotel!.colors!.isEmpty) {
      colors['background']!['text'] =
          ColorManagement.bookingNameOfCheckinBooking;
      colors['background']!['main'] = ColorManagement.checkinBooking;

      colors['button']!['text'] = ColorManagement.bookingNameOfBookedBooking;
      colors['button']!['main'] = ColorManagement.bookedBooking;

      colors['appbar']!['text'] = ColorManagement.bookingNameOfBookedBooking;
      colors['appbar']!['main'] = ColorManagement.bookedBooking;
    } else {
      colors['background']!['text'] =
          Color(GeneralManager.hotel!.colors!['background']['text']);
      colors['background']!['main'] =
          Color(GeneralManager.hotel!.colors!['background']['main']);

      colors['button']!['text'] =
          Color(GeneralManager.hotel!.colors!['button']['text']);
      colors['button']!['main'] =
          Color(GeneralManager.hotel!.colors!['button']['main']);

      colors['appbar']!['text'] =
          Color(GeneralManager.hotel!.colors!['appbar']['text']);
      colors['appbar']!['main'] =
          Color(GeneralManager.hotel!.colors!['appbar']['main']);
    }
  }

  void setColor(String type, String component, Color newColor) {
    if (colors[type]![component]!.value == newColor.value) {
      return;
    }
    colors[type]![component] = newColor;
    notifyListeners();
  }

  bool isChangeValue() {
    if (GeneralManager.hotel!.colors!.isEmpty) {
      return true;
    }
    if (GeneralManager.hotel!.colors!['background']['text'] !=
            colors['background']!['text']!.value ||
        GeneralManager.hotel!.colors!['background']['main'] !=
            colors['background']!['main']!.value ||
        GeneralManager.hotel!.colors!['button']['text'] !=
            colors['button']!['text']!.value ||
        GeneralManager.hotel!.colors!['button']['main'] !=
            colors['button']!['main']!.value ||
        GeneralManager.hotel!.colors!['appbar']['text'] !=
            colors['appbar']!['text']!.value ||
        GeneralManager.hotel!.colors!['appbar']['main'] !=
            colors['appbar']!['main']!.value) {
      return true;
    }
    return false;
  }

  Future<String> updateColor() async {
    if (!isChangeValue()) {
      return MessageCodeUtil.STILL_NOT_CHANGE_VALUE;
    }
    Map<String, Map<String, int>> dataUpdate = {};
    dataUpdate['background'] = {};
    dataUpdate['background']!['text'] = colors['background']!['text']!.value;
    dataUpdate['background']!['main'] = colors['background']!['main']!.value;
    dataUpdate['button'] = {};
    dataUpdate['button']!['text'] = colors['button']!['text']!.value;
    dataUpdate['button']!['main'] = colors['button']!['main']!.value;

    dataUpdate['appbar'] = {};
    dataUpdate['appbar']!['text'] = colors['appbar']!['text']!.value;
    dataUpdate['appbar']!['main'] = colors['appbar']!['main']!.value;

    isInProgress = true;
    notifyListeners();
    String result = await FirebaseFunctions.instance
        .httpsCallable('bookingengine-updateColor')
        .call({'hotel_id': GeneralManager.idHotel, 'colors': dataUpdate})
        .then((value) => value.data)
        .onError((error, stackTrace) => error.toString());
    if (result == MessageCodeUtil.SUCCESS) {
      GeneralManager.hotel!.colors = Map.from(dataUpdate);
    }
    isInProgress = false;
    notifyListeners();
    return MessageCodeUtil.SUCCESS;
  }
}
