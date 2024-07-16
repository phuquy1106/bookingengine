import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/responsiveutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FacilitiesWidget extends StatelessWidget {
  const FacilitiesWidget(
      {super.key, this.listIcon, this.listFacilitiesRoom, this.roomType});
  final Map<String, String>? listIcon;
  final List<dynamic>? listFacilitiesRoom;
  final RoomType? roomType;
  @override
  Widget build(BuildContext context) {
    num width = (MediaQuery.of(context).size.width);
    final bool isMobile = ResponsiveUtil.isMobile(context);
    return GridView.count(
        crossAxisCount: isMobile ? 2 : 3,
        childAspectRatio: width * 0.0058,
        mainAxisSpacing: width * 0.0065,
        children: roomType == null
            ? listFacilitiesRoom!
                .map((key) => roomFacilities(key, listIcon![key]))
                .toList()
            : listFacilitiesRoom!
                .map((e) => roomFacilities(e, listIcon![e]))
                .toList());
  }

  Widget roomFacilities(String? message, String? icon) {
    return SizedBox(
      child: Row(children: [
        Expanded(
            flex: 1,
            child: SvgPicture.asset(
              icon!,
              height: 36,
            )),
        Expanded(
          flex: 3,
          child: NeutronTextContent(
            message: UITitleUtil.getTitleByCode(message!),
            color: Colors.black,
          ),
        )
      ]),
    );
  }
}
