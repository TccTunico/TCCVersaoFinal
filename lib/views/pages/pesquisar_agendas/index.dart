import 'package:flutter/material.dart';
import 'package:tunico/controllers/pesquisar_agendas_controller.dart';
import 'package:tunico/views/components/NavigationBarExt/index.dart';
import 'package:tunico/views/components/TextFormFieldExt/index.dart';
import 'package:tunico/views/components/card_agendas/index.dart';

class PesquisarAgendasPage extends StatefulWidget {
  @override
  _PesquisarAgendasPageState createState() => _PesquisarAgendasPageState();
}

class _PesquisarAgendasPageState extends State<PesquisarAgendasPage> {
  final _controller = new PesquisarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text('Procurar Agenda', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextFormFieldExt(
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icon(Icons.search),
              labelText: 'Pesquisar',
              controller: _controller.pesquisaController,
              onChanged: (_controller) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: FutureBuilder(
                future: _controller.atualizarItens(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_controller.agendas == null || _controller.agendas == [] || _controller.agendas.length == 0){
                      return Center(
                        child: Text("Nenhuma agenda encontrada"),
                      );
                    }
                    return ListView.builder(
                      itemCount: _controller.agendas.length,
                      itemBuilder: (context, index) {
                        if (_controller.agendas.length == 0 || _controller.agendas == null){
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Text("Não há nehuma agenda para ingressar"),
                            ),
                          );
                        }
                        var agenda = _controller.agendas[index];
                        return CardAgenda(
                          image: Image.network(agenda.foto),
                          nome: agenda.nome,
                          descricao: agenda.descricao,
                          id: agenda.id,
                          foto: agenda.foto,
                          ingressarAgenda: true,
                        );
                      }
                    );
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(255, 148, 88, 1)),
                      )
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: NavigationBarExt(paginaAtual: 'pesquisar'),
    );
  }
}