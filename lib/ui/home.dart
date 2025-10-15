// ignore_for_file: use_build_context_synchronously

import 'dart:ui';

import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/homecontroller.dart';
import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/ui/htmleditdialog.dart';
import 'package:bookingengine_frontend/ui/login.dart';
import 'package:bookingengine_frontend/ui/hotelfacilities.dart';
import 'package:bookingengine_frontend/ui/rateroomtype.dart';
import 'package:bookingengine_frontend/ui/uiroom.dart';
// import 'package:bookingengine_frontend/ui/uiroom.dart';
import 'package:bookingengine_frontend/ui/userdrawer.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
// import 'package:bookingengine_frontend/util/neutrondatetimepicker.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/numberutil.dart';
import 'package:bookingengine_frontend/util/responsiveutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:readmore/readmore.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key, this.roomType});
  final RoomType? roomType;

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late Stream<User?> stream;
  DateRangePickerController controllerD = DateRangePickerController();
  PickerDateRange? selectedRange;
  HomeController? homeController;
  bool check = false;
  bool checkInformation = false;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    homeController = HomeController();
    stream = FirebaseAuth.instance.authStateChanges();
    // if (widget.roomType != null) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     setState(() {
    //       homeController!.addListPrictureRoom(widget.roomType!.id!);
    //     });
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtil.isMobile(context);

    return StreamBuilder<User?>(
        stream: stream,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData && !snapshot.data!.isAnonymous) {
            return home(context, isMobile);
          }
          return home(context, isMobile);
        });
  }

  Widget home(BuildContext context, bool isMobile) {
    num height = (MediaQuery.of(context).size.width) * 0.52;
    num width = (MediaQuery.of(context).size.width);
    return ChangeNotifierProvider.value(
      value: homeController,
      child: Consumer<HomeController>(
        builder: (_, controller, __) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: ColorUtil.colorBackgroudMain,
              drawer: const UserDrawer(),
              appBar: AppBar(
                toolbarHeight: 80,
                leading: FirebaseAuth.instance.currentUser?.uid != null
                    ? Builder(
                        builder: (context) {
                          return IconButton(
                            icon: const Icon(Icons.menu, color: Colors.white),
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          );
                        },
                      )
                    : null,
                backgroundColor: const Color(0xff20274d),
                elevation: 0.0,
                centerTitle: true,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 450,
                      height: 50,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: Row(children: [
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            setState(() {
                              checkInformation = false;
                              check = !check;
                            });
                          },
                          child: Row(children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeController?.inDate != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(homeController!.inDate!)
                                      : MessageUtil.getMessageByCode(
                                          MessageCodeUtil.NO_DATA),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.aria,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  homeController!.startDay,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: FontFamily.aria),
                                )
                              ],
                            )
                          ]),
                        )),
                        const SizedBox(
                          height: 40,
                          child: VerticalDivider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                            setState(() {
                              checkInformation = false;
                              check = !check;
                            });
                          },
                          child: Row(children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 20,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  homeController?.outDate != null
                                      ? DateFormat('dd/MM/yyyy')
                                          .format(homeController!.outDate!)
                                      : MessageUtil.getMessageByCode(
                                          MessageCodeUtil.NO_DATA),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.aria,
                                      fontSize: 14),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  homeController!.endDay,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontFamily.aria,
                                      fontSize: 12),
                                )
                              ],
                            )
                          ]),
                        )),
                      ]),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 200,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: SizedBox(
                        height: 38,
                        child: InkWell(
                            onTap: () {
                              setState(() {
                                check = false;
                                checkInformation = !checkInformation;
                              });
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${homeController!.teAdult!.getNumber()} ${UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_ADULT)}, ${homeController!.teChild!.getNumber()} ${UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_CHILD)}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: FontFamily.aria,
                                          fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${homeController!.teNumberRoom!.getNumber()} ${UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_ROOM)}',
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontFamily: FontFamily.aria,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: const Color(0xff5392f9),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: InkWell(
                        onTap: () async {
                          check = false;
                          checkInformation = false;
                          showDialog(
                              context: context,
                              builder: (context) => loadingWidget(),
                              barrierDismissible: false);
                          String result = await homeController!.search();
                          Navigator.pop(context);
                          if (!context.mounted) return;
                          if (result == MessageCodeUtil.SUCCESS) {
                            controller.scrollToUiRoom();
                            return;
                          }
                          MaterialUtil.showAlert(context, result);
                          return;
                        },
                        child: SizedBox(
                          height: 30,
                          child: Center(
                            child: Text(
                              UITitleUtil.getTitleByCode(
                                  UITitleCode.TOOLTIP_SEARCH),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: FontFamily.aria,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                actions: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.languageLocacl,
                      icon: const Icon(Icons.arrow_drop_down),
                      dropdownColor: const Color(0xff20274d),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: FontFamily.aria),
                      onChanged: (String? newValue) {
                        setState(() {
                          controller.setLanguage(newValue!);
                        });
                      },
                      items: <String>['en', 'vi']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontFamily: FontFamily.aria),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      FirebaseAuth.instance.currentUser?.uid != null
                          ? await GeneralManager.signOut()
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return const LoginWidget();
                              },
                            );
                    },
                    icon: FirebaseAuth.instance.currentUser?.uid != null
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  if (widget.roomType != null)
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.home,
                        color: ColorUtil.colorAppBarText,
                      ),
                    ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
              body: Stack(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: body(
                              height.toDouble(),
                              width.toDouble(),
                              isMobile,
                              homeController!,
                              controller.scrollController,
                              context))
                    ],
                  ),
                  if (checkInformation || check)
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(color: Colors.black.withOpacity(0)),
                    ),
                  Positioned(
                      bottom: 20,
                      right: 60,
                      child: Card(
                        color: Colors.transparent,
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: InkWell(
                            onTap: () => homeController?.scrollToTop(),
                            child: Icon(
                              Icons.keyboard_double_arrow_up,
                              color: Colors.black,
                              size: 26,
                            ),
                          ),
                        ),
                      )),
                  if (check)
                    Positioned(
                      top: 0,
                      left: 320,
                      child: Card(
                        elevation: 50,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.white, // Màu của border
                            width: 2.0, // Độ rộng của border
                          ),
                        ),
                        child: SizedBox(
                          width: 800,
                          height: 400,
                          child: SfDateRangePicker(
                            controller: controllerD,
                            view: DateRangePickerView.month,
                            initialDisplayDate: DateTime.now(),
                            minDate: DateTime.now(),
                            showActionButtons: true,
                            selectionMode: DateRangePickerSelectionMode.range,
                            enableMultiView: true,
                            rangeSelectionColor: const Color(0xffa6c6fd),
                            startRangeSelectionColor: const Color(0xff5392f9),
                            endRangeSelectionColor: const Color(0xff5392f9),
                            monthViewSettings:
                                const DateRangePickerMonthViewSettings(
                                    firstDayOfWeek: 4),
                            onCancel: () {
                              // setState(() {
                              //   check = false;
                              // });
                              controller.setInDate(null);
                              controller.setOutDate(null);
                            },
                            onSubmit: (p0) {
                              setState(() {
                                check = false;
                              });
                            },
                            onSelectionChanged: (data) {
                              selectedRange = data.value;
                              if (selectedRange != null) {
                                final startDate = selectedRange!.startDate;
                                final endDate = selectedRange!.endDate ??
                                    selectedRange!.startDate;

                                controller.setInDate(startDate!);
                                controller.setOutDate(endDate!);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  if (checkInformation)
                    Positioned(
                      top: 0,
                      right: 470,
                      child: Card(
                        elevation: 50,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(
                            color: Colors.white, // Màu của border
                            width: 2.0, // Độ rộng của border
                          ),
                        ),
                        child: SizedBox(
                          width: 280,
                          height: 270,
                          child: Column(
                            children: [
                              containerInformation(
                                  UITitleCode.SIDEBAR_ROOM,
                                  homeController!,
                                  homeController!.teNumberRoom!.getRawString()),
                              containerInformation(
                                  UITitleCode.TABLEHEADER_ADULT,
                                  homeController!,
                                  homeController!.teAdult!.getRawString()),
                              containerInformation(
                                  UITitleCode.TABLEHEADER_CHILD,
                                  homeController!,
                                  homeController!.teChild!.getRawString()),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      homeController!.clear();
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        checkInformation = false;
                                      });
                                    },
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget loadingWidget() {
    return Container(
      color: ColorManagement.mainBackground.withOpacity(0.6),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: ColorManagement.greenColor,
          ),
          const SizedBox(height: 20),
          NeutronTextContent(
            message: MessageUtil.getMessageByCode(
                MessageCodeUtil.TEXTALERT_LOADING_CONFIGS),
            color: ColorManagement.greenColor,
          )
        ],
      ),
    );
  }

  Widget containerInformation(
          String codeMessage, HomeController homeController, String text) =>
      Container(
        padding: const EdgeInsets.all(10),
        height: 80,
        child: Row(
          children: [
            Expanded(
                flex: 4,
                child: NeutronTextTitle(
                  isPadding: false,
                  message: UITitleUtil.getTitleByCode(codeMessage),
                  color: Colors.black,
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: FloatingActionButton(
                    onPressed: () =>
                        homeController.removeInformation(codeMessage),
                    backgroundColor: Colors.white,
                    tooltip: 'remove',
                    child: const Icon(
                      Icons.remove,
                      color: Color(0xff4580e0),
                    ),
                  ),
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: Center(
                      child: Text(
                        text,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: FontFamily.aria),
                      ),
                    ))),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: FloatingActionButton(
                    onPressed: () => homeController.addInformation(codeMessage),
                    tooltip: 'add',
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.add,
                      color: Color(0xff4580e0),
                    ),
                  ),
                ))
          ],
        ),
      );

  Widget body(
          double height,
          double width,
          bool isMobile,
          HomeController controller,
          ScrollController scrollController,
          BuildContext context) =>
      SingleChildScrollView(
          controller: widget.roomType == null ? scrollController : null,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(10),
              height: height,
              child: widget.roomType == null
                  ? layoutPicture(homeController!.listPrictureHotel,
                      GeneralManager.hotel!.layoutHotel!, context)
                  : layoutPicture(
                      homeController!.listPrictureRoom[widget.roomType!.id]!,
                      GeneralManager.hotel!.layoutRoom!,
                      context),
            ),
            Container(
                height: isMobile ? 350 : 550,
                margin: EdgeInsets.only(
                    right: width * 0.078, left: width * 0.078, bottom: 10),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: NeutronTextTitle(
                                message: widget.roomType == null
                                    ? GeneralManager.hotel!.nameHotel!
                                    : widget.roomType!.name!,
                                fontSize: 24,
                                color: ColorUtil.colorBackgroudText,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (widget.roomType != null)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.bed,
                                            color: ColorUtil.colorBackgroudText,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message:
                                                '${UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_BED)} :',
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message:
                                                '${widget.roomType!.beds!}',
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.person,
                                            color: ColorUtil.colorBackgroudText,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message:
                                                '${UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_ADULT)} :',
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message:
                                                '${widget.roomType!.adult!}',
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.person,
                                            color: ColorUtil.colorBackgroudText,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message:
                                                '${UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_CHILD)} :',
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message:
                                                '${widget.roomType!.child!}',
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Icon(
                                            Icons.price_check,
                                            color: ColorUtil.colorBackgroudText,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message:
                                                '${UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_PRICE)} :',
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: NeutronTextContent(
                                            message: NumberUtil.numberFormat
                                                .format(widget.roomType!.price),
                                            color: ColorUtil.colorBackgroudText,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            const Divider(
                              color: Colors.black,
                              indent: 0.5,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                NeutronTextTitle(
                                    message: widget.roomType == null
                                        ? UITitleUtil.getTitleByCode(
                                            UITitleCode.ABOUT_THIS_HOTEL)
                                        : UITitleUtil.getTitleByCode(
                                            UITitleCode.ABOUT_THIS_ROOM),
                                    fontSize: 24,
                                    color: ColorUtil.colorBackgroudText),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (FirebaseAuth.instance.currentUser?.uid !=
                                    null)
                                  IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) =>
                                              widget.roomType == null
                                                  ? HtmlEditorExample(
                                                      describe: GeneralManager
                                                          .hotel!.describe,
                                                    )
                                                  : HtmlEditorExample(
                                                      roomType: widget.roomType,
                                                      describe: widget.roomType!
                                                          .describeRoom));
                                    },
                                    icon: SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: Icon(
                                        Icons.edit,
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                  )
                              ],
                            ),
                            Html(
                              data: isExpanded
                                  ? GeneralManager.hotel!.describe
                                  : GeneralManager.hotel!.describe,
                              // : _truncateHtml(GeneralManager.hotel!.describe!),
                              style: {
                                "html": Style(
                                  fontFamily: 'Arial',
                                ),
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Text(
                                isExpanded ? ' Show less' : '...Show more',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
            Container(
              margin:
                  EdgeInsets.only(right: width * 0.078, left: width * 0.078),
              height: 320,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(
                      color: Colors.black,
                      indent: 0.5,
                    ),
                    SizedBox(
                      child: NeutronTextTitle(
                          message: widget.roomType == null
                              ? UITitleUtil.getTitleByCode(
                                  UITitleCode.HOTEL_FACILITIES)
                              : UITitleUtil.getTitleByCode(
                                  UITitleCode.ROOM_FACILITIES),
                          fontSize: 24,
                          color: ColorUtil.colorBackgroudText),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        alignment: Alignment.center,
                        height: 255,
                        child: widget.roomType == null
                            ? FacilitiesWidget(
                                listIcon: controller.hotelFacilities,
                                listFacilitiesRoom:
                                    GeneralManager.hotel!.hotelFacilities,
                              )
                            : FacilitiesWidget(
                                listIcon: GeneralManager.listFacilitiesRoom,
                                roomType: widget.roomType,
                                listFacilitiesRoom:
                                    widget.roomType!.facilitesRoom,
                              ))
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin:
                  EdgeInsets.only(right: width * 0.078, left: width * 0.078),
              child: const Divider(
                color: Colors.black,
                indent: 0.5,
              ),
            ),
            widget.roomType == null
                ? Container(
                    height: 100,
                    margin: EdgeInsets.only(
                        right: width * 0.078, left: width * 0.078, bottom: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: NeutronTextTitle(
                                message: UITitleUtil.getTitleByCode(
                                  UITitleCode.RULES,
                                ),
                                fontSize: 24,
                                color: ColorUtil.colorBackgroudText),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              right: 20,
                              left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: NeutronTextContent(
                                            message:
                                                '${UITitleUtil.getTitleByCode(UITitleCode.TOOLTIP_CHECKIN)} :',
                                            color:
                                                ColorUtil.colorBackgroudText)),
                                    Expanded(
                                        flex: 4,
                                        child: NeutronTextContent(
                                            message: '12:00 pm',
                                            color:
                                                ColorUtil.colorBackgroudText))
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
                                            color:
                                                ColorUtil.colorBackgroudText)),
                                    Expanded(
                                        flex: 4,
                                        child: NeutronTextContent(
                                            message: '12:00 pm',
                                            color:
                                                ColorUtil.colorBackgroudText))
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]))
                : Container(
                    height: 450,
                    padding: EdgeInsets.only(
                      right: width * 0.078,
                      left: width * 0.078,
                    ),
                    margin: const EdgeInsets.only(
                      right: 20,
                      left: 20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NeutronTextTitle(
                            message: UITitleUtil.getTitleByCode(
                                UITitleCode.RATES_AVAILABILITY),
                            fontSize: 24,
                            color: ColorUtil.colorBackgroudText),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: SfDateRangePicker(
                            rangeSelectionColor: const Color(0xffa6c6fd),
                            startRangeSelectionColor: const Color(0xff5392f9),
                            endRangeSelectionColor: const Color(0xff5392f9),
                            controller: controllerD,
                            view: DateRangePickerView.month,
                            initialDisplayDate: DateTime.now(),
                            showActionButtons: true,
                            selectionMode: DateRangePickerSelectionMode.range,
                            enableMultiView: true,
                            initialSelectedRange: PickerDateRange(
                                homeController?.inDate,
                                homeController?.outDate),
                            monthViewSettings:
                                const DateRangePickerMonthViewSettings(
                                    firstDayOfWeek: 4),
                            onSelectionChanged: (data) {
                              selectedRange = data.value;
                              if (selectedRange != null) {
                                final startDate = selectedRange!.startDate;
                                final endDate = selectedRange!.endDate ??
                                    selectedRange!.startDate;

                                controller.setInDate(startDate!);
                                controller.setOutDate(endDate!);
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
            const SizedBox(
              height: 20,
            ),
            Container(
              key: widget.roomType == null ? controller.globalKey : null,
              padding: EdgeInsets.only(
                right: width * 0.078,
                left: width * 0.078,
              ),
              child: const Divider(
                color: Colors.black,
                indent: 0.5,
              ),
            ),
            widget.roomType != null
                ? Container(
                    padding: EdgeInsets.only(
                      right: width * 0.078,
                      left: width * 0.078,
                    ),
                    child: NeutronTextTitle(
                        message: UITitleUtil.getTitleByCode(
                            UITitleCode.EXPLORE_OTHER_OPTIONS),
                        fontSize: 24,
                        color: ColorUtil.colorBackgroudText),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      right: width * 0.078,
                      left: width * 0.078,
                    ),
                    child: NeutronTextTitle(
                        message: UITitleUtil.getTitleByCode(
                            UITitleCode.AVAIBILITI_CHANNEL),
                        fontSize: 24,
                        color: ColorUtil.colorBackgroudText),
                  ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: widget.roomType == null
                  ? homeController!.listRoomTypes.isNotEmpty && homeController!.listNumberRoom.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.only(
                              right: width * 0.078,
                              left: width * 0.078,
                              bottom: 20),
                          child: Column(
                              children: homeController!.listRoomTypes
                                  .where((element) =>
                                      homeController!
                                              .listNumberRoom[element.id] >
                                          0 &&
                                      homeController!
                                              .listNumberRoom[element.id] >=
                                          homeController!.teNumberRoom!
                                              .getNumber()! &&
                                      (element.adult! *
                                              homeController!.teNumberRoom!
                                                  .getNumber()!) >=
                                          homeController!.teAdult!.getNumber()!)
                                  .map((e) => UiRoom(
                                    homeController: homeController,
                                        data: {
                                          'inDate': controller.inDate,
                                          'outDate': controller.outDate,
                                          'adult':
                                              controller.teAdult!.getNumber(),
                                          'child':
                                              controller.teChild!.getNumber(),
                                          'starDay': controller.startDay,
                                          'endDay': controller.endDay,
                                          'listNumberRoom':
                                              controller.listNumberRoom,
                                          'numberRoom': controller.teNumberRoom
                                              ?.getNumber(),
                                        },
                                        roomType: e,
                                        number: homeController!
                                            .listNumberRoom[e.id],
                                      ))
                                  .toList()))
                      : Align(
                          child: NeutronTextContent(
                            message: MessageUtil.getMessageByCode(
                                MessageCodeUtil.NO_DATA),
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        )
                  : widget.roomType!.listRateRoomTypes!.isNotEmpty
                      ? Container(
                          margin: EdgeInsets.only(
                              right: width * 0.078,
                              left: width * 0.078,
                              bottom: 20),
                          child: Column(
                              children: homeController?.listNumberRoom[
                                          widget.roomType?.id] >
                                      0
                                  ? widget.roomType!.listRateRoomTypes!
                                      .map((e) => const RateRoomType())
                                      .toList()
                                  : [
                                      Align(
                                        child: NeutronTextContent(
                                          message: MessageUtil.getMessageByCode(
                                              MessageCodeUtil.NO_DATA),
                                          color: Colors.black,
                                          fontSize: 26,
                                        ),
                                      ),
                                    ]))
                      : Align(
                          child: NeutronTextContent(
                            message: MessageUtil.getMessageByCode(
                                MessageCodeUtil.NO_DATA),
                            color: Colors.black,
                            fontSize: 26,
                          ),
                        ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]));

  Widget layoutPicture(
      Map<String, String> picture, String layout, BuildContext context) {
    Widget? widget;
    switch (layout) {
      case 'layout01':
        widget = StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 2,
            children: picture.keys
                .take(2)
                .map(
                  (key) => StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  showPictureWidget(picture[key]!));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            picture[key]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList());
        break;
      case 'layout02':
        widget = StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 2,
            children: picture.keys
                .take(3)
                .map(
                  (key) => StaggeredGridTile.count(
                    crossAxisCellCount: key == '2' ? 4 : 2,
                    mainAxisCellCount: key == '2' ? 1 : 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    showPictureWidget(picture[key]!));
                          },
                          child: Image.network(
                            picture[key]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList());
        break;
      case 'layout03':
        widget = Padding(
          padding: const EdgeInsets.all(10),
          child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 2,
              children: picture.keys
                  .take(4)
                  .map(
                    (key) => StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    showPictureWidget(picture[key]!));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              picture[key]!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList()),
        );
        break;
      case 'layout04':
        widget = StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 2,
            children: picture.keys
                .take(4)
                .map(
                  (key) => StaggeredGridTile.count(
                    crossAxisCellCount: key == '0'
                        ? 2
                        : key == '3'
                            ? 2
                            : 1,
                    mainAxisCellCount: key == '0'
                        ? 2
                        : key == '3'
                            ? 1
                            : 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: InkWell(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) =>
                                  showPictureWidget(picture[key]!));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            picture[key]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList());
        break;
      case 'layout05':
        widget = StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 2,
            children: picture.keys
                .map(
                  (key) => StaggeredGridTile.count(
                    crossAxisCellCount: key == '0' ? 2 : 1,
                    mainAxisCellCount: key == '0' ? 2 : 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    showPictureWidget(picture[key]!));
                          },
                          child: Image.network(
                            picture[key]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList());
        break;
      case 'layout06':
        widget = StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 2,
            children: picture.keys
                .map(
                  (key) => StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: InkWell(
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) =>
                                    showPictureWidget(picture[key]!));
                          },
                          child: Image.network(
                            picture[key]!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList());
        break;
      default:
    }
    return widget!;
  }

  Widget showPictureWidget(String namePricture) {
    return Dialog(
      child: SizedBox(
        width: 1000,
        height: 500,
        child: Image.network(
          namePricture,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
