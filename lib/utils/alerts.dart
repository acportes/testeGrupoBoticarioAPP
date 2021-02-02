import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'app_colors.dart';

class TipoDialog {
  static const int DIALOG_ERRO = 1;
  static const int DIALOG_INFORMACAO = 2;
}

alert(BuildContext context, String title, String msg, int tipo,
    {Function callback}) {
  if (tipo == TipoDialog.DIALOG_ERRO) {
    return exibeAlert(context, title, msg, tipo);
  } else if (tipo == TipoDialog.DIALOG_INFORMACAO) {
    return exibeAlert(context, title, msg, tipo);
  }
}

customAlert(BuildContext context, String title, String msg, AlertType type,
    List<DialogButton> botoes,
    {closeFunction}) {
  return Alert(
          context: context,
          type: type,
          title: title,
          style: AlertStyle(
            titleStyle: TextStyle(
              fontSize: ScreenUtil().setSp(25, allowFontScalingSelf: true),
            ),
            descStyle: TextStyle(
              fontSize: ScreenUtil().setSp(15, allowFontScalingSelf: true),
            ),
            isOverlayTapDismiss: false,
            isCloseButton: false,
          ),
          desc: msg,
          buttons: botoes,
          closeFunction: closeFunction)
      .show();
}

Future exibeAlert(context, title, msg, tipoDialog) {
  AlertType type;
  if (tipoDialog == TipoDialog.DIALOG_ERRO)
    type = AlertType.error;
  else if (tipoDialog == TipoDialog.DIALOG_INFORMACAO) type = AlertType.info;

  return Alert(
      context: context,
      type: type,
      title: title,
      style: AlertStyle(
          titleStyle: TextStyle(fontSize: 30),
          descStyle: TextStyle(fontSize: 20)),
      desc: msg,
      buttons: [
        DialogButton(
          color: AppColors.getPrimaryColor(),
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          width: 120,
        )
      ]).show();
}
