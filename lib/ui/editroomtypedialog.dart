import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/editroomtypecontroller.dart';
import 'package:bookingengine_frontend/gen/assets.gen.dart';
import 'package:bookingengine_frontend/handler/filehandler.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'editfacilitiesroomdialog.dart';

class EditPictureRoomDialog extends StatefulWidget {
  const EditPictureRoomDialog({super.key, this.listPictureRoom, this.roomType});
  final List<dynamic>? listPictureRoom;
  final RoomType? roomType;
  @override
  State<EditPictureRoomDialog> createState() => _EditPictureRoomDialogState();
}

class _EditPictureRoomDialogState extends State<EditPictureRoomDialog> {
  late EditRoomTypeController editRoomTypeController;
  @override
  void initState() {
    editRoomTypeController =
        EditRoomTypeController(listPictureRoomWidget: widget.listPictureRoom);
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

class EditPictureRoomWidget extends StatelessWidget {
  const EditPictureRoomWidget(
      {super.key, this.editRoomTypeController, this.roomType});
  final EditRoomTypeController? editRoomTypeController;
  final RoomType? roomType;
  @override
  Widget build(BuildContext context) {
    void pickImage(String? namePicture) async {
      PlatformFile? pickedFile = await FileHandler.pickSingleImage(context);
      if (pickedFile == null) {
        return;
      }
      String result = namePicture!.isNotEmpty
          ? editRoomTypeController!.setImageToRoom(pickedFile, namePicture)
          : editRoomTypeController!.addImageToRoom(pickedFile);
      if (context.mounted && result != MessageCodeUtil.SUCCESS) {
        MaterialUtil.showAlert(context, result);
      }
    }

    return ChangeNotifierProvider.value(
      value: editRoomTypeController,
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
                      margin: const EdgeInsets.only(bottom: 65),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: NeutronTextTitle(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TABLEHEADER_IMAGE),
                                  color: ColorUtil.colorBackgroudText,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              if (editRoomTypeController
                                          .listPictureRoom.length <
                                      5 &&
                                  editRoomTypeController.number < 5)
                                InkWell(
                                  onTap: () {
                                    pickImage('');
                                  },
                                  child: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Icon(
                                      Icons.add,
                                      color: ColorUtil.colorBackgroudText,
                                    ),
                                  ),
                                )
                            ],
                          ),
                          SingleChildScrollView(
                            child: SizedBox(
                                child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5,
                                          color: ColorUtil.colorBackgroudText)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: NeutronTextTitle(
                                            textAlign: TextAlign.center,
                                            message: UITitleUtil.getTitleByCode(
                                                UITitleCode.SIDEBAR_STT),
                                            color: ColorUtil.colorBackgroudText,
                                          )),
                                      const VerticalDivider(
                                        color: Colors.black,
                                        thickness: 4,
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: NeutronTextTitle(
                                              textAlign: TextAlign.center,
                                              message:
                                                  UITitleUtil.getTitleByCode(
                                                      UITitleCode
                                                          .SIDEBAR_PICTURE),
                                              color: ColorUtil
                                                  .colorBackgroudText)),
                                      const VerticalDivider(
                                        color: Colors.black,
                                        thickness: 4,
                                      ),
                                      Expanded(
                                          flex: 2,
                                          child: NeutronTextTitle(
                                              textAlign: TextAlign.center,
                                              message: UITitleUtil
                                                  .getTitleByCode(UITitleCode
                                                      .TABLEHEADER_ACTIVITIES),
                                              color:
                                                  ColorUtil.colorBackgroudText))
                                    ],
                                  ),
                                ),
                                ...editRoomTypeController.listPicture.keys
                                    .map((key) => Container(
                                          height: 300,
                                          padding: const EdgeInsets.only(
                                              bottom: 20, top: 20),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 0.5,
                                                  color: Colors.black)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: NeutronTextTitle(
                                                      textAlign:
                                                          TextAlign.center,
                                                      message:
                                                          '${int.parse(key) + 1}',
                                                      color: ColorUtil
                                                          .colorBackgroudText)),
                                              Expanded(
                                                  flex: 3,
                                                  child: editRoomTypeController
                                                              .base64
                                                              .isNotEmpty &&
                                                          editRoomTypeController
                                                              .namePictureRoom
                                                              .contains(key)
                                                      ? Image.memory(
                                                          editRoomTypeController
                                                              .base64[key]!)
                                                      : Image.network(
                                                          editRoomTypeController
                                                                  .listPicture[
                                                              key]!,
                                                          fit: BoxFit.fill,
                                                        )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            pickImage(key);
                                                          },
                                                          child: Icon(
                                                              Icons.edit,
                                                              color: ColorUtil
                                                                  .colorBackgroudText),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: Icon(
                                                              Icons.delete,
                                                              color: ColorUtil
                                                                  .colorBackgroudText),
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: NeutronButton(
                      onPressed: () async {
                        print(roomType!.id!);
                        String? result = await editRoomTypeController
                            .updatePictureRoom(roomType!.id!);
                        if (!context.mounted) {
                          return;
                        }
                        MaterialUtil.showResult(
                            context, MessageUtil.getMessageByCode(result));
                      },
                      icon: Icons.save,
                    ),
                  )
                ],
              );
      }),
    );
  }
}
