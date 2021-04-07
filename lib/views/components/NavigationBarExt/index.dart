import 'package:flutter/material.dart';
import 'package:tunico/routes/app_routes.dart';

class NavigationBarExt extends StatelessWidget{
  String paginaAtual;
  
  NavigationBarExt({this.paginaAtual});

  Widget build(BuildContext context){

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          title: Text('home'),
          icon: IconButton(
            icon: Icon(Icons.home, color: paginaAtual == 'home' ? Colors.deepOrange[300] : Colors.grey),
            onPressed: () {
              if (paginaAtual != 'home')
                Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            })),

        BottomNavigationBarItem(
          title: Text('pesquisar'),
          icon: IconButton(
            icon: Icon(Icons.search, color: paginaAtual == 'pesquisar' ? Colors.deepOrange[300] : Colors.grey),
            onPressed: () {
              if (paginaAtual != 'pesquisar')
                Navigator.of(context).pushReplacementNamed(AppRoutes.PESQUISAR_AGENDAS);
            })),

        BottomNavigationBarItem(
          title: Text('nova agenda'),
          icon: IconButton(
            icon: Icon(Icons.add, color: paginaAtual == 'nova agenda' ? Colors.deepOrange[300] : Colors.grey),
            onPressed: () {
              if (paginaAtual != 'nova agenda')
                Navigator.of(context).pushReplacementNamed(AppRoutes.CRIAR_AGENDA);
            })),

        BottomNavigationBarItem(
          title: Text('perfil'),
          icon: IconButton(
            icon: Icon(Icons.person, color: paginaAtual == 'perfil' ? Colors.deepOrange[300] : Colors.grey),
            onPressed: () {
              if (paginaAtual != 'perfil')
                Navigator.of(context).pushReplacementNamed(AppRoutes.PERFIL_USUARIO);
            })),
      ],
    );
  }
}