import 'package:bookingengine_frontend/constants.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/cancelbookingcontroller.dart';
import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/ui/loaddata.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/numberutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelBooking extends StatefulWidget {
  const CancelBooking({super.key, this.controller, this.idPayment});
  final CancelBookingController? controller;
  final String? idPayment;
  @override
  State<CancelBooking> createState() => _CancelBookingState();
}

class _CancelBookingState extends State<CancelBooking> {
  @override
  Widget build(BuildContext context) {
    print('--------------${widget.controller?.booking?.id}');
    return ChangeNotifierProvider.value(
      value: widget.controller,
      child: Consumer<CancelBookingController>(builder: (_, controller, __) {
        return controller.booking?.status != 0
            ? Container(
                color: Colors.white,
                child: const Center(
                  child: Text(
                    'Booking đã được huỷ!',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              )
            : controller.isLoad!
                ? Container(
                    height: kMobileWidth,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                        color: ColorManagement.greenColor),
                  )
                : Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(
                            top: 20, right: 200, left: 200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              child: NeutronTextTitle(
                                message: UITitleUtil.getTitleByCode(
                                    UITitleCode.SIDEBAR_TODAY_BOOKINGS),
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                NeutronTextTitle(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.HINT_NAME),
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const NeutronTextContent(
                                  message: 'nguyen van a',
                                  color: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                NeutronTextTitle(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.HINT_NAME),
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const NeutronTextContent(
                                  message: 'a@gmail.com',
                                  color: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                NeutronTextTitle(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TOOLTIP_CHECKIN),
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const NeutronTextContent(
                                  message: 'thứ 3, ngày 20/01/2024',
                                  color: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                NeutronTextTitle(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TOOLTIP_CHECKOUT),
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const NeutronTextContent(
                                  message: 'thứ 4, ngày 21/01/2024',
                                  color: Colors.black,
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            information(),
                            const SizedBox(
                              height: 10,
                            ),
                            mainCard(
                                controller, context, widget.idPayment ?? "")
                          ],
                        ),
                      ),
                    ),
                  );
      }),
    );
  }
}

Widget mainCard(CancelBookingController controller, BuildContext context,
    String idPayment) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const NeutronTextContent(
          message: 'phòng 1',
          color: Colors.black,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
                child: NeutronTextTitle(
              message: 'hạng phòng',
              color: Colors.black,
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 4,
                child: Row(
                  children: [
                    const Expanded(
                        child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      message: 'Tên phòng',
                      color: Colors.black,
                    )),
                    const Expanded(
                        child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      message: 'Giá phòng đêm',
                      color: Colors.black,
                    )),
                    const Expanded(
                        child: NeutronTextTitle(
                      textAlign: TextAlign.center,
                      message: 'Số phòng',
                      color: Colors.black,
                    )),
                    Expanded(flex: 1, child: Container()),
                  ],
                ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: SizedBox(
              height: 120,
              child: Image.network(
                'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh1.jpg?alt=media&token=932859eb-ec17-434e-b933-4ef3089c9cee',
                fit: BoxFit.cover,
              ),
            )),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                flex: 4,
                child: controller.booking?.subbooking == null
                    ? roomMain(
                        controller.booking!.room!,
                        controller.booking!.price!.first,
                        1,
                        controller.booking!.id!,
                        false,
                        controller.booking!.sID!,
                        controller,
                        context,
                        idPayment)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            ...controller.booking!.subbooking!
                                .where((sub) => sub.status == 0)
                                .map((e) => roomMain(
                                    e.roomTpye!,
                                    e.price?.first,
                                    1,
                                    e.id!,
                                    true,
                                    controller.booking!.sID!,
                                    controller,
                                    context,
                                    idPayment))
                                .toList(),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 160,
                                margin: const EdgeInsets.only(
                                    top: 10, bottom: 10, left: 30, right: 30),
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    color: Color(0xff5392f9),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: InkWell(
                                  onTap: () async {
                                    String result = '';
                                    await controller.cancelGroup(
                                        controller.booking!.sID!, idPayment);
                                    if (!context.mounted) return;
                                    if (result == MessageCodeUtil.SUCCESS) {
                                      MaterialUtil.showSnackBar(
                                          context,
                                          MessageUtil.getMessageByCode(
                                              MessageCodeUtil.SUCCESS));
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => LoadData(
                                              idBooking:
                                                  controller.booking!.sID!),
                                        ),
                                      );
                                    } else {
                                      MaterialUtil.showAlert(context,
                                          MessageUtil.getMessageByCode(result));
                                    }
                                  },
                                  child: const SizedBox(
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        'Cancel All Booking',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontFamily: FontFamily.aria),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]))
          ],
        )
      ],
    ),
  );
}

Widget roomMain(
    String name,
    num price,
    num number,
    String id,
    bool isGroup,
    String sId,
    CancelBookingController controller,
    BuildContext context,
    idPayment) {
  return Card(
    elevation: 20,
    child: Row(
      children: [
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              name,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: FontFamily.aria),
            ),
          ]),
        )),
        const SizedBox(
          height: 50,
          child: VerticalDivider(
            color: Colors.black12,
            width: 0.5,
            indent: 0,
            endIndent: 0,
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    NumberUtil.numberFormat.format(price),
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.aria),
                  )
                ],
              ),
            )),
        const SizedBox(
          height: 50,
          child: VerticalDivider(
            color: Colors.black12,
            width: 0.5,
            indent: 0,
            endIndent: 0,
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.all(10),
          child: const Center(
              child: Text(
            '1',
            style: TextStyle(color: Colors.black),
          )),
        )),
        const SizedBox(
          height: 50,
          child: VerticalDivider(
            color: Colors.black12,
            width: 0.5,
            indent: 0,
            endIndent: 0,
          ),
        ),
        Expanded(
            child: Container(
          width: 80,
          margin:
              const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              color: Color(0xff5392f9),
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: InkWell(
            onTap: () async {
              String result =
                  await controller.cancel(id, isGroup, sId, idPayment);
              if (!context.mounted) return;
              if (result == MessageCodeUtil.SUCCESS) {
                MaterialUtil.showSnackBar(context,
                    MessageUtil.getMessageByCode(MessageCodeUtil.SUCCESS));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LoadData(idBooking: isGroup ? sId : id),
                  ),
                );
              } else {
                MaterialUtil.showAlert(
                    context, MessageUtil.getMessageByCode(result));
              }
            },
            child: const SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: FontFamily.aria),
                ),
              ),
            ),
          ),
        )),
      ],
    ),
  );
}

Widget information() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CHECKIN),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CHECKOUT),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message:
                  UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_TOTAL_ROOM),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(UITitleCode.ROOM_CHARGE),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(
                  UITitleCode.TABLEHEADER_METHOD_PAYMENT),
              color: Colors.black,
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CHECKIN),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CHECKOUT),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message:
                  UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_TOTAL_ROOM),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(UITitleCode.ROOM_CHARGE),
              color: Colors.black,
            )),
            Expanded(
                child: NeutronTextContent(
              message: UITitleUtil.getTitleByCode(
                  UITitleCode.TABLEHEADER_METHOD_PAYMENT),
              color: Colors.black,
            )),
          ],
        )
      ],
    ),
  );
}
