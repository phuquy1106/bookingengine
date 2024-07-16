import 'package:bookingengine_frontend/manager/generalmanager.dart';
import 'package:bookingengine_frontend/model/policy.dart';
import 'package:bookingengine_frontend/util/messageulti.dart';
import 'package:bookingengine_frontend/util/neutrontextformfield.dart';
import 'package:bookingengine_frontend/util/uimultilanguageutil.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class PolicyController extends ChangeNotifier {
  TextEditingController? teSID, teTitle, teNotes;
  String? namePolitity = '';
  String? politity;
  Policy? policy;
  bool isLoading = false;
  bool isLoadingPolicy = false;
  late TextEditingController tePrice, tePercent, teNight;
  TextEditingController? amout;
  late String errorLog;
  List<String> listPolicy = [
    UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_TYPE_REVENUE_NONE),
    UITitleUtil.getTitleByCode(UITitleCode.FULL_AMOUNT),
    UITitleUtil.getTitleByCode(UITitleCode.PERCENT),
    UITitleUtil.getTitleByCode(UITitleCode.PERMANENT),
    UITitleUtil.getTitleByCode(UITitleCode.NIGHT),
  ];

  Map<String, String> listCodePolicy = {
    UITitleUtil.getTitleByCode(UITitleCode.FULL_AMOUNT): 'full',
    UITitleUtil.getTitleByCode(UITitleCode.PERCENT): 'percent',
    UITitleUtil.getTitleByCode(UITitleCode.PERMANENT): 'permanent',
    UITitleUtil.getTitleByCode(UITitleCode.NIGHT): 'night',
  };

  NeutronInputNumberController? teDay;
  PolicyController({Policy? policy}) {
    if (policy != null) {
      this.policy = policy;
      politity = policy.policyType;
      switch (policy.policyType) {
        case 'full':
          namePolitity = UITitleUtil.getTitleByCode(UITitleCode.FULL_AMOUNT);
          tePrice = TextEditingController(text: '');
          tePercent = TextEditingController(text: '');
          teNight = TextEditingController(text: '');
          amout = null;
          break;
        case 'percent':
          namePolitity = UITitleUtil.getTitleByCode(UITitleCode.PERCENT);
          tePercent = TextEditingController(text: policy.amount.toString());
          tePrice = TextEditingController(text: '');
          teNight = TextEditingController(text: '');
          amout = tePercent;
          break;
        case 'permanent':
          namePolitity = UITitleUtil.getTitleByCode(UITitleCode.PERMANENT);
          tePrice = TextEditingController(text: policy.amount.toString());
          tePercent = TextEditingController(text: '');
          teNight = TextEditingController(text: '');
          amout = tePrice;
          break;
        case 'night':
          namePolitity = UITitleUtil.getTitleByCode(UITitleCode.NIGHT);
          teNight = TextEditingController(text: policy.amount.toString());
          tePrice = TextEditingController(text: '');
          tePercent = TextEditingController(text: '');
          amout = teNight;
          break;
        default:
      }
    } else {
      namePolitity =
          UITitleUtil.getTitleByCode(UITitleCode.TABLEHEADER_TYPE_REVENUE_NONE);
      tePrice = TextEditingController(text: '');
      tePercent = TextEditingController(text: '');
      teNight = TextEditingController(text: '');
    }

    teDay = NeutronInputNumberController(
        TextEditingController(text: policy?.day.toString() ?? 0.toString()));
    teSID = TextEditingController(text: policy?.id ?? '');
    teTitle = TextEditingController(text: policy?.title ?? '');

    teNotes = TextEditingController(text: policy?.notes ?? '');
  }

  String getPolicyType(String code) {
    String policy = '';
    switch (code) {
      case 'full':
        policy = UITitleUtil.getTitleByCode(UITitleCode.FULL_AMOUNT);
        break;
      case 'percent':
        policy = UITitleUtil.getTitleByCode(UITitleCode.PERCENT);
        break;
      case 'permanent':
        policy = UITitleUtil.getTitleByCode(UITitleCode.PERMANENT);
        break;
      case 'night':
        policy = UITitleUtil.getTitleByCode(UITitleCode.NIGHT);
        break;
      default:
    }
    return policy;
  }

  void setPolicity(String codePolicity) {
    namePolitity = codePolicity;
    politity = listCodePolicy[codePolicity];
    setAmout(politity!);
    notifyListeners();
  }

  void setAmout(String codePolicity) {
    switch (codePolicity) {
      case 'percent':
        amout = tePercent;
        break;
      case 'permanent':
        amout = tePrice;
        break;
      case 'full':
        amout = null;
        break;
      case 'night':
        amout = teNight;
        break;
      default:
    }
  }

  Future<String> addPolicy() async {
    if (politity == null) {
      return MessageCodeUtil.PLEASE_SELECT_THE_POLICY_TYPE;
    }

    isLoading = true;
    notifyListeners();
    final policyType = {
      'hotel_id': GeneralManager.idHotel,
      'sid': teSID?.text,
      'title': teTitle?.text,
      'day': int.parse(teDay!.getRawString()),
      'politity': politity,
      'amount':
          amout != null ? num.parse(amout!.text.replaceAll(',', '')) : null,
      'note': teNotes?.text
    };
    HttpsCallable callable;
    try {
      if (policy != null) {
        callable = FirebaseFunctions.instance
            .httpsCallable('bookingengine-updatepolicy');
      } else {
        callable =
            FirebaseFunctions.instance.httpsCallable('bookingengine-addpolicy');
      }
      await callable(policyType);
      isLoading = false;
      notifyListeners();
      return '';
    } on FirebaseFunctionsException catch (e) {
      errorLog = e.message.toString();
      isLoading = false;
      notifyListeners();
      return e.message.toString();
    }
  }

  Future<bool> deletPolicy(String idPolicy) async {
    isLoadingPolicy = true;
    notifyListeners();
    try {
      HttpsCallable callable = FirebaseFunctions.instance
          .httpsCallable('bookingengine-deletepolicy');
      final result = await callable(
          {'hotel_id': GeneralManager.idHotel, 'id_policy': idPolicy});
      isLoadingPolicy = false;
      notifyListeners();
      return result.data == MessageCodeUtil.SUCCESS ? true : false;
    } on FirebaseFunctionsException catch (e) {
      errorLog = MessageUtil.getMessageByCode(e.message);
      isLoadingPolicy = false;
      notifyListeners();
      return false;
    }
  }

  void loadDataBooking() async {
    isLoadingPolicy = true;
    notifyListeners();
    await GeneralManager.getPolicy2();
    isLoadingPolicy = false;
    notifyListeners();
  }
}
