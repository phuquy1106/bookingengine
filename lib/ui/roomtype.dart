import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/numberutil.dart';
import 'package:flutter/material.dart';

class RoomTypeWidget extends StatelessWidget {
  const RoomTypeWidget({super.key, required this.room});
  final RoomType room;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              child: Image.network(
                room.imgs!.isNotEmpty
                    ? room.imgs?.first
                    : 'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b',
                fit: BoxFit.fill,
                height: 700,
              ),
            ),
          ),
          Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NeutronTextContent(
                    message: room.name!,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.bed,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NeutronTextContent(
                              message: '${room.beds!}',
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NeutronTextContent(
                              message: '${room.adult!}',
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Icon(
                              Icons.price_check,
                              color: Colors.black,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            NeutronTextContent(
                              message:
                                  NumberUtil.numberFormat.format(room.price),
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
