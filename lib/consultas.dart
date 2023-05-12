import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_pro1_19400568/Bitacora.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Vehiculo.dart';
import 'Bitacora.dart';
import 'basedatos.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class Consultas extends StatefulWidget {
  const Consultas({super.key});
  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  final fechaController = TextEditingController();
  final departamentoController = TextEditingController();
  final consultaResul = TextEditingController();
  final consultaResul2 = TextEditingController();
  final consultaResul3 = TextEditingController();




  /////////////////////////////////////////////////////////////////
  String? _claveDoc;

  Future<DropdownButtonFormField<String>> getDropdownButton() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('vehiculo').get();
    List<DropdownMenuItem<String>> opciones = [];
    snapshot.docs.forEach((doc) {
      String valor = doc.id;
      String texto = doc['placa'];
      opciones.add(
        DropdownMenuItem<String>(
          value: valor,
          child: Text(texto),
          alignment: Alignment.center,
        ),
      );
    });
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
          labelText: "Selecciona por placa",
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.person_outline)
      ),
      value: _claveDoc,
      items: opciones,
      onChanged: (valor) {
        setState(() {
          _claveDoc = valor!;
        });
      },
      icon: Icon(Icons.car_crash_rounded),
    );
  }


  //------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Consultas"), centerTitle: true,),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          FutureBuilder(
            future: getDropdownButton(),
            builder: (BuildContext context, AsyncSnapshot<DropdownButtonFormField<String>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Cargando datos...');
              } else if (snapshot.hasError) {
                return Text('Error al recuperar los datos de la colección');
              } else {
                return snapshot.data!;
              }
            },
          ),
          SizedBox(height: 30,),
          FilledButton(onPressed:() async{
            String resul = await FirestoreDB().consultaBitacora1(_claveDoc!, "vehiculo");
            setState(() {
              consultaResul.text=resul;
            });
          }, child:Text("consultar", style: TextStyle(fontSize: 19),)),
          SizedBox(height: 30,),
          TextField(controller: consultaResul , keyboardType: TextInputType.multiline, maxLines: null),
          SizedBox(height: 40,),

          TextField(
            controller: fechaController,
            decoration: InputDecoration(labelText: "FECHA", border: OutlineInputBorder(), prefixIcon: Icon(Icons.date_range_sharp)),
          ),SizedBox(height: 15,),
          FilledButton(onPressed:() async{
            String resul = await FirestoreDB().consultaBitacora1(fechaController.text, "fecha");
            setState(() {
              consultaResul2.text=resul;
            });
          }, child:Text("consultar", style: TextStyle(fontSize: 19),)),
          SizedBox(height: 30,),
          TextField(controller: consultaResul2 , keyboardType: TextInputType.multiline, maxLines: null),

          SizedBox(height: 40,),

          TextField(
            controller: departamentoController,
            decoration: InputDecoration(labelText: "NOMBRE DEPTO", border: OutlineInputBorder(), prefixIcon: Icon(Icons.home)),
          ),SizedBox(height: 15,),
          FilledButton(onPressed:() async{
            String resul = await FirestoreDB().consultavehiculo1(departamentoController.text, "depto");
            setState(() {
              consultaResul3.text=resul;
            });
          }, child:Text("consultar", style: TextStyle(fontSize: 19),)),
          SizedBox(height: 30,),
          TextField(controller: consultaResul3 , keyboardType: TextInputType.multiline, maxLines: null)
        ],
      ),
    );
  }



}
