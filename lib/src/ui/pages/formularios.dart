import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:sugar/src/blocs/break_bulk_bloc.dart';
import 'package:sugar/src/blocs/sugar_bloc.dart';
import 'package:sugar/src/blocs/tipo_formulario_bloc.dart';
import 'package:sugar/src/models/breakbulk.dart';
import 'package:sugar/src/models/formulario.dart';
import 'package:sugar/src/ui/widgets/alert_dialog_custom.dart';
import 'package:sugar/src/ui/widgets/drawer.dart';
import 'package:sugar/src/ui/widgets/list_formulario.dart';
import 'package:sugar/src/ui/widgets/form_text_field.dart';
import 'package:flutter/widgets.dart';
import 'package:sugar/src/blocs/login_bloc.dart';
import 'package:sugar/src/services/os_service.dart';
import 'package:sugar/src/models/os_model.dart';
import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:sugar/src/blocs/file_bloc.dart';
import 'package:sugar/src/blocs/produto_bloc.dart';
import 'package:sugar/src/blocs/tipo_acucar_bloc.dart';
import 'package:sugar/src/blocs/tipo_usina_bloc.dart';
import 'package:sugar/src/blocs/usina_bloc.dart';
import 'package:sugar/src/models/breakbulk.dart';
import 'package:sugar/src/models/container.dart' as ContainerModel;
import 'package:sugar/src/models/formulario.dart';
import 'package:sugar/src/models/login_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:encrypt/encrypt.dart' as Encrypt;
import 'package:sugar/src/models/sincronizado.dart';
import 'package:sugar/src/models/sugar_model.dart';
import 'package:sugar/src/models/tipo_acucar.dart';
import 'package:sugar/src/services/login_service.dart';
import 'package:sugar/src/ui/widgets/awasome_dialog.dart';
import 'package:sugar/src/blocs/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sugar/src/ui/home/Home.dart';
import 'package:sugar/src/ui/home/dicas.dart';
import 'package:sugar/src/ui/home/formularioOs.dart';

/// Diego Gomes Barbosa - diego.barbosa.external@sgs.com - 31/01/2020
/// Continuando projeto WebSugar Mobile.

class Formularios extends StatefulWidget {
  @override
  _FormulariosState createState() => _FormulariosState();
}

class _FormulariosState extends State<Formularios> {
  static const String route = '/home';
  BuildDrawer _buildDrawer = BuildDrawer();
  BreakBulk breakBulk = BreakBulk.padrao();
  final blocSugar = BlocProvider.tag('sugarGlobal').getBloc<SugarBloc>();
  final blocTipoFormulario =  BlocProvider.tag('tipoFormulario').getBloc<TipoFormularioBloc>();
  List<BreakBulk> listBreakBulk = [];
  final LoginBloc blocLogin = BlocProvider.tag('sugarGlobal').getBloc<LoginBloc>();
  OsService _osService = OsService();
  String texto01 ="";


  @override
  void initState()
  {
    super.initState();

    setState(() {
      listarOs().then((value){
        texto01 = value;
      });
    });
  }

  Future<String> listarOs() async {
    OsModel dataUser;
    dataUser = await _osService.getOs(login: "admin", senha: "1234", context: context);
    if (dataUser != null)
    {
      return dataUser.nome;
    }
    else
    {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    const logoAfl = AssetImage('assets/images/logo_afl.png');
    int _selectedIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    List<Widget> cards = new List.generate(3, (int i) => new FlatButton(
      textColor: Colors.black,
      color: Colors.white,
      child: Text(texto01 +i.toString()),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FormularioOs()),
        );
      },
    ),);



    return DefaultTabController(
      length: 1,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          drawer: _buildDrawer.buildDrawer(context, route),
          appBar: AppBar(
            title: Text("OGC"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 080, 079, 081),
            bottom:
            TabBar(indicatorColor: Color.fromARGB(255, 243, 112, 33), tabs: [
              Tab(text: "Ordens de Serviços"),
            ]),

          ),
          body:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 650.0,
                  child: new ListView(
                    children: cards,
                    scrollDirection: Axis.vertical,
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );

  }


}
