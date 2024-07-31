import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:bookingengine_frontend/ui/colorconfigdialog.dart';
import 'package:bookingengine_frontend/ui/facilitiesdialog.dart';
import 'package:bookingengine_frontend/ui/layoutpicture.dart';
import 'package:bookingengine_frontend/ui/loaddata.dart';
import 'package:bookingengine_frontend/ui/pictureconfigdialog.dart';
import 'package:bookingengine_frontend/ui/policydialog.dart';
import 'package:bookingengine_frontend/ui/roomtypedialog.dart';
// import 'package:bookingengine_frontend/ui/uiroom.dart';
import 'package:bookingengine_frontend/ui/updatefonttext.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorUtil.colorBackgroudMain,
      child: ListView(
        controller: ScrollController(),
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            leading: SvgPicture.asset(
              'assets/icon/layout.svg',
              height: 36,
            ),
            title: Text(
              UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_LAYOUT),
              style: TextStyle(color: ColorUtil.colorBackgroudText),
            ),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => const LayOutPicture());
            },
          ),
          ListTile(
            leading:
                Icon(Icons.color_lens, color: ColorUtil.colorBackgroudText),
            title: Text(UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_COLOR),
                style: TextStyle(color: ColorUtil.colorBackgroudText)),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => const ColorConfigDialog());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icon/facility-management.svg',
              height: 36,
            ),
            title: Text(
              UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_HOTEL_FACILITIES),
              style: TextStyle(color: ColorUtil.colorBackgroudText),
            ),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => const FacilitiesDialog());
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_size_select_actual_rounded,
                color: ColorUtil.colorBackgroudText),
            title: Text(
              UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_PICTURE),
              style: TextStyle(color: ColorUtil.colorBackgroudText),
            ),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => const PictureConfigDialog());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icon/room-edit.svg',
              height: 36,
            ),
            title: Text(
              UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_ROOMTYPE),
              style: TextStyle(color: ColorUtil.colorBackgroudText),
            ),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => const RoomTypeDialog());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icon/room-edit.svg',
              height: 36,
            ),
            title: Text(
              UITitleUtil.getTitleByCode(UITitleCode.SIDEBAR_POLICY),
              style: TextStyle(color: ColorUtil.colorBackgroudText),
            ),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context, builder: (context) => const PolicyDialog());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icon/room-edit.svg',
              height: 36,
            ),
            title: Text(
              'Font Family',
              style: TextStyle(color: ColorUtil.colorBackgroudText),
            ),
            onTap: () async {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) => const UpdateFontText());
            },
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icon/room-edit.svg',
              height: 36,
            ),
            title: Text(
              'cancelbooking',
              style: TextStyle(
                  color: ColorUtil.colorBackgroudText,
                  fontFamily: FontFamily.aria),
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoadData(
                          idBooking: '7T4igCjw1',
                        )),
              );
            },
          ),
        ],
      ),
    );
  }
}
