import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:widgets/pages/dados_cadastrais_page.dart';
import 'package:widgets/pages/pagina_1_pagaview.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = new PageController(
      initialPage:
          0); // O page view não faz sua contagem da mesma forma, então é necessario definir um controller
  int posicaoPagina = 0; //
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Meu App"),
          ),
          drawer: _drawer(context),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller:
                      pageController, // definimos o controller do page view
                  onPageChanged: (value) => setState(() {
                    posicaoPagina =
                        value; // agora toda vez que rolarmos a pagina, o variavel posicao da pagina será alterada
                  }),
                  children: [
                    Pagina_1_PageView(),
                    Container(color: Color.fromARGB(255, 19, 166, 239)),
                    Container(color: Color.fromARGB(255, 222, 244, 255)),
                  ],
                ),
              ),
              BottomNavigationBar(
                onTap: (value) => setState(() {
                  pageController.jumpToPage(
                      value); // agora toda vez que clicarmos no item 'home' por exemplo, ele vai pular para a pagina com (1).
                }), // Utilizando a função .jumpToPage no controller definido.
                currentIndex: posicaoPagina,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.turn_left_rounded), label: "left"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: "home"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.turn_right_rounded), label: "right"),
                ],
              )
            ],
          )),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DadosCadastrais()));
              },
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Text("Dados Cadastrais"))),
          Divider(),
          InkWell(
              onTap: () => print("Termos de uso e privacidade"),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Text("Termos de uso e privacidade"))),
          Divider(),
          InkWell(
              onTap: () => print("Configuração"),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: double.infinity,
                  child: Text("Configuração"))),
        ],
      ),
    ));
  }
}
