import 'package:bookingengine_frontend/controller/cancelbookingcontroller.dart';
import 'package:bookingengine_frontend/ui/cancelbooking.dart';
import 'package:flutter/material.dart';

class LoadData extends StatefulWidget {
  const LoadData({super.key, required this.idBooking, this.idPayment});
  final String idBooking;
  final String? idPayment;
  @override
  State<LoadData> createState() => _LoadDataState();
}

class _LoadDataState extends State<LoadData> {
  CancelBookingController controller = CancelBookingController();
  @override
  void initState() {
    loadData(context);
    super.initState();
  }

  Future<void> loadData(BuildContext context) async {
    try {
      await controller.getRoomTypes(widget.idBooking);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => CancelBooking(
                  controller: controller,
                  idPayment: widget.idPayment,
                )),
      );
    } catch (e) {
      print("Lỗi khi tải dữ liệu: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xff08c44f),
        ),
      ),
    );
  }
}
