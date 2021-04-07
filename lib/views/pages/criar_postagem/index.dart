import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tunico/controllers/criar_post_controller.dart';

class CriarPost extends StatefulWidget {
  String idAgenda;

  CriarPost(this.idAgenda);

  @override
  _CriarPostState createState() => _CriarPostState();
}

class _CriarPostState extends State<CriarPost> {
  final _controller = CriarPostController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile _pdfFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Fazer publicação',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15, 30, 15, 0),
              child: TextFormField(
                maxLength: 250,
                maxLines: 7,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: const OutlineInputBorder(),
                ),
                controller: _controller.textoController,
                validator: (text) {
                  if (text.trim().length == 0)
                    return 'Digite algo';
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.65,
                child: FlatButton.icon(
                    onPressed: () async {
                      if (_pdfFile != null){
                        setState(() {
                          _pdfFile = null;
                          _controller.filePath = null;
                        });
                      }
                      else{
                        await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf'],
                        ).then((result) {
                          if (result != null) {
                            setState(() {
                              _pdfFile = result.files.first;
                              _controller.filePath = _pdfFile.path;
                            });
                          }
                        });
                      }
                    },
                    icon: Icon(
                      _pdfFile != null ? Icons.clear : Icons.picture_as_pdf,
                      color: Colors.white,
                    ),
                    label: Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        _pdfFile != null ? _pdfFile.name : 'Adicionar arquivo PDF',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border:
                        Border.all(color: Color.fromRGBO(255, 107, 107, 1)),
                    color: Color.fromRGBO(255, 107, 107, 1)),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 107, 107),
        child: Icon(Icons.send),
        onPressed: () {
          if (!_formKey.currentState.validate()) return;
          _controller.fazerPostagem(context, widget.idAgenda);
        },
      ),
    );
  }
}
