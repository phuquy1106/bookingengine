import 'dart:async';

import 'package:bookingengine_frontend/contals/neutrondropdown.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/homecontroller.dart';
import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/rateroomtypes.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/ui/home.dart';
import 'package:bookingengine_frontend/ui/imgslidedialog.dart';
import 'package:bookingengine_frontend/ui/loading.dart';
import 'package:bookingengine_frontend/ui/viewbook.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';

import '../util/uimultilanguageutil.dart';

class UiRoom extends StatefulWidget {
  const UiRoom(
      {super.key, this.roomType, this.number, this.data, this.homeController});
  final RoomType? roomType;
  final int? number;
  final Map<String, dynamic>? data;
  final HomeController? homeController;
  @override
  State<UiRoom> createState() => _UiRoomState();
}

bool checkImg = false;
bool checkFacilities = false;
String urlImg = '';

class _UiRoomState extends State<UiRoom> {
  String displayText =
      "KHÔNG SỢ RỦI RO\nHủy không tốn phí"; // Biến để lưu chuỗi hiển thị
  Timer? timer;
  int currentIndex = 0;
  List<String> texts = [
    "KHÔNG SỢ RỦI RO\nHủy không tốn phí",
    "Không thanh toán hôm nay",
  ]; // Danh sách các chuỗi

  @override
  void initState() {
    super.initState();
    _loadData();
    startTextChange();
  }

  Future<void> _loadData() async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          // Update your state here
          // homeController.addListPrictureRoom(widget.roomType!.id!);
          widget.homeController!
              .setNumberRoom(widget.number!, widget.roomType!.id!);
          widget.homeController!
              .setNumberRateRoom(widget.roomType?.listRateRoomTypes);
        });
      });
    }
  }

  final GlobalKey key1 = GlobalKey();
  void startTextChange() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      currentIndex = (currentIndex + 1) % texts.length;
      if (mounted) {
        setState(() {
          displayText = texts[currentIndex];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black12),
                  color: const Color(0xfff7f7f7)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeWidget(
                                      roomType: widget.roomType,
                                    )));
                      },
                      child: NeutronTextContent(
                        message: widget.roomType!.name!,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: NeutronTextTitle(
                            message: 'loại phòng',
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 5,
                        child: Row(
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
                                flex: 1,
                                child: NeutronTextTitle(
                                  textAlign: TextAlign.center,
                                  message: 'Số phòng',
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
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 120,
                                    child: StaggeredGrid.count(
                                        crossAxisCount: 4,
                                        mainAxisSpacing: 4,
                                        crossAxisSpacing: 2,
                                        children: [
                                          ...widget
                                              .homeController!
                                              .listPrictureRoom[
                                                  widget.roomType!.id]!
                                              .keys
                                              .take(3)
                                              .map(
                                                (key) =>
                                                    StaggeredGridTile.count(
                                                  crossAxisCellCount:
                                                      key == '0' ? 4 : 2,
                                                  mainAxisCellCount: 1,
                                                  child: ClipRRect(
                                                    child: MouseRegion(
                                                      onEnter: (event) {
                                                        setState(() {
                                                          checkImg = true;
                                                          urlImg = widget
                                                                  .homeController!
                                                                  .listPrictureRoom[
                                                              widget.roomType!
                                                                  .id]![key]!;
                                                        });
                                                      },
                                                      onExit: (event) {
                                                        setState(() {
                                                          checkImg = false;
                                                        });
                                                      },
                                                      child: Image.network(
                                                        widget.homeController!
                                                                .listPrictureRoom[
                                                            widget.roomType!
                                                                .id]![key]!,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                        ]),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            const ImgSlideDialog(),
                                      );
                                    },
                                    child: const Text(
                                      'Xem ảnh và chi tiết',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ...GeneralManager.listFacilitiesRoom.keys
                                      .take(5)
                                      .where((element) => widget
                                          .roomType!.facilitesRoom!
                                          .contains(element))
                                      .map(
                                        (e) => iconFacilities(
                                            GeneralManager
                                                .listFacilitiesRoom[e],
                                            UITitleUtil.getTitleByCode(e)),
                                      )
                                      .toList(),
                                  if (widget.roomType!.facilitesRoom!.length >
                                      5)
                                    MouseRegion(
                                      onEnter: (event) {
                                        setState(() {
                                          checkFacilities = true;
                                        });
                                      },
                                      onExit: (event) {
                                        setState(() {
                                          checkFacilities = false;
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: const Color(
                                                        0xff54a9e7))),
                                            child: const Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Color(0xff54a9e7),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            'Các tiện ích khác',
                                            style: TextStyle(
                                                color: Color(0xff54a9e7),
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    )
                                ],
                              ))),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          flex: 5,
                          child: Column(
                            children: widget.roomType!.listRateRoomTypes!
                                .map((e) => contentMain(
                                    widget.homeController!,
                                    displayText,
                                    widget.number!,
                                    context,
                                    e,
                                    widget.data ?? {},
                                    widget.roomType!))
                                .toList(),
                            // contentMain(displayText),
                            // contentMain(displayText),
                            // contentMain(displayText),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                          )),
                    ],
                  ),
                ],
              ),
            ),
            if (checkImg) positione(urlImg),
            if (checkFacilities)
              Positioned(
                  left: 220,
                  top: 120,
                  child: Card(
                    elevation: 20,
                    color: Colors.white,
                    child: Container(
                      height: 500,
                      width: 700,
                      padding: const EdgeInsets.all(10),
                      child: GridView.count(
                          crossAxisCount: 3,
                          childAspectRatio: 3,
                          mainAxisSpacing: 10,
                          children: GeneralManager.listFacilitiesRoom.keys
                              .where((element) => widget
                                  .roomType!.facilitesRoom!
                                  .contains(element))
                              .map(
                                (e) => iconFacilities(
                                    GeneralManager.listFacilitiesRoom[e],
                                    UITitleUtil.getTitleByCode(e)),
                              )
                              .toList()),
                    ),
                  ))
          ],
        ),
      ),
    );
  }
}

Widget positione(String img) => Positioned(
    left: 220,
    top: 40,
    child: SizedBox(
      height: 200,
      width: 400,
      child: Image.network(
        img,
        fit: BoxFit.cover,
      ),
    ));

Widget contentMain(
        HomeController controller,
        String displaytest,
        int number,
        BuildContext context,
        RateRoomTypes rateRoomType,
        Map<String, dynamic> data,
        RoomType roomType) =>
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
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: NeutronDropDown(
                        onChanged: (value) => controller.setRoom(
                            value,
                            roomType.id!,
                            rateRoomType.id!,
                            number,
                            rateRoomType.rateMax!),
                        value: controller.numberR[rateRoomType.id] ?? '0',
                        items: controller.listRoom[roomType.id] ?? ['0']),
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
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const LoadingWidget(),
                            );
                            Future.delayed(const Duration(seconds: 3))
                                .then((value) {
                              Navigator.of(context).pop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BookView(
                                          data: data,
                                          roomType: roomType,
                                          teNums: controller.teNums,
                                          pricePerNight:
                                              controller.pricePerNight,
                                          rateRoomType: rateRoomType,
                                        )),
                              );
                            });
                          },
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
                        child: Text(
                          displaytest,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Color(0xff19541a),
                              fontFamily: FontFamily.aria),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Chỉ còn lại $number phòng!',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.red, fontFamily: FontFamily.aria),
                      )
                    ],
                  ),
                )),
          ],
        ));
Widget iconFacilities(String? icon, String test) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            icon!,
            height: 36,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            test,
            style: const TextStyle(
                color: Colors.black, fontSize: 12, fontFamily: FontFamily.aria),
          )
        ],
      ),
    );
