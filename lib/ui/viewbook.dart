import 'package:bookingengine_frontend/controller/bookingformcontroller.dart';
import 'package:bookingengine_frontend/model/rateroomtypes.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/ui/bookingform.dart';
import 'package:bookingengine_frontend/ui/confirmbooking.dart';
import 'package:bookingengine_frontend/ui/congratulations.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookView extends StatefulWidget {
  const BookView({super.key, this.data, this.roomType, this.rateRoomType});
  final RoomType? roomType;
  final RateRoomTypes? rateRoomType;
  final Map<String, dynamic>? data;
  @override
  State<BookView> createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  BookingFormController? controller;
  final ScrollPhysics scrollPhysics = const ClampingScrollPhysics();
  @override
  void initState() {
    controller = BookingFormController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: controller,
      child: Consumer<BookingFormController>(builder: (_, controller, __) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: controller.index == 0
                ? InkWell(
                    onTap: () async {
                      bool? confirmResult = await MaterialUtil.showConfirm(
                          context, 'Bạn có muốn thoát ra hay không');
                      if (confirmResult == null || !confirmResult) {
                        return;
                      }
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  )
                : null,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                stepsWidget(1, 'form booking', controller),
                const SizedBox(
                  width: 20,
                ),
                stepsWidget(2, 'Xác nhận', controller),
                const SizedBox(
                  width: 20,
                ),
                stepsWidget(3, 'Thanh toán', controller),
                const SizedBox(
                  width: 20,
                ),
                stepsWidget(4, 'form booking', controller),
              ],
            ),
          ),
          body: Center(
            child: IndexedStack(
              index: controller.index,
              children: [
                BookingFormWigget(
                    controller: controller,
                    data: widget.data,
                    rateRoomType: widget.rateRoomType,
                    roomType: widget.roomType),
                ConfirmBooking(
                    controller: controller,
                    data: widget.data!,
                    rateRoomType: widget.rateRoomType,
                    roomType: widget.roomType),
                BookingFormWigget(
                    controller: controller,
                    data: widget.data,
                    rateRoomType: widget.rateRoomType,
                    roomType: widget.roomType),
                const Congratulations()
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget stepsWidget(
      int number, String message, BookingFormController controller) {
    return SizedBox(
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.5, color: const Color(0xff07c54f)),
              color: number > (controller.index! + 1)
                  ? const Color(0xff07c54f)
                  : null,
            ),
            alignment: Alignment.center,
            child: number >= (controller.index! + 1)
                ? Text(
                    '$number',
                    style: TextStyle(
                        color: number <= (controller.index! + 1)
                            ? const Color(0xff07c54f)
                            : Colors.white),
                  )
                : const Icon(
                    Icons.check,
                    color: Color(0xff07c54f),
                  ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            message,
            style: const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
