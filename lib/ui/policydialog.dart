import 'package:bookingengine_frontend/contals/neutronbutton.dart';
import 'package:bookingengine_frontend/contals/neutrontexttilte.dart';
import 'package:bookingengine_frontend/controller/neutronblurbutton.dart';
import 'package:bookingengine_frontend/controller/policycontroller.dart';
import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/ui/addpolicydialog.dart';
import 'package:bookingengine_frontend/util/colorutil.dart';
import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextcontent.dart';
import 'package:bookingengine_frontend/util/numberutil.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/materialutil.dart';

class PolicyDialog extends StatefulWidget {
  const PolicyDialog({super.key});

  @override
  State<PolicyDialog> createState() => _PolicyDialogState();
}

class _PolicyDialogState extends State<PolicyDialog> {
  PolicyController? policyController;
  @override
  void initState() {
    policyController = PolicyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        child: ChangeNotifierProvider.value(
          value: policyController,
          child: Consumer<PolicyController>(builder: (_, policyController, __) {
            return policyController.isLoadingPolicy
                ? const Center(
                    child: CircularProgressIndicator(
                        color: ColorManagement.greenColor))
                : Scaffold(
                    appBar: AppBar(
                      title: NeutronTextContent(
                        message: UITitleUtil.getTitleByCode(
                            UITitleCode.SIDEBAR_POLICY),
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
                      actions: [
                        NeutronBlurButton(
                          tooltip: UITitleUtil.getTitleByCode(
                              UITitleCode.TOOLTIP_REFRESH),
                          icon: Icons.refresh,
                          onPressed: () async {
                            policyController.loadDataBooking();
                          },
                        )
                      ],
                      backgroundColor: ColorUtil.colorBackgroudMain,
                    ),
                    body: Stack(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20, right: 20, bottom: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: NeutronTextTitle(
                                        textAlign: TextAlign.center,
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.TABLEHEADER_R_TYPE_ID),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                    Expanded(
                                      child: NeutronTextTitle(
                                        textAlign: TextAlign.center,
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.TABLEHEADER_TITLE),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                    Expanded(
                                      child: NeutronTextTitle(
                                        textAlign: TextAlign.center,
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode
                                                .TABLEHEADER_EFFECTIVE_DATE),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                    Expanded(
                                      child: NeutronTextTitle(
                                        textAlign: TextAlign.center,
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.POLITY_TYPE),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                    Expanded(
                                      child: NeutronTextTitle(
                                        textAlign: TextAlign.center,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.TABLEHEADER_PRICE),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                    Expanded(
                                      child: NeutronTextTitle(
                                        textAlign: TextAlign.center,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.HEADER_NOTES),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                    //size of trailing of expansionTile
                                    Expanded(
                                      child: NeutronTextTitle(
                                        textAlign: TextAlign.center,
                                        isPadding: false,
                                        message: UITitleUtil.getTitleByCode(
                                            UITitleCode.TABLEHEADER_ACTIVITIES),
                                        color: ColorUtil.colorBackgroudText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 20, right: 20, bottom: 20),
                                child: Column(
                                  children: GeneralManager.listNewPolicy
                                      .where((element) =>
                                          element.isDelete == false)
                                      .map(
                                        (policy) => Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: NeutronTextContent(
                                                textAlign: TextAlign.center,
                                                message: policy.id!,
                                                color: ColorUtil
                                                    .colorBackgroudText,
                                              )),
                                              Expanded(
                                                  child: NeutronTextContent(
                                                textAlign: TextAlign.center,
                                                tooltip: policy.title,
                                                message: policy.title!,
                                                color: ColorUtil
                                                    .colorBackgroudText,
                                              )),
                                              Expanded(
                                                  child: NeutronTextContent(
                                                textAlign: TextAlign.center,
                                                message: '${policy.day}',
                                                color: ColorUtil
                                                    .colorBackgroudText,
                                              )),
                                              Expanded(
                                                  child: NeutronTextContent(
                                                textAlign: TextAlign.center,
                                                message: policyController
                                                    .getPolicyType(
                                                        policy.policyType!),
                                                color: ColorUtil
                                                    .colorBackgroudText,
                                              )),
                                              policy.amount == null
                                                  ? const Expanded(
                                                      child: SizedBox())
                                                  : Expanded(
                                                      child: NeutronTextContent(
                                                      message: NumberUtil
                                                          .numberFormat
                                                          .format(
                                                              policy.amount),
                                                      color: ColorUtil
                                                          .colorBackgroudText,
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                              Expanded(
                                                  child: NeutronTextContent(
                                                message: policy.notes!,
                                                color: ColorUtil
                                                    .colorBackgroudText,
                                                textAlign: TextAlign.center,
                                              )),
                                              Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: IconButton(
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 40,
                                                                maxWidth: 40),
                                                        tooltip: UITitleUtil
                                                            .getTitleByCode(
                                                                UITitleCode
                                                                    .TOOLTIP_EDIT_POLICY),
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color: ColorUtil
                                                              .colorBackgroudText,
                                                        ),
                                                        onPressed: () async {
                                                          await showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AddPolicyDialog(
                                                                    policy:
                                                                        policy,
                                                                  ));
                                                        },
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: IconButton(
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 40,
                                                                maxWidth: 40),
                                                        tooltip: UITitleUtil
                                                            .getTitleByCode(
                                                                UITitleCode
                                                                    .TOOLTIP_DELETE_POLICY),
                                                        icon: Icon(
                                                          Icons.delete,
                                                          color: ColorUtil
                                                              .colorBackgroudText,
                                                        ),
                                                        onPressed: () async {
                                                          final result = await MaterialUtil
                                                              .showConfirm(
                                                                  context,
                                                                  MessageUtil.getMessageByCode(
                                                                      MessageCodeUtil
                                                                          .CONFIRM_DELETE_X,
                                                                      [
                                                                        GeneralManager()
                                                                            .getNamePolicyById(policy.id!)
                                                                      ]));
                                                          if (result == null ||
                                                              result == false) {
                                                            return;
                                                          }
                                                          policyController
                                                              .deletPolicy(
                                                                  policy.id!)
                                                              .then((value) {
                                                            if (!value) {
                                                              MaterialUtil.showAlert(
                                                                  context,
                                                                  policyController
                                                                      .errorLog);
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: NeutronButton(
                            icon1: Icons.add,
                            tooltip1: UITitleUtil.getTitleByCode(
                                UITitleCode.HEADER_ADD_POLICY),
                            onPressed1: () async {
                              await showDialog(
                                  context: context,
                                  builder: (ctx) => const AddPolicyDialog());
                            },
                          ),
                        )
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
