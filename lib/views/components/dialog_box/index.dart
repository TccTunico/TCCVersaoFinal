import 'package:flutter/material.dart';
import 'package:tunico/views/components/TextFormFieldExt/index.dart';

class DialogBox {
  void showOK(BuildContext context,
      {@required String titulo, @required String texto}) {
    var btnOK = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    var alerta = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning),
          SizedBox(
            width: 5,
          ),
          Text(texto)
        ],
      ),
      content: Text(titulo),
      actions: [
        btnOK,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  void showWarning(BuildContext context,
      {@required String titulo, @required String texto}) {
    var btnOK = FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.of(context).pop();
        });

    var alerta = AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning),
          SizedBox(
            width: 5,
          ),
          Text(titulo)
        ],
      ),
      content: Text(texto),
      actions: [
        btnOK,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  String showConfirm( BuildContext context, { @required String titulo, @required String texto}) {
    final _formKey = GlobalKey<FormState>();
    final _senhaController = TextEditingController();
    String senha;

    var btnSim = FlatButton(
      child: Text("Apagar"),
      onPressed: () {
        senha = _senhaController.text;
        Navigator.pop(context);
      }
    );

    var alerta = AlertDialog(
      title: Column(
        children: [
          Row(
            children: [
              Icon(Icons.question_answer),
              SizedBox(
                width: 5,
              ),
              Text(titulo)
            ],
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormFieldExt(
                labelText: 'Senha',
                keyboardType: TextInputType.text,
                prefixIcon: Icon(
                  Icons.vpn_key,
                  color: Color.fromRGBO(255, 148, 88, 1),
                ),
                obscureText: true,
                controller: _senhaController,
                validator: (text) {
                  if (text.trim().length == 0)
                    return 'Senha não informada';
                }
              ),
            ),
          )
        ],
      ),
      content: Text(texto),
      actions: [btnSim],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
    return senha;
  }
}