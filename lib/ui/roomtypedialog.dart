import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/ui/editroomtypedialog.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/numberutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';

class RoomTypeDialog extends StatelessWidget {
  const RoomTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Scaffold(
        backgroundColor: ColorUtil.colorBackgroudMain,
        appBar: AppBar(
          title: NeutronTextContent(
            message: UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_ROOMTYPE),
            color: ColorUtil.colorBackgroudText,
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorUtil.colorBackgroudText,
            ),
          ),
          backgroundColor: ColorUtil.colorBackgroudMain,
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
              child: Row(
                children: [
                  Expanded(
                    child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      isPadding: false,
                      message: UITitleUtil.getTitleByCode(
                          UITitleCode.TABLEHEADER_R_TYPE_ID),
                      color: ColorUtil.colorBackgroudText,
                    ),
                  ),
                  Expanded(
                    child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      isPadding: false,
                      message: UITitleUtil.getTitleByCode(
                          UITitleCode.TABLEHEADER_NAME),
                      color: ColorUtil.colorBackgroudText,
                    ),
                  ),
                  Expanded(
                    child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      isPadding: false,
                      message: UITitleUtil.getTitleByCode(
                          UITitleCode.TABLEHEADER_ADULT),
                      color: ColorUtil.colorBackgroudText,
                    ),
                  ),
                  Expanded(
                    child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      isPadding: false,
                      message: UITitleUtil.getTitleByCode(
                          UITitleCode.TABLEHEADER_CHILD),
                      color: ColorUtil.colorBackgroudText,
                    ),
                  ),
                  Expanded(
                    child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      message: UITitleUtil.getTitleByCode(
                          UITitleCode.TABLEHEADER_PRICE),
                      color: ColorUtil.colorBackgroudText,
                    ),
                  ),
                  //size of trailing of expansionTile
                  Expanded(
                    child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      isPadding: false,
                      message: UITitleUtil.getTitleByCode(
                          UITitleCode.TABLEHEADER_ACTIVITIES),
                      color: ColorUtil.colorBackgroudText,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, right: 20, bottom: 20),
              child: Column(
                children: GeneralManager.listRoomTypes
                    .map(
                      (roomtype) => Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Expanded(
                                child: NeutronTextContent(
                              textAlign: TextAlign.center,
                              message: roomtype.id!,
                              color: ColorUtil.colorBackgroudText,
                            )),
                            Expanded(
                                child: NeutronTextContent(
                              textAlign: TextAlign.center,
                              tooltip: roomtype.name,
                              message: roomtype.name!,
                              color: ColorUtil.colorBackgroudText,
                            )),
                            Expanded(
                                child: NeutronTextContent(
                              textAlign: TextAlign.center,
                              message: '${roomtype.adult}',
                              color: ColorUtil.colorBackgroudText,
                            )),
                            Expanded(
                                child: NeutronTextContent(
                              textAlign: TextAlign.center,
                              message: '${roomtype.child}',
                              color: ColorUtil.colorBackgroudText,
                            )),
                            Expanded(
                                child: NeutronTextContent(
                              message: NumberUtil.numberFormat
                                  .format(roomtype.price),
                              color: ColorUtil.colorBackgroudText,
                              textAlign: TextAlign.center,
                            )),
                            Expanded(
                              child: IconButton(
                                constraints: const BoxConstraints(
                                    minWidth: 40, maxWidth: 40),
                                tooltip: UITitleUtil.getTitleByCode(
                                    UITitleCode.TOOLTIP_EDIT_PICTURE),
                                icon: Icon(
                                  Icons.edit,
                                  color: ColorUtil.colorBackgroudText,
                                ),
                                onPressed: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (ctx) => EditPictureRoomDialog(
                                            roomType: roomtype,
                                          ));
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
