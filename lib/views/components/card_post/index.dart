import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tunico/data/providers/mobile_pdf.dart';
import 'package:tunico/views/components/foto_convert.dart';

class CardPost extends StatefulWidget {
  String userFoto;
  String userNome;
  String urlPath;
  DateTime data;
  String texto;

  CardPost({
    this.userFoto,
    this.userNome,
    this.urlPath,
    this.data,
    this.texto,
  });
  @override
  _CardPostState createState() => _CardPostState();
}

class _CardPostState extends State<CardPost> {
  String pathPDF = "";

  String mostrarData(){
    Duration dife = DateTime.now().difference(widget.data);
    if (dife.inMinutes < 1)
      return 'Agora';
    if (dife.inHours < 1)
      return 'Há ${dife.inMinutes} minutos atrás';
    if (dife.inDays < 1)
      return 'Há ${dife.inHours} horas atrás';
    if (dife.inDays == 1)
      return 'Ontem';
    return 'Há ${dife.inDays} dias atrás';
  }
  
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Color.fromARGB(200, 255, 107, 107))
        ),
        elevation: 0,
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    width: 30,
                    height: 30,
                    child: ClipOval(
                      child: FotoConvert().retornaFoto(widget.userFoto)
                    )
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 90,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userNome,
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                      ),
                      Text(
                        mostrarData(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.texto,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.urlPath != null && widget.urlPath != '')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.indigo[100]),
                      ),
                      child: FlatButton.icon(
                        onPressed: () async {
                          await LaunchFile.createFileFromPdfUrl(widget.urlPath)
                              .then((f) => setState(() {
                                    if (f is File) pathPDF = f.path;
                                  }));
                          LaunchFile.launchPDF(context, "Visualizador de PDF",
                              pathPDF, widget.urlPath);
                        },
                        icon: Icon(
                          Icons.picture_as_pdf,
                          color: Colors.blue[600],
                        ),
                        label: Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            widget.urlPath.split('2F').last.substring(12).split('.pdf').first,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[600],
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
