import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tunico/controllers/criar_agenda_controller.dart';
import 'package:tunico/views/components/FlatButtonExt/index.dart';
import 'package:tunico/views/components/NavigationBarExt/index.dart';
import 'package:tunico/views/components/TextFormFieldExt/index.dart';
import 'package:tunico/views/components/foto_convert.dart';

class CriarAgendaPage extends StatefulWidget {
  @override
  _CriarAgendaPageState createState() => _CriarAgendaPageState();
}

class _CriarAgendaPageState extends State<CriarAgendaPage> {
  final _formKey = GlobalKey<FormState>();
  final imagePicker = ImagePicker();
  final _controller = CriarAgendaController();
  final _checkBoxFormKey = GlobalKey<FormState>();
  bool valid = false;
  DateTime validade;

  @override
  void initState() {
    super.initState();
    validade = DateTime.now().add(new Duration(days: 1));
  }

  @override
  Widget build(BuildContext context) {
    String dataStr = validade.toIso8601String();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('Criar Agenda', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: ClipOval(
                            child: FotoConvert().retornaFoto(
                              _controller.fotoController.text,
                              grupo: true
                            ),
                          )
                        ),
                      ),
                      Center(
                        child: Container(
                          color: Colors.transparent,
                          width: 250,
                          height: 190,
                          child: Align(
                            alignment: Alignment.topRight,
                            child: PopupMenuButton<int>(
                              itemBuilder: (context) => <PopupMenuEntry<int>>[
                                const PopupMenuItem<int>(
                                  child: Text('Câmera'),
                                  value: 0,
                                ),
                                const PopupMenuItem<int>(
                                  child: Text('Galeria'),
                                  value: 1,
                                )
                              ],
                              onSelected: (valor) async {
                                final fotoSelecionada =
                                    await imagePicker.getImage(
                                        source: (valor == 0
                                            ? ImageSource.camera
                                            : ImageSource.gallery));
                                setState(() {
                                  if (fotoSelecionada == null) return;
                                  _controller.fotoController.text =
                                      fotoSelecionada.path;
                                });
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: TextFormFieldExt(
                      labelText: 'Nome da agenda',
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(Icons.edit,
                          color: Color.fromRGBO(255, 148, 88, 1)),
                      maxLenght: 25,
                      controller: _controller.nomeController,
                      validator: (text) {
                        if (text.trim().length == 0)
                          return 'Nome não informado';
                      }),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormFieldExt(
                      labelText: 'Descrição',
                      keyboardType: TextInputType.text,
                      prefixIcon: Icon(Icons.description,
                          color: Color.fromRGBO(255, 148, 88, 1)),
                      maxLenght: 180,
                      maxLines: 3,
                      controller: _controller.descricaoController,
                      validator: (text) {
                        if (text.trim().length == 0)
                          return 'Descrição não informada';
                      }),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    children: [
                      Checkbox(
                        key: _checkBoxFormKey,
                        value: valid,
                        activeColor: Colors.orange[600],
                        onChanged: (value) {
                          setState(() {
                            valid = !valid;
                            print(valid);
                          });
                        },
                      ),
                      Text(
                        'Definir validade',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 16
                        ),
                      )
                    ],
                  )
                ),
                if (valid)
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                          child: Text(
                            "${dataStr.substring(8, 10)}/${dataStr.substring(5, 7)}/${dataStr.substring(0, 4)}",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          onPressed: _pickDate,
                        ),
                        FlatButton(
                          child: Text(
                            "${dataStr.substring(11, 19)}",
                            style: TextStyle(
                              color: Colors.black45,
                            ),
                          ),
                          onPressed: _pickTime,
                        ),
                      ]
                    )
                  ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: TextFormFieldExt(
                    labelText: 'Senha (opcional)',
                    keyboardType: TextInputType.text,
                    prefixIcon: Icon(Icons.vpn_key,
                        color: Color.fromRGBO(255, 148, 88, 1)),
                    maxLenght: 15,
                    maxLines: 1,
                    obscureText: true,
                    controller: _controller.senhaController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                  child: FlatButtonExt(
                    text: 'Criar nova agenda',
                    onPressed: () {
                      if (!_formKey.currentState.validate()) return;
                      if (valid)
                        _controller.criarAgenda(context, validade: validade);
                      else
                        _controller.criarAgenda(context);
                    },
                  ),
                )
              ],
            )),
      ),
      bottomNavigationBar: NavigationBarExt(paginaAtual: 'nova agenda'),
    );
  }
  _pickDate() async{
    DateTime date = await showDatePicker(
      context: context,
       firstDate: DateTime(DateTime.now().year-5), 
       lastDate: DateTime(DateTime.now().year+5),
       initialDate: validade,
       );
       if (date != null)
       setState(() {
         DateTime aux = DateTime(date.year, date.month, date.day, validade.hour, validade.minute, validade.second);
         validade = aux;
       });
  }

  _pickTime() async{
    TimeOfDay t = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(validade)
    );
    if (t != null)
      setState(() {
        DateTime aux = DateTime(validade.year, validade.month, validade.day, t.hour, t.minute, validade.second);
        print(aux.toIso8601String());
        validade = aux;
      });
  }
}