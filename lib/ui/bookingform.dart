import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/bookingformcontroller.dart';
import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/model/rateroomtypes.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/ui/loading.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/neutrontextformfield.dart';
import 'package:bookingengine_frontend/util/numberutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../util/dateutil.dart';
import '../validator/stringvalidator.dart';

class BookingFormWigget extends StatefulWidget {
  const BookingFormWigget(
      {super.key,
      this.roomType,
      this.controller,
      this.data,
      this.rateRoomType});
  final RoomType? roomType;
  final BookingFormController? controller;
  final Map<String, dynamic>? data;
  final RateRoomTypes? rateRoomType;
  @override
  State<BookingFormWigget> createState() => _BookingFormWiggetState();
}

class _BookingFormWiggetState extends State<BookingFormWigget> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 80, right: 80),
      child: FormBuilder(
        key: formKey,
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  elevation: 20,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NeutronTextTitle(
                          isPadding: false,
                          message: UITitleUtil.getTitleByCode(
                              UITitleCode.SIDEBAR_TODAY_BOOKINGS),
                          color: ColorUtil.colorBackgroudText,
                          fontSize: 30,
                        ),
                        const SizedBox(height: 50),
                        NeutronTextTitle(
                          isRequired: true,
                          isPadding: false,
                          message: UITitleUtil.getTitleByCode(
                              UITitleCode.TABLEHEADER_NAME),
                          color: ColorUtil.colorBackgroudText,
                        ),
                        const SizedBox(height: SizeManagement.rowSpacing),
                        NeutronTextFormField(
                          isDecor: true,
                          controller: widget.controller?.teName,
                          // readOnly: !HO.booking.isNameEditable(),
                          validator: (value) => value!.isEmpty
                              ? MessageUtil.getMessageByCode(
                                  MessageCodeUtil.INPUT_NAME)
                              : null,
                          backgroundColor: ColorUtil.colorBackgroudMain,
                          textColor: ColorUtil.colorBackgroudText,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        NeutronTextTitle(
                          isPadding: false,
                          isRequired: true,
                          message: UITitleUtil.getTitleByCode(
                              UITitleCode.TABLEHEADER_EMAIL),
                          color: ColorUtil.colorBackgroudText,
                        ),
                        const SizedBox(height: SizeManagement.rowSpacing),
                        NeutronTextFormField(
                          isDecor: true,
                          controller: widget.controller?.teEmail,
                          labelRequired: true,
                          validator: (value) =>
                              StringValidator.validateRequiredEmail(value),
                          backgroundColor: ColorUtil.colorBackgroudMain,
                          textColor: ColorUtil.colorBackgroudText,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        NeutronTextTitle(
                          isPadding: false,
                          message: UITitleUtil.getTitleByCode(
                              UITitleCode.TABLEHEADER_PHONE),
                          color: ColorUtil.colorBackgroudText,
                        ),
                        const SizedBox(
                            height: SizeManagement.cardInsideHorizontalPadding),
                        NeutronTextFormField(
                          isDecor: true,
                          isPhoneNumber: true,
                          controller: widget.controller?.tePhone,
                          // readOnly: !controller.booking.isPhoneEmailEditable(),
                          validator: (value) =>
                              StringValidator.validatePhone(value!),
                          backgroundColor: ColorUtil.colorBackgroudMain,
                          textColor: ColorUtil.colorBackgroudText,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        NeutronTextTitle(
                          isPadding: false,
                          message: UITitleUtil.getTitleByCode(
                              UITitleCode.HEADER_NOTES),
                          color: ColorUtil.colorBackgroudText,
                        ),
                        const SizedBox(height: SizeManagement.rowSpacing),
                        NeutronTextFormField(
                          paddingVertical: 16,
                          isDecor: true,
                          maxLine: 4,
                          controller: widget.controller?.teNotes,
                          textColor: ColorUtil.colorBackgroudText,
                          backgroundColor: ColorUtil.colorBackgroudMain,
                        ),
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              NeutronTextContent(
                                message:
                                    '${widget.data!['starDay']}, ${DateUtil.dateToDayMonthString(widget.data?['inDate'] as DateTime)} - ${widget.data!['endDay']}, ${DateUtil.dateToDayMonthString(widget.data!['outDate'] as DateTime)}  ${(widget.data!['outDate'] as DateTime).day - (widget.data!['inDate'] as DateTime).day} Đêm',
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              NeutronTextContent(
                                  color: Colors.black,
                                  message:
                                      '${widget.roomType?.name} x ${widget.data!['numberRoom']} phòng'),
                              const SizedBox(
                                height: 10,
                              ),
                              const Divider(
                                height: 0.5,
                                color: Colors.black12,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Image.network(
                                          'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b')),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10, bottom: 10),
                                        child: Column(
                                          children: [
                                            iconRoom(
                                                'dsadsadsadsadsadsadsadsssssssssssssssssssssssssssssssssssssssss',
                                                Icons.check),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            iconRoom(
                                                'dsadsadsadsadsadsadsadsssssssssssssssssssssssssssssssssssssssss',
                                                Icons.check),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            iconRoom(
                                                'dsadsadsadsadsadsadsadsssssssssssssssssssssssssssssssssssssssss',
                                                Icons.check),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            iconRoom(
                                                'dsadsadsadsadsadsadsadsssssssssssssssssssssssssssssssssssssssss',
                                                Icons.check),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            iconRoom(
                                                'dsadsadsadsadsadsadsadsssssssssssssssssssssssssssssssssssssssss',
                                                Icons.check),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            iconRoom(
                                                'dsadsadsadsadsadsadsadsssssssssssssssssssssssssssssssssssssssss',
                                                Icons.check),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 10,
                              height: 60,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              'Chỉ còn lại ${widget.data!['listNumberRoom'][widget.roomType!.id]} phòng!',
                              style: const TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Card(
                        elevation: 20,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    const Expanded(
                                      child: NeutronTextContent(
                                        message: 'Total',
                                        color: Colors.black,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: NeutronTextContent(
                                          message: NumberUtil.numberFormat
                                              .format((widget
                                                      .rateRoomType!.rateMax! *
                                                  widget.data!['numberRoom'])),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 400,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          showDialog(
                                            context: context,
                                            builder: (context) =>
                                                const LoadingWidget(),
                                          );
                                          Future.delayed(Duration(seconds: 3))
                                              .then((value) {
                                            Navigator.of(context).pop();
                                            widget.controller?.setIndex();
                                          });
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xff08c44f),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        fixedSize: const Size(300, 30),
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
                              ),
                            ]),
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget iconRoom(String message, IconData iconData) {
  return Row(
    children: [
      Icon(
        iconData,
        color: const Color(0xff70b138),
      ),
      const SizedBox(
        width: 5,
      ),
      SizedBox(
        width: 230,
        child: Text(
          message,
          softWrap: true,
          style:
              const TextStyle(color: Colors.black, fontFamily: FontFamily.aria),
        ),
      ),
    ],
  );
}
