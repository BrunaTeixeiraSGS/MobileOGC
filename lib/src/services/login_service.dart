import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:sugar/src/models/login_model.dart';
import 'package:sugar/src/ui/widgets/awasome_dialog.dart';
import 'package:sugar/src/utils/constants.dart';

class LoginService {
  Dio dio;
  AwasomeDialog awasome = AwasomeDialog();

  LoginService() {
    dio = Dio();
    dio.options.baseUrl = BASE_URL_NET;
  }

  Future<LoginModel> getLogin(
      {@required login, @required senha, @required context}) async {
    Response response = await dio
        .post('/Login', data: {"Login": login, "Senha": senha}).catchError((e) {
         Navigator.pop(context);
         awasome.awasomeDialog(
            context: context,
            dialogType: DialogType.ERROR,
            animType: AnimType.SCALE,
            title: 'Erro ao logar',
            text: Column(
              children: <Widget>[
                Center(child: Text(
                    'Ops...', style: TextStyle(fontWeight: FontWeight.bold))),
                Center(child: Text(FlutterI18n.translate(context,
                    "msgValidacoesTelaLogin.msgUsuarioServidorAusente"),
                    style: TextStyle(fontWeight: FontWeight.bold)),)
              ],
            ),
            btnOkColor: Colors.red);
        return null;
    });

    if (response.data != null && response.data.toString().isNotEmpty && response.data["RetObject"] !=null)
    {
      return LoginModel.fromJsonNet(response.data["RetObject"]);
    } else {
      Navigator.pop(context);
      awasome.awasomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: 'Atenção',
          text: Column(
            children: <Widget>[
              Center(child: Text(
                  'Usuário não encontrado', style: TextStyle(fontWeight: FontWeight.bold))),
              Center(child: Text('Verifique se o login e a senha estão corretos.',
                  style: TextStyle(fontWeight: FontWeight.bold)),)
            ],
          ),
          btnOkColor: Colors.red);
      return null;
    }
  }

}
