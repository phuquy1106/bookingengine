import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/editroomtypecontroller.dart';
import 'package:bookingengine_frontend/gen/assets.gen.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/ui/addtoroom.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'editfacilitiesroomdialog.dart';

class EditPictureRoomDialog extends StatefulWidget {
  const EditPictureRoomDialog({super.key, this.roomType});
  final RoomType? roomType;
  @override
  State<EditPictureRoomDialog> createState() => _EditPictureRoomDialogState();
}

class _EditPictureRoomDialogState extends State<EditPictureRoomDialog> {
  late EditRoomTypeController editRoomTypeController;
  @override
  void initState() {
    editRoomTypeController = EditRoomTypeController(roomType: widget.roomType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: SizedBox(
      width: 600,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: ColorUtil.colorBackgroudMain,
          appBar: AppBar(
            title: NeutronTextContent(
              message:
                  UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_PICTURE_ROOM),
              fontSize: 26,
              color: ColorUtil.colorBackgroudText,
            ),
            leading: Icon(
              Icons.arrow_back,
              color: ColorUtil.colorBackgroudText,
            ),
            bottom: TabBar(tabs: [
              Tooltip(
                message: UITitleUtil.getTitleByCode(
                    UITitleCode.TOOLTIP_EDIT_PICTURE),
                child: Tab(
                  icon: SvgPicture.asset(
                    Assets.icon.editImage,
                    height: 36,
                  ),
                ),
              ),
              Tooltip(
                message:
                    UITitleUtil.getTitleByCode(UITitleCode.ROOM_FACILITIES),
                child: Tab(
                  icon: SvgPicture.asset(
                    Assets.icon.facilitiesRoom,
                    height: 36,
                  ),
                ),
              ),
            ]),
            backgroundColor: ColorUtil.colorBackgroudMain,
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              EditPictureRoomWidget(
                editRoomTypeController: editRoomTypeController,
                roomType: widget.roomType,
              ),
              EditFacilitiesRoomDialog(
                roomType: widget.roomType,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class EditPictureRoomWidget extends StatefulWidget {
  const EditPictureRoomWidget(
      {super.key, this.editRoomTypeController, this.roomType});
  final EditRoomTypeController? editRoomTypeController;
  final RoomType? roomType;

  @override
  State<EditPictureRoomWidget> createState() => _EditPictureRoomWidgetState();
}

class _EditPictureRoomWidgetState extends State<EditPictureRoomWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.editRoomTypeController,
      child: Consumer<EditRoomTypeController>(
          builder: (_, editRoomTypeController, __) {
        return editRoomTypeController.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                    color: ColorManagement.greenColor))
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 60),
                      child: Column(children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: NeutronTextTitle(
                                isPadding: false,
                                message: UITitleUtil.getTitleByCode(
                                    UITitleCode.TOOLTIP_UPLOAD_PHOTOS),
                                color: ColorUtil.colorBackgroudText,
                                fontSize: 16,
                              ),
                            ),
                            if (editRoomTypeController.number < 5)
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  dashPattern: const [20, 4],
                                  child: Container(
                                    color: const Color(0xffdbe1e1),
                                    height: 100,
                                    width: double.infinity,
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 30),
                                                height: 100,
                                                child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Image.asset(
                                                      'assets/img/logopicture.jpg'),
                                                ),
                                              )),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: SizedBox(
                                                  height: 100,
                                                  child: InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AddToRoom(
                                                                idRoom: widget
                                                                    .roomType!
                                                                    .id,
                                                              ));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: Icon(
                                                            Icons.add,
                                                            color: ColorUtil
                                                                .colorBackgroudText,
                                                          ),
                                                        ),
                                                        NeutronTextTitle(
                                                          isPadding: false,
                                                          message: UITitleUtil
                                                              .getTitleByCode(
                                                                  UITitleCode
                                                                      .TOOLTIP_UPLOAD_PHOTOS),
                                                          color: ColorUtil
                                                              .colorBackgroudText,
                                                          fontSize: 16,
                                                        ),
                                                      ],
                                                    ),
                                                  )))
                                        ]),
                                  ),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              height: 500,
                              child: GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 1.5,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                children: widget.roomType!.imgs!.keys
                                    .map((key) => MouseRegion(
                                          onEnter: (_) {
                                            setState(() =>
                                                editRoomTypeController
                                                    .setElevated(key, true));
                                          },
                                          onExit: (_) => setState(() =>
                                              editRoomTypeController
                                                  .setElevated(key, false)),
                                          child: AnimatedContainer(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow:
                                                    editRoomTypeController
                                                            .isElevated[key]!
                                                        ? [
                                                            const BoxShadow(
                                                              color: Colors
                                                                  .black26,
                                                              offset:
                                                                  Offset(0, 10),
                                                              blurRadius: 20,
                                                            ),
                                                          ]
                                                        : [],
                                              ),
                                              child: picture(
                                                  editRoomTypeController,
                                                  key,
                                                  context,
                                                  editRoomTypeController
                                                      .isElevated[key]!,
                                                  widget.roomType!.imgs![key],
                                                  widget.roomType!.id!)),
                                        ))
                                    .toList(),
                              ),
                            )
                          ],
                        ))
                      ]),
                    ),
                  ),
                ],
              );
      }),
    );
  }

  Widget picture(EditRoomTypeController pictureConfigController, String nameImg,
      BuildContext context, bool isElevated, String img, String idRoom) {
    return Stack(
      children: [
        SizedBox(
          width: 400,
          height: 220,
          child: Image.network(
            img,
            fit: BoxFit.fill,
          ),
        ),
        if (isElevated)
          Positioned(
              right: 0,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => AddToRoom(
                                img: nameImg,
                                linkImg: img,
                                idRoom: idRoom,
                              ));
                    },
                    child:
                        Icon(Icons.edit, color: ColorUtil.colorBackgroudText),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      String? result = await pictureConfigController
                          .deleteImageFromFirestore(nameImg, idRoom);
                      if (context.mounted) {
                        MaterialUtil.showAlert(
                            context, MessageUtil.getMessageByCode(result));
                      }
                    },
                    child:
                        Icon(Icons.delete, color: ColorUtil.colorBackgroudText),
                  ),
                ],
              ))
      ],
    );
  }
}
