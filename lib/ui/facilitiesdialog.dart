import 'package:bookingengine_frontend/constants.dart';
import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/facilitiesdialogcontroller.dart';
import 'package:bookingengine_frontend/controller/homecontroller.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/responsiveutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FacilitiesDialog extends StatefulWidget {
  const FacilitiesDialog({super.key});

  @override
  State<FacilitiesDialog> createState() => _FacilitiesDialogState();
}

class _FacilitiesDialogState extends State<FacilitiesDialog> {
  FacilitiesController facilitiesController = FacilitiesController();
  int getCrossAxisCount(double screenWidth) {
    if (screenWidth > 1800) {
      return 4;
    } else if (screenWidth > 1500) {
      return 4;
    } else if (screenWidth > 1350) {
      return 4;
    } else if (screenWidth > 1100) {
      return 3;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final int crossAxisCount = getCrossAxisCount(screenWidth);
    final bool isMobile = ResponsiveUtil.isMobile(context);
    return Dialog(
        backgroundColor: ColorUtil.colorBackgroudMain,
        child: ChangeNotifierProvider<FacilitiesController>.value(
          value: facilitiesController,
          child: Consumer<FacilitiesController>(
              builder: (_, facilitiesController, __) {
            return facilitiesController.isLoading
                ? Container(
                    height: kMobileWidth,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                        color: ColorManagement.greenColor),
                  )
                : Stack(
                    children: [
                      Positioned(
                          top: isMobile ? 5 : 10,
                          right: 20,
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: ColorUtil.colorBackgroudText,
                              ))),
                      SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Column(children: [
                            const SizedBox(
                              height: 20,
                            ),
                            NeutronTextTitle(
                              message: UITitleUtil.getTitleByCode(
                                  UITitleCode.HOTEL_FACILITIES),
                              color: ColorUtil.colorBackgroudText,
                              fontSize: 36,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            SingleChildScrollView(
                                child: SizedBox(
                              height: 500,
                              child: GridView.count(
                                crossAxisCount: crossAxisCount,
                                childAspectRatio: 6,
                                children: facilitiesController
                                    .hotelFacilities.keys
                                    .map((key) => CheckboxListTile(
                                          value: facilitiesController
                                              .listFacilities
                                              .contains(key),
                                          onChanged: (value) {
                                            setState(() {
                                              facilitiesController
                                                  .setFacilities(key, value!);
                                            });
                                          },
                                          title: SizedBox(
                                            child: Row(children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: facilitiesController
                                                      .hotelFacilities[key]!),
                                              Expanded(
                                                flex: 3,
                                                child: NeutronTextContent(
                                                    message: UITitleUtil
                                                        .getTitleByCode(key),
                                                    color: ColorUtil
                                                        .colorBackgroudText),
                                              )
                                            ]),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ))
                          ]),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: NeutronButton(
                            onPressed: () async {
                              String? result =
                                  await facilitiesController.updateFacilities();
                              if (!mounted) {
                                return;
                              }
                              if (result == MessageCodeUtil.SUCCESS) {
                                bool? confirmResult = await MaterialUtil.showConfirm(
                                    context,
                                    MessageUtil.getMessageByCode(MessageCodeUtil
                                        .TEXTALERT_CHANGE_LAYOUT_SUCCESS_AND_RELOAD));
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
                          ))
                    ],
                  );
          }),
        ));
  }
}
