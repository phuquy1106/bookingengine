import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/layoutpicturecontroller.dart';
import 'package:bookingengine_frontend/controller/homecontroller.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/responsiveutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class LayOutPicture extends StatefulWidget {
  const LayOutPicture({super.key});

  @override
  State<LayOutPicture> createState() => _LayOutPictureState();
}

class _LayOutPictureState extends State<LayOutPicture> {
  LayOutPictureController layOutPictureController = LayOutPictureController();
  List<String> name = ['1', '2', '3', '4', '5'];
  List<String> name2 = ['1', '2', '3', '4'];
  List<String> name4 = ['1', '2', '3'];
  List<String> name3 = ['1', '2'];
  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtil.isMobile(context);
    return Dialog(
      backgroundColor: ColorUtil.colorBackgroudMain,
      child: ChangeNotifierProvider<LayOutPictureController>.value(
        value: layOutPictureController,
        child: Consumer<LayOutPictureController>(builder: (_, controller, __) {
          return controller.isInProgress
              ? Container(
                  height: 500,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                      color: ColorManagement.greenColor),
                )
              : SizedBox(
                  width: 800,
                  height: 700,
                  child: Stack(
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
                          margin: const EdgeInsets.only(bottom: 60),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              NeutronTextTitle(
                                message: UITitleUtil.getTitleByCode(
                                    UITitleCode.SIDEBAR_HOTEL),
                                fontSize: 26,
                                color: ColorUtil.colorBackgroudText,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 600,
                                width: 800,
                                child: GridView.count(
                                  crossAxisCount: isMobile ? 1 : 2,
                                  childAspectRatio: 1.8,
                                  padding: const EdgeInsets.all(20),
                                  children: [
                                    RadioListTile(
                                      value: 'layout01',
                                      groupValue: controller.layoutHotel,
                                      activeColor: ColorUtil.colorBackgroudText,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutHotel = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name3
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: 2,
                                                  mainAxisCellCount: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: Colors.black,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout02',
                                      groupValue: controller.layoutHotel,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutHotel = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name4
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount:
                                                      e == '3' ? 4 : 2,
                                                  mainAxisCellCount:
                                                      e == '3' ? 1 : 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout03',
                                      groupValue: controller.layoutHotel,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutHotel = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name2
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: 2,
                                                  mainAxisCellCount: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout04',
                                      groupValue: controller.layoutHotel,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutHotel = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name2
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: e == '1'
                                                      ? 2
                                                      : e == '4'
                                                          ? 2
                                                          : 1,
                                                  mainAxisCellCount: e == '1'
                                                      ? 2
                                                      : e == '4'
                                                          ? 1
                                                          : 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout05',
                                      groupValue: controller.layoutHotel,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutHotel = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount:
                                                      e == '1' ? 2 : 1,
                                                  mainAxisCellCount:
                                                      e == '1' ? 2 : 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout06',
                                      groupValue: controller.layoutHotel,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutHotel = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 5,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: 1,
                                                  mainAxisCellCount: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              NeutronTextTitle(
                                message: UITitleUtil.getTitleByCode(
                                    UITitleCode.SIDEBAR_ROOM),
                                fontSize: 26,
                                color: ColorUtil.colorBackgroudText,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 600,
                                width: 800,
                                child: GridView.count(
                                  crossAxisCount: isMobile ? 1 : 2,
                                  childAspectRatio: 1.8,
                                  padding: const EdgeInsets.all(20),
                                  children: [
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout01',
                                      groupValue: controller.layoutRoom,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutRoom = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name3
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: 2,
                                                  mainAxisCellCount: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout02',
                                      groupValue: controller.layoutRoom,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutRoom = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name4
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount:
                                                      e == '3' ? 4 : 2,
                                                  mainAxisCellCount:
                                                      e == '3' ? 1 : 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout03',
                                      groupValue: controller.layoutRoom,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutRoom = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name2
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: 2,
                                                  mainAxisCellCount: 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout04',
                                      groupValue: controller.layoutRoom,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutRoom = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name2
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: e == '1'
                                                      ? 2
                                                      : e == '4'
                                                          ? 2
                                                          : 1,
                                                  mainAxisCellCount: e == '1'
                                                      ? 2
                                                      : e == '4'
                                                          ? 1
                                                          : 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout05',
                                      groupValue: controller.layoutRoom,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutRoom = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 4,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount:
                                                      e == '1' ? 2 : 1,
                                                  mainAxisCellCount:
                                                      e == '1' ? 2 : 1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                    RadioListTile(
                                      activeColor: ColorUtil.colorBackgroudText,
                                      value: 'layout06',
                                      groupValue: controller.layoutRoom,
                                      onChanged: (value) {
                                        setState(() {
                                          controller.layoutRoom = value!;
                                        });
                                      },
                                      title: StaggeredGrid.count(
                                          crossAxisCount: 5,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 2,
                                          children: name
                                              .map(
                                                (e) => StaggeredGridTile.count(
                                                  crossAxisCellCount: 1,
                                                  mainAxisCellCount: 2,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    8)),
                                                        border: Border.all(
                                                            color:
                                                                Colors.amber)),
                                                    child: Title(
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      child: NeutronTextTitle(
                                                          message: e),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList()),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: NeutronButton(
                          onPressed: () async {
                            String? result = await controller.updateLayout();
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
                          tooltip: UITitleUtil.getTitleByCode(
                              UITitleCode.TOOLTIP_SAVE),
                        ),
                      )
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
