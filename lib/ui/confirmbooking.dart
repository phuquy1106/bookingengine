import 'dart:convert';

import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/bookingformcontroller.dart';
import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/model/rateroomtypes.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/ui/loading.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/dateutil.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/numberutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ConfirmBooking extends StatefulWidget {
  const ConfirmBooking(
      {super.key,
      required this.data,
      this.controller,
      this.roomType,
      this.pricePerNight,
      this.email,
      this.teNums,
      this.rateRoomType});
  final Map<String, dynamic> data;
  final RoomType? roomType;
  final String? email;
  final BookingFormController? controller;
  final Map<String, Map<String, num>>? teNums;
  final RateRoomTypes? rateRoomType;
  final Map<String, Map<String, List<num>>>? pricePerNight;

  @override
  State<ConfirmBooking> createState() => _ConfirmBookingState();
}

class _ConfirmBookingState extends State<ConfirmBooking> {
  void startPayment() async {
    String paymentUrl =
        'https://us-central1-neutron-pms.cloudfunctions.net/bookingengine-returnPaymentlistener';
    try {
      final response = await http.get(Uri.parse(paymentUrl));
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          // Redirect user to VNPay
          final vnpayUrl = result['url'];
          if (await canLaunch(vnpayUrl)) {
            await launch(vnpayUrl);
          } else {
            throw 'Could not launch $vnpayUrl';
          }
        } else {
          print('${result['message']}');
        }
      } else {
        print('Failed to initiate payment');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 80, right: 80),
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Card(
                elevation: 20,
                child: Container(
                  height: 490,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      border: Border.all(width: 0.5, color: Colors.black12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      NeutronTextTitle(
                        isPadding: false,
                        message: UITitleUtil.getTitleByCode(
                            UITitleCode.TABLEHEADER_BOOKING_DETAIL),
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: Image.network(
                                    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh4.jpg?alt=media&token=a7a232f5-9c67-4278-8418-d4a6a524cc74',
                                  ),
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 5,
                                child: SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.roomType!.name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontFamily: FontFamily.aria),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: NeutronTextContent(
                                                  message:
                                                      '${UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CHECKIN)} :',
                                                  color: ColorUtil
                                                      .colorBackgroudText)),
                                          Expanded(
                                              flex: 4,
                                              child: NeutronTextContent(
                                                  message: '12:00 pm',
                                                  color: ColorUtil
                                                      .colorBackgroudText))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 2,
                                              child: NeutronTextContent(
                                                  message:
                                                      '${UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CHECKOUT)} :',
                                                  color: ColorUtil
                                                      .colorBackgroudText)),
                                          Expanded(
                                              flex: 4,
                                              child: NeutronTextContent(
                                                  message: '12:00 pm',
                                                  color: ColorUtil
                                                      .colorBackgroudText))
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 0.2,
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 2,
                              child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TOOLTIP_CHECKIN),
                                  color: ColorUtil.colorBackgroudText)),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              flex: 2,
                              child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TOOLTIP_CHECKOUT),
                                  color: ColorUtil.colorBackgroudText)),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 2,
                              child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TABLEHEADER_ADULT),
                                  color: ColorUtil.colorBackgroudText)),
                          Expanded(
                              flex: 2,
                              child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TABLEHEADER_CHILD),
                                  color: ColorUtil.colorBackgroudText)),
                          Expanded(
                              flex: 2,
                              child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TOOLTIP_ROOM_NUMBER),
                                  color: ColorUtil.colorBackgroudText)),
                          const Expanded(
                            flex: 2,
                            child: SizedBox(),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.2, color: Colors.black)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '${widget.data['starDay']}, ${DateUtil.dateToDayMonthString(widget.data['inDate'] as DateTime)}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: FontFamily.aria),
                                    )),
                                    const SizedBox(
                                      height: 20,
                                      child: VerticalDivider(
                                        thickness: 0.8,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Text(
                                            '${widget.data['endDay']}, ${DateUtil.dateToDayMonthString(widget.data['outDate'] as DateTime)}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: FontFamily.aria))),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 6,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.2, color: Colors.black)),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      '${widget.data['adult']}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: FontFamily.aria),
                                    )),
                                    const SizedBox(
                                      height: 20,
                                      child: VerticalDivider(
                                        thickness: 0.8,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Text('${widget.data['child']}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: FontFamily.aria))),
                                    const SizedBox(
                                      height: 20,
                                      child: VerticalDivider(
                                        thickness: 0.8,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                        child: Text(
                                            '${widget.data['numberRoom']}',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontFamily: FontFamily.aria))),
                                  ],
                                ),
                              )),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              flex: 2,
                              child: Container(
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xff7edac2)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16))),
                                child: InkWell(
                                  onTap: () {},
                                  child: const Center(
                                    child: Text(
                                      'Update details',
                                      style: TextStyle(
                                          color: Color(0xff7edac2),
                                          fontFamily: FontFamily.aria),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        height: 0.2,
                        color: Colors.black12,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      NeutronTextContent(
                        message: UITitleUtil.getTitleByCode(
                            UITitleCode.ROOM_FACILITIES),
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
                flex: 1,
                child: Card(
                  elevation: 20,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          border:
                              Border.all(width: 0.5, color: Colors.black12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          NeutronTextTitle(
                            isPadding: false,
                            message: UITitleUtil.getTitleByCode(
                                UITitleCode.TABLEHEADER_RESERVATION_SUMMARY),
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 200,
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                border: Border.all(
                                    width: 0.5, color: Colors.black)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //name
                                  conten(
                                      UITitleUtil.getTitleByCode(
                                          UITitleCode.HINT_NAME),
                                      widget.controller?.teName?.text
                                              .toString() ??
                                          ""),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //email
                                  conten(
                                      UITitleUtil.getTitleByCode(
                                          UITitleCode.HINT_EMAIL),
                                      widget.controller?.teEmail?.text
                                              .toString() ??
                                          ""),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //sdt
                                  conten(
                                      UITitleUtil.getTitleByCode(
                                          UITitleCode.HINT_PHONE),
                                      widget.controller?.tePhone?.text
                                              .toString() ??
                                          ""),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //number day
                                  conten(
                                      UITitleUtil.getTitleByCode(UITitleCode
                                          .TOOLTIP_TOTAL_LENGTH_OF_STAY),
                                      '${(widget.data['outDate'] as DateTime).day - (widget.data['inDate'] as DateTime).day}'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //notes
                                  conten(
                                      UITitleUtil.getTitleByCode(
                                          UITitleCode.HINT_NOTES),
                                      widget.controller?.teNotes?.text
                                              .toString() ??
                                          ""),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //checkin
                                  conten(
                                      UITitleUtil.getTitleByCode(
                                          UITitleCode.TOOLTIP_CHECKIN),
                                      DateUtil.dateToDayMonthString(
                                          widget.data['inDate'])),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //checkout
                                  conten(
                                      UITitleUtil.getTitleByCode(
                                          UITitleCode.TOOLTIP_CHECKOUT),
                                      DateUtil.dateToDayMonthString(
                                          widget.data['outDate'])),
                                ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          NeutronTextTitle(
                            isPadding: false,
                            message: UITitleUtil.getTitleByCode(
                                UITitleCode.TABLEHEADER_PRICE_SUMMARY),
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.SIDEBAR_ROOMTYPE),
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                child: NeutronTextContent(
                                  textAlign: TextAlign.right,
                                  message: widget.roomType?.name ?? "",
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TOOLTIP_TOTAL_ROOM),
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                child: NeutronTextContent(
                                  textAlign: TextAlign.right,
                                  message: '${widget.rateRoomType?.rateMax}',
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: NeutronTextContent(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TOOLTIP_TOTAL_PEOPLE),
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Expanded(
                                child: NeutronTextContent(
                                  textAlign: TextAlign.right,
                                  message:
                                      '${widget.data['child'] + widget.data['adult']}',
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: NeutronTextTitle(
                                  isPadding: false,
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TABLEHEADER_PRICE_TOTAL),
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                child: NeutronTextTitle(
                                  textAlign: TextAlign.right,
                                  message: NumberUtil.numberFormat.format(
                                      (widget.rateRoomType!.rateMax! *
                                          widget.data['numberRoom'])),
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Phương thức thanh toán',
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          RadioListTile(
                            value: 'ck',
                            title: const Text(
                              'Chuyển khoản',
                              style: TextStyle(color: Colors.black),
                            ),
                            groupValue: widget.controller!.raidoText,
                            onChanged: (String? value) {
                              setState(() {
                                widget.controller!.raidoText = value!;
                              });
                            },
                          ),
                          RadioListTile(
                            value: 'tm',
                            title: const Text(
                              'Tiền mặt',
                              style: TextStyle(color: Colors.black),
                            ),
                            groupValue: widget.controller!.raidoText,
                            onChanged: (String? value) {
                              setState(() {
                                widget.controller!.raidoText = value!;
                              });
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const LoadingWidget(),
                                      );
                                      Future.delayed(const Duration(seconds: 3))
                                          .then((value) {
                                        Navigator.of(context).pop();
                                        widget.controller?.removeIndex();
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff1ab272),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    child: const Text(
                                      'back',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      String message = '';
                                      if (widget.controller!.raidoText ==
                                          'ck') {
                                        message =
                                            'Bạn muốn thanh toán chuyển khoản!';
                                      } else {
                                        message =
                                            'Bạn muốn thanh toán tại khách sạn!';
                                      }
                                      bool? confirmResult =
                                          await MaterialUtil.showConfirm(
                                              context, message);
                                      if (confirmResult == null ||
                                          !confirmResult) {
                                        return;
                                      }
                                      if (mounted) {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              const LoadingWidget(),
                                        );
                                        String idBooking =
                                            await widget.controller!.addBooking(
                                                (widget.rateRoomType!.rateMax!)
                                                    .toInt(),
                                                widget.data['inDate'],
                                                widget.data['outDate'],
                                                widget.roomType!,
                                                widget.data['adult'],
                                                widget.data['child'],
                                                widget.teNums!,
                                                (widget.data['outDate']
                                                            as DateTime)
                                                        .day -
                                                    (widget.data['inDate']
                                                            as DateTime)
                                                        .day,
                                                widget.pricePerNight!);
                                        if (widget.controller!.raidoText ==
                                            'ck') {
                                          await widget.controller!
                                              .getUrlPaymentVNPay(
                                                  widget.controller!.total,
                                                  idBooking)
                                              .then((result) async {
                                            if (!result
                                                .startsWith('https://')) {
                                              MaterialUtil.showAlert(
                                                  context,
                                                  MessageUtil.getMessageByCode(
                                                      result));
                                              return;
                                            }
                                            print(result);
                                            launchUrlString(result,
                                                mode: LaunchMode
                                                    .externalApplication);
                                            startPayment();
                                          });
                                        }
                                        widget.controller!
                                            .sendEmail(widget.email!);
                                        if (!context.mounted) return;
                                        Navigator.of(context).pop();
                                      }

                                      // if (mounted) {
                                      //   Navigator.of(context).pop();
                                      // }

                                      // if (controller.raidoText == 'ck') {
                                      //   await controller
                                      //       .getUrlPaymentVNPay(
                                      //           widget.rateRoomType!.rateMax! *
                                      //               widget.data['numberRoom'])
                                      //       .then((result) {
                                      //     if (!result.startsWith('https://')) {
                                      //       MaterialUtil.showAlert(
                                      //           context,
                                      //           MessageUtil.getMessageByCode(
                                      //               result));
                                      //       return;
                                      //     }
                                      //     launchUrlString(result,
                                      //         mode: LaunchMode
                                      //             .externalApplication);
                                      //   });
                                      // }
                                      // Future.delayed(Duration(seconds: 3))
                                      //     .then((value) {
                                      //   Navigator.of(context).pop();
                                      // });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff1ab272),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      minimumSize:
                                          const Size(double.infinity, 50),
                                    ),
                                    child: const Text(
                                      'Next',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ))
          ],
        ),
      ),
    );
  }

  Widget conten(String title, String content) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: NeutronTextContent(
              message: '$title :',
              color: Colors.black,
            ),
          ),
          Expanded(
            child: NeutronTextContent(
              tooltip: content,
              message: content,
              softWrap: true,
              color: Colors.black,
            ),
          ),
        ],
      );
}
