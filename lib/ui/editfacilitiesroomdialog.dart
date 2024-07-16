import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/editfacilitiescontroller.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class EditFacilitiesRoomDialog extends StatefulWidget {
  const EditFacilitiesRoomDialog({super.key, this.roomType});
  final RoomType? roomType;
  @override
  State<EditFacilitiesRoomDialog> createState() =>
      _EditFacilitiesRoomDialogState();
}

class _EditFacilitiesRoomDialogState extends State<EditFacilitiesRoomDialog> {
  late EditFacilitiesRoomController editFacilitiesRoomController;
  @override
  void initState() {
    editFacilitiesRoomController = EditFacilitiesRoomController(
        listFacilitiesRoom: widget.roomType!.facilitesRoom);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: ChangeNotifierProvider.value(
      value: editFacilitiesRoomController,
      child: Consumer<EditFacilitiesRoomController>(
          builder: (_, editFacilitiesRoomController, __) {
        return editFacilitiesRoomController.isLoading
            ? Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                    color: ColorManagement.greenColor),
              )
            : SingleChildScrollView(
                child: Stack(
                children: [
                  Column(children: [
                    const SizedBox(
                      height: 20,
                    ),
                    NeutronTextTitle(
                      message: UITitleUtil.getTitleByCode(
                          UITitleCode.ROOM_FACILITIES),
                      color: ColorUtil.colorBackgroudText,
                      fontSize: 36,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SingleChildScrollView(
                        child: SizedBox(
                      height: 400,
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                        children: GeneralManager.listFacilitiesRoom.keys
                            .map((key) => CheckboxListTile(
                                  value: widget.roomType!.facilitesRoom!
                                      .contains(key),
                                  onChanged: (value) {
                                    setState(() {
                                      editFacilitiesRoomController
                                          .setFacilities(key, value!);
                                    });
                                  },
                                  title: SizedBox(
                                    child: Row(children: [
                                      Expanded(
                                          flex: 1,
                                          child: SvgPicture.asset(
                                            GeneralManager
                                                .listFacilitiesRoom[key]!,
                                            height: 36,
                                          )),
                                      Expanded(
                                        flex: 3,
                                        child: NeutronTextContent(
                                          message:
                                              UITitleUtil.getTitleByCode(key),
                                          color: ColorUtil.colorBackgroudText,
                                        ),
                                      )
                                    ]),
                                  ),
                                ))
                            .toList(),
                      ),
                    )),
                    const SizedBox(
                      height: 30,
                    )
                  ]),
                  Positioned(
                      bottom: -10,
                      left: -10,
                      right: -10,
                      child: NeutronButton(
                        onPressed: () async {
                          String? result = await editFacilitiesRoomController
                              .updateFacilitiesRoom(widget.roomType!.id!);
                          if (!mounted) {
                            return;
                          }
                          MaterialUtil.showResult(
                              context, MessageUtil.getMessageByCode(result));
                        },
                        icon: Icons.save,
                      ))
                ],
              ));
      }),
    ));
  }
}
