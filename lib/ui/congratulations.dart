import 'package:bookingengine_frontend/ui/home.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Congratulations extends StatefulWidget {
  const Congratulations({super.key});

  @override
  State<Congratulations> createState() => _CongratulationsState();
}

class _CongratulationsState extends State<Congratulations> {
  bool check = true;
  @override
  void initState() {
    if (mounted) {
      Future.delayed(const Duration(seconds: 20)).then((value) {
        check = false;
        setState(() {
          return;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 80, right: 80),
      child: Column(
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Lottie.asset('assets/animation/congratulations.json',
                animate: check, fit: BoxFit.fill),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Chúc mừng bạn đặt phòng thành công!',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text('Bạn sẽ nhận được email sớm nhất',
              style: TextStyle(color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 120,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeWidget()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1ab272),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Center(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        UITitleUtil.getTitleByCode(UITitleCode.HOME),
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
