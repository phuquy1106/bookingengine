import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class RateRoomType extends StatelessWidget {
  const RateRoomType({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Expanded(
                  flex: 4,
                  child: NeutronTextTitle(
                    message: 'Giá này bao gồm',
                    color: Colors.black,
                  )),
              Expanded(
                  flex: 1,
                  child: NeutronTextTitle(
                    textAlign: TextAlign.center,
                    message: 'Sức chứa',
                    color: Colors.black,
                  )),
              Expanded(
                  flex: 2,
                  child: NeutronTextTitle(
                    textAlign: TextAlign.center,
                    message: 'Giá phòng đêm',
                    color: Colors.black,
                  )),
              Expanded(
                  flex: 2,
                  child: NeutronTextTitle(
                    textAlign: TextAlign.center,
                    message: 'Đặt nhiều nhất',
                    color: Colors.black,
                  )),
              SizedBox(
                width: 20,
              )
            ],
          ),
          Card(
              margin: const EdgeInsets.only(right: 20, top: 10),
              elevation: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Lợi ích',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: FontFamily.aria),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Color(0xff70b138),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Miễn phí hủy trước 24 tháng 7 2024',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: FontFamily.aria,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Color(0xff70b138),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Không phải thanh toán ngay - Chỉ thanh toán\nvào 22 tháng 7 2024',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontFamily.aria),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.check,
                                  color: Color(0xff70b138),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Bãi đậu xe, Thuê xe đạp, Cà phê & trà, Nhận\nphòng nhanh, WiFi miễn phí, Nước uống',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontFamily.aria),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 200,
                    child: VerticalDivider(
                      color: Colors.black12,
                      width: 0.5,
                      indent: 0,
                      endIndent: 0,
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: Icon(
                            Icons.group,
                            color: Colors.black,
                            size: 36,
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: 200,
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
                        child: const Column(
                          children: [],
                        ),
                      )),
                  const SizedBox(
                    height: 200,
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
                            Container(
                              width: 130,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                  color: Color(0xff5392f9),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              child: InkWell(
                                onTap: () {},
                                child: const SizedBox(
                                  height: 30,
                                  child: Center(
                                    child: Text(
                                      'Đặt Phòng',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: FontFamily.aria),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 130,
                              color: const Color(0xfff3f9f2),
                              padding: const EdgeInsets.all(10),
                              child: const Text(
                                '3123123213312321',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xff19541a),
                                    fontFamily: FontFamily.aria),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Chỉ còn lại 5 phòng!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: FontFamily.aria),
                            )
                          ],
                        ),
                      )),
                ],
              ))
        ],
      ),
    );
  }
}
