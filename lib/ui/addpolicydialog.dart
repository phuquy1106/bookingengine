import 'package:bookingengine_frontend/constants.dart';
import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrondropdown.dart';
import 'package:bookingengine_frontend/controller/policycontroller.dart';
import 'package:bookingengine_frontend/model/policy.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/materialutil.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/neutrontextformfield.dart';
import 'package:bookingengine_frontend/util/responsiveutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../contals/neutrontexttilte.dart';
import '../validator/numbervalidator.dart';

class AddPolicyDialog extends StatefulWidget {
  const AddPolicyDialog({super.key, this.policy});
  final Policy? policy;
  @override
  State<AddPolicyDialog> createState() => _AddPolicyDialogState();
}

class _AddPolicyDialogState extends State<AddPolicyDialog> {
  final formKey = GlobalKey<FormState>();
  late NeutronInputNumberController priceControllers;
  late NeutronInputNumberController dayControllers;
  late NeutronInputNumberController percenControllers;
  PolicyController? controller;

  @override
  void initState() {
    controller = PolicyController(policy: widget.policy);
    priceControllers = NeutronInputNumberController(controller!.tePrice);
    percenControllers = NeutronInputNumberController(controller!.tePercent);
    dayControllers = NeutronInputNumberController(controller!.teNight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtil.isMobile(context);
    final double width = isMobile ? kMobileWidth : kWidth;
    const height = kHeight;

    return Dialog(
      backgroundColor: ColorUtil.colorBackgroudMain,
      child: SizedBox(
        width: 600,
        child: Scaffold(
          appBar: AppBar(
            title: NeutronTextContent(
              message:
                  UITitleUtil.getTitleByCode(UITitleCode.HEADER_ADD_POLICY),
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
          body: SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height,
              child: Form(
                  key: formKey,
                  child: ChangeNotifierProvider.value(
                    value: controller,
                    child: Consumer<PolicyController>(
                        builder: (_, controller, __) {
                      return controller.isLoading
                          ? Container(
                              height: kMobileWidth,
                              alignment: Alignment.center,
                              child: const CircularProgressIndicator(
                                  color: ColorManagement.greenColor),
                            )
                          : Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: SizeManagement
                                          .cardOutsideHorizontalPadding),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        controller: controller.teSID,
                                        readOnly: widget.policy == null
                                            ? false
                                            : true,
                                        backgroundColor:
                                            ColorUtil.colorBackgroudMain,
                                        textColor: ColorUtil.colorBackgroudText,
                                      ),
                                      const SizedBox(height: 20),
                                      NeutronTextTitle(
                                        isRequired: true,
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.TABLEHEADER_NAME),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                      const SizedBox(
                                          height: SizeManagement.rowSpacing),
                                      NeutronTextFormField(
                                        isDecor: true,
                                        controller: controller.teTitle,
                                        // readOnly: !HO.booking.isNameEditable(),
                                        validator: (value) => value!.isEmpty
                                            ? MessageUtil.getMessageByCode(
                                                MessageCodeUtil.INPUT_NAME)
                                            : null,
                                        backgroundColor:
                                            ColorUtil.colorBackgroudMain,
                                        textColor: ColorUtil.colorBackgroudText,
                                      ),
                                      const SizedBox(height: 20),
                                      NeutronTextTitle(
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.TABLEHEADER_TODAY),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                      const SizedBox(height: 8),
                                      SizedBox(
                                        child: controller.teDay!.buildWidget(
                                            validator: (String? value) =>
                                                NumberValidator
                                                        .validatePositiveNumber(
                                                            value!.replaceAll(
                                                                ',', ''))
                                                    ? null
                                                    : MessageUtil.getMessageByCode(
                                                        MessageCodeUtil
                                                            .ADULT_MUST_BE_NUMBER),
                                            color: ColorUtil.colorBackgroudMain,
                                            textColor:
                                                ColorUtil.colorBackgroudText
                                            // readOnly: !homeController.booking.isAdultChildEditable(),
                                            ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: NeutronTextTitle(
                                              isRequired: true,
                                              isPadding: false,
                                              message:
                                                  UITitleUtil.getTitleByCode(
                                                      UITitleCode.POLITY_TYPE),
                                              color:
                                                  ColorUtil.colorBackgroudText,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets
                                                  .symmetric(
                                                  horizontal: SizeManagement
                                                      .cardOutsideHorizontalPadding,
                                                  vertical: SizeManagement
                                                      .rowSpacing),
                                              child: NeutronTextTitle(
                                                  isRequired: true,
                                                  message: UITitleUtil
                                                      .getTitleByCode(UITitleCode
                                                          .TABLEHEADER_PRICE),
                                                  color: ColorUtil
                                                      .colorBackgroudText,
                                                  isPadding: false),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                          height: SizeManagement.rowSpacing),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: NeutronDropDown(
                                              focusColor: Colors.white,
                                              dropdownColor: Colors.white,
                                              isDropdownDarkColor: false,
                                              value: controller.namePolitity!,
                                              items: controller.listPolicy,
                                              textStyle: const TextStyle(
                                                  color: Colors.black),
                                              onChanged: (String value) =>
                                                  controller.setPolicity(value),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          if (controller.namePolitity ==
                                              UITitleUtil.getTitleByCode(UITitleCode
                                                  .TABLEHEADER_TYPE_REVENUE_NONE))
                                            const Expanded(child: SizedBox()),
                                          if (controller.namePolitity ==
                                              UITitleUtil.getTitleByCode(
                                                  UITitleCode.PERMANENT))
                                            Expanded(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          SizeManagement
                                                              .borderRadius8),
                                                  color: ColorUtil
                                                      .colorBackgroudMain),
                                              margin: const EdgeInsets.only(
                                                left: SizeManagement
                                                    .cardOutsideHorizontalPadding,
                                                right: SizeManagement
                                                    .cardOutsideHorizontalPadding,
                                              ),
                                              child:
                                                  priceControllers.buildWidget(
                                                isDouble: true,
                                                isDecor: true,
                                                color: ColorUtil
                                                    .colorBackgroudMain,
                                                suffixText: "VND",
                                                textColor: ColorUtil
                                                    .colorBackgroudText,
                                                validator: (String? value) {
                                                  if (!NumberValidator
                                                      .validateNumber(
                                                          priceControllers
                                                              .getRawString())) {
                                                    return MessageUtil
                                                        .getMessageByCode(
                                                            MessageCodeUtil
                                                                .INPUT_PRICE);
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )),
                                          if (controller.namePolitity ==
                                              UITitleUtil.getTitleByCode(
                                                  UITitleCode.PERCENT))
                                            Expanded(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          SizeManagement
                                                              .borderRadius8),
                                                  color: ColorUtil
                                                      .colorBackgroudMain),
                                              margin: const EdgeInsets.only(
                                                left: SizeManagement
                                                    .cardOutsideHorizontalPadding,
                                                right: SizeManagement
                                                    .cardOutsideHorizontalPadding,
                                              ),
                                              child:
                                                  percenControllers.buildWidget(
                                                isDouble: true,
                                                isDecor: true,
                                                color: ColorUtil
                                                    .colorBackgroudMain,
                                                suffixText: "%",
                                                textColor: ColorUtil
                                                    .colorBackgroudText,
                                                validator: (String? value) {
                                                  if (!NumberValidator
                                                      .validateNumber(
                                                          percenControllers
                                                              .getRawString())) {
                                                    return MessageUtil
                                                        .getMessageByCode(
                                                            MessageCodeUtil
                                                                .INPUT_PRICE);
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )),
                                          if (controller.namePolitity ==
                                              UITitleUtil.getTitleByCode(
                                                  UITitleCode.FULL_AMOUNT))
                                            Expanded(child: Container()),
                                          if (controller.namePolitity ==
                                              UITitleUtil.getTitleByCode(
                                                  UITitleCode.NIGHT))
                                            Expanded(
                                                child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          SizeManagement
                                                              .borderRadius8),
                                                  color: ColorUtil
                                                      .colorBackgroudMain),
                                              margin: const EdgeInsets.only(
                                                left: SizeManagement
                                                    .cardOutsideHorizontalPadding,
                                                right: SizeManagement
                                                    .cardOutsideHorizontalPadding,
                                              ),
                                              child: dayControllers.buildWidget(
                                                isDouble: true,
                                                isDecor: true,
                                                color: ColorUtil
                                                    .colorBackgroudMain,
                                                suffixText: "day",
                                                textColor: ColorUtil
                                                    .colorBackgroudText,
                                                validator: (String? value) {
                                                  if (!NumberValidator
                                                      .validateNumber(
                                                          dayControllers
                                                              .getRawString())) {
                                                    return MessageUtil
                                                        .getMessageByCode(
                                                            MessageCodeUtil
                                                                .INPUT_PRICE);
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      NeutronTextTitle(
                                        isRequired: true,
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.HEADER_NOTES),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                      const SizedBox(
                                          height: SizeManagement.rowSpacing),
                                      NeutronTextFormField(
                                        paddingVertical: 16,

                                        // label: UITitleUtil.getTitleByCode(
                                        //     UITitleCode.HINT_NOTES),
                                        isDecor: true,
                                        maxLine: 4,
                                        controller: controller.teNotes,
                                        textColor: ColorUtil.colorBackgroudText,
                                        backgroundColor:
                                            ColorUtil.colorBackgroudMain,
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: NeutronButton(
                                    icon: Icons.save,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        final result =
                                            await controller.addPolicy();
                                        if (!mounted) {
                                          return;
                                        }
                                        if (result == '') {
                                          Navigator.pop(
                                              context,
                                              MessageUtil.getMessageByCode(
                                                  MessageCodeUtil.SUCCESS));
                                        } else {
                                          MaterialUtil.showAlert(
                                              context,
                                              MessageUtil.getMessageByCode(
                                                  result));
                                        }
                                      }
                                    },
                                  ),
                                )
                              ],
                            );
                    }),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
