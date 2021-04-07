import 'package:flutter/material.dart';
import 'package:tunico/controllers/home_controller.dart';
import 'package:tunico/views/components/NavigationBarExt/index.dart';
import 'package:tunico/views/components/TextFormFieldExt/index.dart';
import 'package:tunico/views/components/card_agendas/index.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = new HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Minhas Agendas', style: TextStyle(color: Colors.white)),
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
                    if (_controller.agendas == null || _controller.agendas == [] || _controller.agendas.length == 0)
                      if(_controller.pesquisaController.text != '')
                        return Center(
                          child: Text("Nenhuma agenda encontrada"),
                        );
                      else
                        return Center(
                          child: Text("Você não pertence a nenhuma agenda"),
                        );
                    return ListView.builder(
                      itemCount: _controller.agendas.length,
                      itemBuilder: (context, index) {
                        var agenda = _controller.agendas[index];
                        return CardAgenda(
                          image: Image.network(agenda.foto),
                          nome: agenda.nome,
                          descricao: agenda.descricao,
                          id: agenda.id,
                          foto: agenda.foto,
                          ingressarAgenda: false,
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

      bottomNavigationBar: NavigationBarExt(paginaAtual: 'home'),
    );
  }
}
