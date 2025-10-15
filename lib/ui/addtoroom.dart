import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/editroomtypecontroller.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/neutrontextformfield.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../handler/filehandler.dart';

class AddToRoom extends StatelessWidget {
  const AddToRoom({super.key, this.img, this.linkImg, this.idRoom});
  final String? img;
  final String? linkImg;
  final String? idRoom;
  @override
  Widget build(BuildContext context) {
    EditRoomTypeController controller = EditRoomTypeController(nameImg: img);
    final formKey = GlobalKey<FormState>();
    void pickImage({String? namePicture}) async {
      PlatformFile? pickedFile = await FileHandler.pickSingleImage(context);
      if (pickedFile == null) {
        return;
      }
      String? result = controller.addImageToRoom(pickedFile);
      if (context.mounted && result != MessageCodeUtil.SUCCESS) {
        MaterialUtil.showAlert(context, result);
      }
    }

    return Dialog(
      child: SizedBox(
        width: 400,
        height: 600,
        child: Scaffold(
          appBar: AppBar(
            title: NeutronTextContent(
              message:
                  UITitleUtil.getTitleByCode(UITitleCode.HEADER_ADD_PICTURE),
              color: ColorUtil.colorBackgroudText,
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: ColorUtil.colorBackgroudText,
              ),
            ),
            backgroundColor: ColorUtil.colorBackgroudMain,
          ),
          body: ChangeNotifierProvider.value(
            value: controller,
            child:
                Consumer<EditRoomTypeController>(builder: (_, controller, __) {
              return controller.isLoading
                  ? Container(
                      height: 600,
                      alignment: Alignment.center,
                      child: const CircularProgressIndicator(
                          color: ColorManagement.greenColor),
                    )
                  : Stack(
                      children: [
                        Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SizeManagement
                                    .cardOutsideHorizontalPadding),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                    height: SizeManagement.rowSpacing),
                                //sid
                                NeutronTextTitle(
                                  isPadding: false,
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.TABLEHEADER_SID),
                                  color: ColorUtil.colorBackgroudText,
                                ),
                                const SizedBox(
                                    height: SizeManagement.rowSpacing),
                                NeutronTextFormField(
                                  isDecor: true,
                                  readOnly: img != null ? true : false,
                                  controller: controller.nameImgRoom,
                                  backgroundColor: ColorUtil.colorBackgroudMain,
                                  textColor: ColorUtil.colorBackgroudText,
                                ),
                                const SizedBox(
                                    height: SizeManagement.rowSpacing),
                                Container(
                                  height: 40,
                                  padding: const EdgeInsets.all(10),
                                  child: InkWell(
                                    onTap: () => img == null
                                        ? pickImage()
                                        : pickImage(namePicture: img),
                                    child: const Text(
                                      'updaload img',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height: SizeManagement.rowSpacing),
                                controller.baseImg != null
                                    ? Image.memory(controller.baseImg!)
                                    : linkImg != null
                                        ? Image.network(
                                            linkImg!,
                                            fit: BoxFit.fill,
                                          )
                                        : Container(),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: NeutronButton(
                            icon: Icons.save,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final result =
                                    await controller.updatePictureRoom(idRoom!);
                                if (!context.mounted) {
                                  return;
                                }
                                if (result == '') {
                                  Navigator.pop(
                                      context,
                                      MessageUtil.getMessageByCode(
                                          MessageCodeUtil.SUCCESS));
                                } else {
                                  MaterialUtil.showAlert(context, result);
                                }
                              }
                            },
                          ),
                        )
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
