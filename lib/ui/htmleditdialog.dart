import 'package:bookingengine_frontend/controller/homecontroller.dart';
import 'package:bookingengine_frontend/controller/htmlcontroller.dart';
import 'package:bookingengine_frontend/model/roomtype.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
// ignore: depend_on_referenced_packages
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class HtmlEditorExample extends StatefulWidget {
  const HtmlEditorExample({super.key, this.describe, this.roomType});
  final String? describe;
  final RoomType? roomType;

  @override
  State<HtmlEditorExample> createState() => _HtmlEditorExampleState();
}

class _HtmlEditorExampleState extends State<HtmlEditorExample> {
  final HtmlEditorController controller = HtmlEditorController();
  HtmlController htmlController = HtmlController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: htmlController,
      child: Consumer<HtmlController>(builder: (_, htmlController, __) {
        return htmlController.isLoading
            ? Container(
                height: 600,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                    color: ColorManagement.greenColor),
              )
            : GestureDetector(
                onTap: () {
                  if (!kIsWeb) {
                    controller.clearFocus();
                  }
                },
                child: SingleChildScrollView(
                  child: Dialog(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        HtmlEditor(
                          controller: controller,
                          htmlEditorOptions: HtmlEditorOptions(
                            initialText: widget.describe ?? '',
                            hint: 'Your text here...',
                            shouldEnsureVisible: true,
                          ),
                          htmlToolbarOptions: HtmlToolbarOptions(
                            toolbarPosition:
                                ToolbarPosition.aboveEditor, //by default
                            toolbarType:
                                ToolbarType.nativeScrollable, //by default
                            onButtonPressed: (ButtonType type, bool? status,
                                Function? updateStatus) {
                              print(
                                  "button '${describeEnum(type)}' pressed, the current selected status is $status");
                              return true;
                            },
                            onDropdownChanged: (DropdownType type,
                                dynamic changed,
                                Function(dynamic)? updateSelectedItem) {
                              print(
                                  "dropdown '${describeEnum(type)}' changed to $changed");
                              return true;
                            },
                            mediaLinkInsertInterceptor:
                                (String url, InsertFileType type) {
                              print(url);
                              return true;
                            },
                            mediaUploadInterceptor:
                                (PlatformFile file, InsertFileType type) async {
                              print(file.name); //filename
                              print(file.size); //size in bytes
                              print(file
                                  .extension); //file extension (eg jpeg or mp4)
                              return true;
                            },
                          ),
                          otherOptions: const OtherOptions(height: 550),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueGrey),
                                onPressed: () {
                                  controller.undo();
                                },
                                child: const Text('Undo',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.blueGrey),
                                onPressed: () {
                                  controller.clear();
                                },
                                child: const Text('Reset',
                                    style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                                onPressed: () async {
                                  var txt = await controller.getText();
                                  if (txt.contains('src=\"data:')) {
                                    txt =
                                        '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                                  }
                                  String? result = await htmlController
                                      .addDescribe(txt, widget.roomType);
                                  if (!context.mounted) {
                                    return;
                                  }
                                  HomeController().rebuild();
                                  Navigator.pop(context);
                                  MaterialUtil.showAlert(context,
                                      MessageUtil.getMessageByCode(result));
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
