// import 'package:bookingengine_frontend/constants.dart';
import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrondropdown.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateFontText extends StatelessWidget {
  const UpdateFontText({super.key});

  @override
  Widget build(BuildContext context) {
    UpdateFontTextController controller = UpdateFontTextController();
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<UpdateFontTextController>(builder: (_, controller, __) {
        return Dialog(
          backgroundColor: Colors.white,
          child: SizedBox(
            width: 400,
            height: 260,
            child: Stack(
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
                          color: Colors.black,
                        ))),
                Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const NeutronTextTitle(
                      message: 'Font Family',
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    NeutronDropDown(
                        dropdownColor: Colors.white,
                        focusColor: Colors.white,
                        value: controller.nameFont,
                        isDropdownDarkColor: false,
                        onChanged: (String value) =>
                            controller.setFontFamily(value),
                        textStyle: const TextStyle(color: Colors.black),
                        items: controller.listNameFont),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: Text(
                              'Number',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: GeneralManager
                                      .listFontText[controller.codeFont]),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Text',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: GeneralManager
                                      .listFontText[controller.codeFont]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '1 2 3 4 5 6 7 8 9 0',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: GeneralManager
                                      .listFontText[controller.codeFont]),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'a b c d e f g h d t',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: GeneralManager
                                      .listFontText[controller.codeFont]),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: NeutronButton(
                      onPressed: () async {
                        String? result = '';
                        //     await pictureConfigController.updateImg();
                        if (!context.mounted) {
                          return;
                        }
                        if (result == MessageCodeUtil.SUCCESS) {
                          bool? confirmResult = await MaterialUtil.showConfirm(
                              context,
                              MessageUtil.getMessageByCode(MessageCodeUtil
                                  .TEXTALERT_CHANGE_IMG_SUCCESS_AND_RELOAD));
                          if (confirmResult == null || !confirmResult) {
                            return;
                          }
                        } else {
                          MaterialUtil.showAlert(
                              context, MessageUtil.getMessageByCode(result));
                        }
                      },
                      icon: Icons.save,
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }
}

class UpdateFontTextController extends ChangeNotifier {
  bool isLoading = false;
  String codeFont = '';
  String nameFont = '';
  List<String> listNameFont = [
    'Aria',
    'Overbold',
    'Inter',
    'Static',
    'Times New Roman',
  ];
  Map<String, String> listFont = {
    'Aria': 'aria',
    'Overbold': 'overbole',
    'Inter': 'inter',
    'Static': 'static',
    'Times New Roman': 'timesnewroman',
  };
  UpdateFontTextController() {
    codeFont = GeneralManager.hotel!.font!;
    for (var key in listFont.keys) {
      if (GeneralManager.hotel!.font! == listFont[key]) {
        nameFont = key;
      }
    }
  }

  setFontFamily(String value) {
    nameFont = value;
    codeFont = listFont[nameFont]!;
    notifyListeners();
  }
}
