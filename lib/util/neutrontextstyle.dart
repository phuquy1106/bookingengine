import 'package:bookingengine_frontend/util/designmanagement.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:pdf/pdf.dart';

class NeutronTextStyle {
  static PdfColor mainColor = PdfColor.fromHex('59b69e');
  static const negativeNumber =
      TextStyle(fontSize: 14, color: ColorManagement.negativeText);

  static const positiveNumber =
      TextStyle(fontSize: 14, color: ColorManagement.positiveText);

  static const totalNumber = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 14,
      color: ColorManagement.positiveText);

  static const discountDefaultNumber =
      TextStyle(fontSize: 14, color: ColorManagement.lightColorText);

  static const content = TextStyle(
      fontSize: 14,
      color: ColorManagement.lightColorText,
      overflow: TextOverflow.ellipsis);

  static const title =
      TextStyle(fontSize: 16, color: ColorManagement.lightColorText);

  static const notes =
      TextStyle(fontSize: 14, color: ColorManagement.notesColorText);

  static final pdfHeader =
      pdf.TextStyle(fontSize: 20, color: PdfColor.fromHex('#424242'));

  static final pdfTableHeader = pdf.TextStyle(
      color: mainColor, fontSize: 14, fontWeight: pdf.FontWeight.normal);

  static final pdfContent =
      pdf.TextStyle(fontSize: 12, color: PdfColor.fromHex('#424242'));

  static final pdfContentMainColor =
      pdf.TextStyle(fontSize: 12, color: mainColor);

  static final pdfLightContent =
      pdf.TextStyle(fontSize: 12, color: PdfColor.fromHex('#646464'));

  static final pdfSmallContent =
      pdf.TextStyle(fontSize: 10, color: PdfColor.fromHex('#424242'));

  static final pdfSmallContentMainColor =
      pdf.TextStyle(fontSize: 10, color: mainColor);
}
