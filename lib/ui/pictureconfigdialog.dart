import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/homecontroller.dart';
import 'package:bookingengine_frontend/controller/pictureconfigcontroller.dart';
import 'package:bookingengine_frontend/handler/filehandler.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:provider/provider.dart';

class PictureConfigDialog extends StatefulWidget {
  const PictureConfigDialog({super.key});

  @override
  State<PictureConfigDialog> createState() => _PictureConfigDialogState();
}

class _PictureConfigDialogState extends State<PictureConfigDialog> {
  PictureConfigController? pictureConfigController;
  late DropzoneViewController controller;
  bool highlighted = false;
  @override
  void initState() {
    pictureConfigController = PictureConfigController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void pickImage({String? namePicture}) async {
      PlatformFile? pickedFile = await FileHandler.pickSingleImage(context);
      if (pickedFile == null) {
        return;
      }
      String? result = namePicture!.isNotEmpty
          ? pictureConfigController?.setImageToHotel(pickedFile, namePicture)
          : pictureConfigController?.addImageToHotel(pickedFile);
      if (context.mounted && result != MessageCodeUtil.SUCCESS) {
        MaterialUtil.showAlert(context, result);
      }
    }

    return Dialog(
      child: ChangeNotifierProvider<PictureConfigController>.value(
        value: pictureConfigController!,
        child: Consumer<PictureConfigController>(
            builder: (_, pictureConfigController, __) {
          return pictureConfigController.isLoading
              ? Container(
                  height: 600,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(
                      color: ColorManagement.greenColor),
                )
              : SizedBox(
                  width: 900,
                  child: Scaffold(
                    appBar: AppBar(
                      title: NeutronTextContent(
                        message: UITitleUtil.getTitleByCode(
                            UITitleCode.SIDEBAR_PICTURE),
                        color: ColorUtil.colorBackgroudText,
                      ),
                      leading: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: ColorUtil.colorBackgroudText,
                        ),
                      ),
                      backgroundColor: ColorUtil.colorBackgroudMain,
                      // actions: [
                      //   if (GeneralManager.hotel!.imgs!.length < 5 &&
                      //       pictureConfigController.number < 5)
                      //     InkWell(
                      //       onTap: () {
                      //         pickImage();
                      //       },
                      //       child: SizedBox(
                      //         height: 50,
                      //         width: 50,
                      //         child: Icon(
                      //           Icons.add,
                      //           color: ColorUtil.colorBackgroudText,
                      //         ),
                      //       ),
                      //     )
                      // ],
                    ),
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 60),
                            child: Column(children: [
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    child: NeutronTextTitle(
                                      isPadding: false,
                                      message: UITitleUtil.getTitleByCode(
                                          UITitleCode.TOOLTIP_UPLOAD_PHOTOS),
                                      color: ColorUtil.colorBackgroudText,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (GeneralManager.hotel!.imgs!.length < 5 &&
                                      pictureConfigController.number < 5)
                                    Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        dashPattern: const [20, 4],
                                        child: Container(
                                          color: const Color(0xffdbe1e1),
                                          height: 100,
                                          width: double.infinity,
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 30),
                                                      height: 100,
                                                      child: FittedBox(
                                                        fit: BoxFit.fill,
                                                        child: Image.asset(
                                                            'assets/img/logopicture.jpg'),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                    flex: 7,
                                                    child: SizedBox(
                                                        height: 100,
                                                        child: InkWell(
                                                          onTap: () {
                                                            pickImage();
                                                          },
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child: Icon(
                                                                  Icons.add,
                                                                  color: ColorUtil
                                                                      .colorBackgroudText,
                                                                ),
                                                              ),
                                                              NeutronTextTitle(
                                                                isPadding:
                                                                    false,
                                                                message: UITitleUtil
                                                                    .getTitleByCode(
                                                                        UITitleCode
                                                                            .TOOLTIP_UPLOAD_PHOTOS),
                                                                color: ColorUtil
                                                                    .colorBackgroudText,
                                                                fontSize: 16,
                                                              ),
                                                            ],
                                                          ),
                                                        )))
                                              ]),
                                        ),
                                      ),
                                    ),
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    height: 500,
                                    child: GridView.count(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1.5,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                      children: pictureConfigController
                                          .listPicture.keys
                                          .map((key) => MouseRegion(
                                                onEnter: (_) {
                                                  setState(() =>
                                                      pictureConfigController
                                                          .setElevated(
                                                              key, true));
                                                },
                                                onExit: (_) => setState(() =>
                                                    pictureConfigController
                                                        .setElevated(
                                                            key, false)),
                                                child: AnimatedContainer(
                                                    duration: const Duration(
                                                        milliseconds: 200),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      boxShadow:
                                                          pictureConfigController
                                                                      .isElevated[
                                                                  key]!
                                                              ? [
                                                                  const BoxShadow(
                                                                    color: Colors
                                                                        .black26,
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            10),
                                                                    blurRadius:
                                                                        20,
                                                                  ),
                                                                ]
                                                              : [],
                                                    ),
                                                    child: picture(
                                                        pictureConfigController,
                                                        key,
                                                        context,
                                                        pictureConfigController
                                                            .isElevated[key]!)),
                                              ))
                                          .toList(),
                                    ),
                                  )
                                ],
                              ))
                            ]),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomCenter,
                            child: NeutronButton(
                              onPressed: () async {
                                String? result =
                                    await pictureConfigController.updateImg();
                                if (!context.mounted) {
                                  return;
                                }
                                if (result == MessageCodeUtil.SUCCESS) {
                                  bool? confirmResult =
                                      await MaterialUtil.showConfirm(
                                          context,
                                          MessageUtil.getMessageByCode(
                                              MessageCodeUtil
                                                  .TEXTALERT_CHANGE_IMG_SUCCESS_AND_RELOAD));
                                  if (confirmResult == null || !confirmResult) {
                                    return;
                                  }
                                  HomeController().rebuild();
                                } else {
                                  MaterialUtil.showAlert(context,
                                      MessageUtil.getMessageByCode(result));
                                }
                              },
                              icon: Icons.save,
                            ))
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Widget picture(PictureConfigController pictureConfigController, String key,
      BuildContext context, bool isElevated) {
    return Stack(
      children: [
        SizedBox(
          width: 400,
          height: 220,
          child: (pictureConfigController.base64.isNotEmpty) &&
                  pictureConfigController.namePicture.contains(key)
              ? Image.memory(pictureConfigController.base64[key]!)
              : Image.network(
                  pictureConfigController.listPicture[key]!,
                  fit: BoxFit.fill,
                ),
        ),
        if (isElevated)
          Positioned(
              right: 0,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      //  pickImage(key);
                    },
                    child:
                        Icon(Icons.edit, color: ColorUtil.colorBackgroudMain),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      String? result = await pictureConfigController
                          .deleteImageFromFirestore(
                              pictureConfigController.listPicture[key]!, key);
                      if (context.mounted) {
                        MaterialUtil.showAlert(
                            context, MessageUtil.getMessageByCode(result));
                      }
                    },
                    child:
                        Icon(Icons.delete, color: ColorUtil.colorBackgroudMain),
                  ),
                ],
              ))
      ],
    );
  }
}
