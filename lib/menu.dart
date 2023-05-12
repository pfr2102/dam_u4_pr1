import 'package:dam_u4_pro1_19400568/programaBitacora.dart';
import 'package:dam_u4_pro1_19400568/programaVehiculo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'consultas.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  //ATRIBUTOS
  int _indice = 0;

  void cambiarPagina(int indice){
    setState(() {
      _indice = indice;
    });
  }

  final List<Widget>_paginas = [
    MyHomePage(title: "xd"),
    PrograBitacora(),
    Consultas()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _paginas[_indice],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.car_crash_sharp), label: "Vehiculo"),
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner_outlined), label: "Bitacora"),
          BottomNavigationBarItem(icon: Icon(Icons.integration_instructions_rounded), label: "Consultas"),
        ],
        iconSize: 25,
        currentIndex: _indice,
        onTap: cambiarPagina ,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
      ),
    );
  }
}
