import 'package:flutter/material.dart';
import 'package:sugar/src/ui/widgets/drawer.dart';
import 'package:sugar/src/ui/widgets/form_text_field.dart';
import 'package:sugar/src/ui/widgets/botao_data.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:sugar/src/blocs/container_bloc.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:sugar/src/utils/cores.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:sugar/src/models/login_model.dart';
import 'package:sugar/src/ui/widgets/awasome_dialog.dart';

class FormularioOs extends StatefulWidget {
  @override
  _FormulariosOsState createState() => _FormulariosOsState();
}

class _FormulariosOsState  extends State<FormularioOs> {
  static const String route = '/formularios';
  BuildDrawer _buildDrawer = BuildDrawer();
  TextEditingController _campo01 = TextEditingController();
  TextEditingController _campo02 = TextEditingController();
  TextEditingController _campo03 = TextEditingController();
  TextEditingController _campo04 = TextEditingController();
  TextEditingController _campo05 = TextEditingController();
  TextEditingController _dataHoraInicioInspecaoController = TextEditingController();
  int _characterOption1 = 1;
  int _characterOption2 = 1;
  MyWidget _myWidget = MyWidget();
  int _groupValue = -1;
  String radioItemHolder = 'TERMINAL 01';
  int id = 1;
  final format = DateFormat("dd/MM/yyyy HH:mm");
  AwasomeDialog awasome = AwasomeDialog();

  List<NumberList> nList = [
    NumberList(
      index: 1,
      number: "TERMINAL 01",
    ),
    NumberList(
      index: 2,
      number: "TERMINAL 02",
    ),
  ];

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    const logoAfl = AssetImage('assets/images/logo_afl.png');
    int _selectedIndex = 0;


    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Ordem de Serviço'),
        backgroundColor: Color.fromARGB(255, 080, 079, 081),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: 1.0),
                    child: Card(
                        margin: EdgeInsets.all(5.0),
                        elevation: 10.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 1.22,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom: 0.0, left: 20.0, right: 20.0),
                            child: StreamBuilder<bool>(
                                initialData: false,
                                builder: (context, snapshot) {

                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: _myWidget.textFormField(
                                            _campo01,
                                           "NÚMERO ORDEM DE SERVIÇO",
                                            "NÚMERO ORDEM DE SERVIÇO",
                                            false,
                                            typeText: TextInputType.text,
                                            verificarValidate: true,
                                            autoValidate: snapshot.data),
                                      ),
                                      Flexible(
                                        child: _myWidget.textFormField(
                                            _campo02,
                                            "NOME DO NAVIO",
                                            "NOME DO NAVIO",
                                            false,
                                            typeText: TextInputType.number,
                                            verificarValidate: true,
                                            autoValidate: snapshot.data,
                                        ),
                                      ),
                                      Flexible(
                                        child: Column(
                                          children: nList
                                              .map((data) => RadioListTile(
                                            title: Text("${data.number}"),
                                            groupValue: id,
                                            value: data.index,
                                            onChanged: (val) {
                                              setState(() {
                                                radioItemHolder = data.number;
                                                id = data.index;
                                                 });
                                            },
                                          ))
                                              .toList(),
                                        ),
                                      ),
                                      new Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Text("DATA DE EMISSAO"),
                                        ],
                                      ),
                                      DateTimeField(
                                        format: format,
                                        onShowPicker: (context, currentValue) {
                                          return showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ?? DateTime.now(),
                                              lastDate: DateTime(2100));
                                        },
                                        decoration: InputDecoration(
                                          labelStyle: TextStyle(
                                              color: Color.fromARGB(255, 080, 079, 081), fontSize: 16),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              borderSide:
                                              BorderSide(color: Color.fromARGB(255, 243, 112, 33))),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              borderSide:
                                              BorderSide(color: Color.fromARGB(255, 243, 112, 33))),
                                        ),
                                      ),

                                      Flexible(
                                        child: _myWidget.textFormField(
                                            _campo04,
                                            "OBSERVAÇÕES",
                                            "OBSERVAÇÕES",
                                            false,
                                            typeText: TextInputType.multiline,
                                            verificarValidate: true,
                                            maxLines: 10,
                                            autoValidate: snapshot.data),
                                      ),
                                      Padding( padding: EdgeInsets.only(
                                          top:  50.0),),
                                      Flexible(
                                        child: Column(
                                          children: <Widget>[
                                              RaisedButton(
                                              elevation: 10.0,
                                              splashColor: Colors.white,
                                              onPressed: () async {
                                                Navigator.pop(context);
                                                awasome.awasomeDialog2(
                                                    context: context,
                                                    dialogType: DialogType.SUCCES,
                                                    animType: AnimType.SCALE,
                                                    title: 'Sucesso',
                                                    text: Column(
                                                      children: <Widget>[
                                                        Center(child: Text(
                                                            'Atenção', style: TextStyle(fontWeight: FontWeight.bold))),
                                                        Center(child: Text('Sincronizado com sucesso!',
                                                            style: TextStyle(fontWeight: FontWeight.bold)),)
                                                      ],
                                                    ),
                                                    btnOkColor: Colors.green,
                                                    btnOkOnPress:() {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => FormularioOs()),
                                                      );
                                                    }
                                                );
                                                return null;
                                              },
                                              child: Text(
                                              "Sincronizar",
                                              style: TextStyle(
                                              color: Colors.white, fontSize: 17.0),
                                              ),
                                              color: Color.fromARGB(255, 243, 112, 33),
                                              )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),// Aqui deve ser chamado as paginas dentro do pacote UI
    );
  }
}

class NumberList {
  String number;
  int index;
  NumberList({this.number, this.index});
}
