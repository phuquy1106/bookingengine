import 'package:bookingengine_frontend/constants.dart';
import 'package:bookingengine_frontend/controller/logincontroller.dart';
import 'package:bookingengine_frontend/controller/neutrontextheader.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/neutrontextstyle.dart';
import 'package:bookingengine_frontend/util/responsiveutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  late LoginController loginController;
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    loginController = LoginController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtil.isMobile(context);
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      content: SingleChildScrollView(
        child: Container(
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
            height: isMobile ? 435 : 650,
            width: isMobile ? kMobileWidth : 1200,
            child: isMobile ? uiMobile(loginController) : uiPC()),
      ),
    );
  }

  Widget uiPC() => Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        elevation: 5.0,
        child: Stack(
          children: [
            Positioned(
                top: 10,
                right: 30,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )),
            Row(
              children: <Widget>[
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                    child: SizedBox(
                      height: 1000,
                      child: Image.asset(
                        'assets/img/anh8.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(60),
                    width: kMobileWidth,
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ChangeNotifierProvider<LoginController>.value(
                      value: loginController,
                      child: Consumer<LoginController>(
                        builder: (_, controller, __) {
                          if (controller.isLoadding) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: ColorManagement.greenColor,
                            ));
                          }
                          return Column(
                            children: [
                              //header
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: NeutronTextHeader(
                                  message: UITitleUtil.getTitleByCode(
                                      UITitleCode.HEADER_SIGN_IN),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              //input email
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: SizedBox(
                                  width: 600,
                                  child: TextField(
                                    keyboardType: TextInputType.emailAddress,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontManagement.fontFamily,
                                    ),
                                    onSubmitted: (String value) {
                                      focusNode.requestFocus();
                                    },
                                    controller: controller.emailController,
                                    decoration: InputDecoration(
                                      label: NeutronTextContent(
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.HINT_EMAIL),
                                        color: Colors.black,
                                      ),
                                      errorStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: ColorManagement.textBlack,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.greenColor,
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.borderCell,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.borderCell,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.greenColor,
                                            width: 1),
                                      ),
                                      fillColor: Colors.blue[50],
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                    ),
                                    cursorColor: ColorManagement.greenColor,
                                  ),
                                ),
                              ),
                              //input password
                              SizedBox(
                                width: 600,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextField(
                                    obscureText: !controller.isShowPassword,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: FontManagement.fontFamily,
                                    ),
                                    focusNode: focusNode,
                                    onSubmitted: (String value) {
                                      login(controller, context);
                                    },
                                    controller: controller.passwordController,
                                    decoration: InputDecoration(
                                      label: NeutronTextContent(
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.HINT_PASSWORD),
                                        color: Colors.black,
                                      ),
                                      errorStyle:
                                          const TextStyle(color: Colors.red),
                                      prefixIcon: const Icon(
                                        Icons.lock,
                                        color: ColorManagement.textBlack,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.greenColor,
                                            width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.borderCell,
                                            width: 1),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.borderCell,
                                            width: 1),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: ColorManagement.greenColor,
                                            width: 1),
                                      ),
                                      fillColor: Colors.blue[50],
                                      filled: true,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                      suffix: InkWell(
                                          onTap: () {
                                            controller
                                                .toggleShowPasswordStatus();
                                          },
                                          child: Icon(
                                            controller.isShowPassword
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black,
                                            size: 14,
                                          )),
                                    ),
                                    cursorColor: ColorManagement.greenColor,
                                  ),
                                ),
                              ),
                              //forget-password

                              //remember-me button
                              SizedBox(
                                width: 600,
                                child: CheckboxListTile(
                                  activeColor: ColorManagement.greenColor,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: const EdgeInsets.all(0),
                                  title: NeutronTextContent(
                                    message: MessageUtil.getMessageByCode(
                                        MessageCodeUtil.TEXTALERT_REMEMBER_ME),
                                    color: Colors.black,
                                  ),
                                  onChanged: (bool? isChecked) {
                                    controller.setRememberMe(isChecked!);
                                  },
                                  value: controller.isRememberMe,
                                ),
                              ),
                              //button
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                width: 600,
                                height: 40,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(
                                        ColorManagement.transparentBackground),
                                    elevation: MaterialStateProperty.all(10),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15))),
                                  ),
                                  onPressed: () {
                                    login(controller, context);
                                  },
                                  child: NeutronTextContent(
                                    message: MessageUtil.getMessageByCode(
                                        MessageCodeUtil.TEXTALERT_LOGIN),
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              const Expanded(child: SizedBox()),
                              Container(
                                padding: const EdgeInsets.only(bottom: 13),
                                alignment: Alignment.center,
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: NeutronTextStyle.content,
                                    children: <TextSpan>[
                                      TextSpan(
                                        text:
                                            ' ${MessageUtil.getMessageByCode(MessageCodeUtil.TEXTALERT_CLICK_HERE)} ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            color: ColorManagement.redColor),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            launchUrlString(
                                                'https://www.youtube.com/watch?v=3diC6Qy1cBI',
                                                mode: LaunchMode
                                                    .externalApplication);
                                          },
                                      ),
                                      TextSpan(
                                          text: MessageUtil.getMessageByCode(
                                              MessageCodeUtil
                                                  .TEXTALERT_FOR_INSTRUCTION_VIDEO),
                                          style: const TextStyle(
                                              color: Colors.black)),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget uiMobile(LoginController controller) => Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40))),
        elevation: 5.0,
        child: Stack(
          children: [
            Positioned(
                top: 10,
                right: 20,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                )),
            // Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage(
            //           'assets/img/anh8.jpg',
            //         ),
            //         fit: BoxFit.cover),
            //   ),
            //   child: BackdropFilter(
            //     filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            //     child: Container(
            //       color: Colors.black.withOpacity(0.6),
            //     ),
            //   ),
            // ),
            Column(
              children: [
                //header
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: NeutronTextHeader(
                    message:
                        UITitleUtil.getTitleByCode(UITitleCode.HEADER_SIGN_IN),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                //input email
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: SizedBox(
                    width: 600,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: FontManagement.fontFamily,
                      ),
                      onSubmitted: (String value) {
                        focusNode.requestFocus();
                      },
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        label: NeutronTextContent(
                          message: UITitleUtil.getTitleByCode(
                              UITitleCode.HINT_EMAIL),
                          color: Colors.black,
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.red,
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: ColorManagement.textBlack,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.greenColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.borderCell, width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.borderCell, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.greenColor, width: 1),
                        ),
                        fillColor: Colors.blue[50],
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                      ),
                      cursorColor: ColorManagement.greenColor,
                    ),
                  ),
                ),
                //input password
                SizedBox(
                  width: 600,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      obscureText: !controller.isShowPassword,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: FontManagement.fontFamily,
                      ),
                      focusNode: focusNode,
                      onSubmitted: (String value) {
                        login(controller, context);
                      },
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        label: NeutronTextContent(
                          message: UITitleUtil.getTitleByCode(
                              UITitleCode.HINT_PASSWORD),
                          color: Colors.black,
                        ),
                        errorStyle: const TextStyle(color: Colors.red),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: ColorManagement.textBlack,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.greenColor, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.borderCell, width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.borderCell, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                              color: ColorManagement.greenColor, width: 1),
                        ),
                        fillColor: Colors.blue[50],
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        suffix: InkWell(
                            onTap: () {
                              controller.toggleShowPasswordStatus();
                            },
                            child: Icon(
                              controller.isShowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.black,
                              size: 14,
                            )),
                      ),
                      cursorColor: ColorManagement.greenColor,
                    ),
                  ),
                ),
                //forget-password

                //remember-me button
                SizedBox(
                  width: 600,
                  child: CheckboxListTile(
                    activeColor: ColorManagement.greenColor,
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.all(0),
                    title: NeutronTextContent(
                      message: MessageUtil.getMessageByCode(
                          MessageCodeUtil.TEXTALERT_REMEMBER_ME),
                      color: Colors.black,
                    ),
                    onChanged: (bool? isChecked) {
                      controller.setRememberMe(isChecked!);
                    },
                    value: controller.isRememberMe,
                  ),
                ),
                //button
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 600,
                  height: 40,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(
                          ColorManagement.transparentBackground),
                      elevation: MaterialStateProperty.all(10),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                    ),
                    onPressed: () {
                      login(controller, context);
                    },
                    child: NeutronTextContent(
                      message: MessageUtil.getMessageByCode(
                          MessageCodeUtil.TEXTALERT_LOGIN),
                      color: Colors.black,
                    ),
                  ),
                ),

                const Expanded(child: SizedBox()),
                Container(
                  padding: const EdgeInsets.only(bottom: 13),
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: NeutronTextStyle.content,
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              ' ${MessageUtil.getMessageByCode(MessageCodeUtil.TEXTALERT_CLICK_HERE)} ',
                          style: const TextStyle(
                              fontWeight: FontWeight.normal,
                              color: ColorManagement.redColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              launchUrlString(
                                  'https://www.youtube.com/watch?v=3diC6Qy1cBI',
                                  mode: LaunchMode.externalApplication);
                            },
                        ),
                        TextSpan(
                            text: MessageUtil.getMessageByCode(MessageCodeUtil
                                .TEXTALERT_FOR_INSTRUCTION_VIDEO),
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
  void login(LoginController controller, BuildContext context) async {
    String result = await controller.login();

    if (result == MessageUtil.getMessageByCode(MessageCodeUtil.SUCCESS)) {
      if (context.mounted) {
        if (context.mounted) Navigator.pop(context);
        MaterialUtil.showResult(context, result);
      }
      return;
    }
    if (context.mounted) {
      MaterialUtil.showAlert(context, result);
    }
  }
}
