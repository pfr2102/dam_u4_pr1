import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Vehiculo.dart';
import 'basedatos.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Vehiculo> todosVehiculos = [];

  void actualizarLista() async {
    List<Vehiculo> temporal = await FirestoreDB().consultaTodosVehiculos();
    setState(() {
      todosVehiculos = temporal;
    });
  }

  @override
  void initState() {
    super.initState();
    actualizarLista();
  }
  //------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Administrar Coches"),)),
      body: ListView.builder(
          itemCount: todosVehiculos.length,
          itemBuilder: (itemBuilder, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> CapturarActualizarCoche(vehiculo: todosVehiculos[index] ,onUpdate: actualizarLista)));
              },
              onLongPress: (){ mostrarAlerta(index);},
              child:Container(
                decoration: BoxDecoration( border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)) ),
                child: ListTile(
                  leading: Icon(Icons.app_registration),
                  title: Text(todosVehiculos[index].trabajador.toString(), style: TextStyle(fontSize: 20, color: Colors.black)),
                  subtitle: Text(todosVehiculos[index].tipo.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(Icons.numbers),
                      Text(todosVehiculos[index].numeroserie.toString(), style: TextStyle(fontSize: 15, color: Colors.black),),
                    ],
                  ),
                ),
              ),
              /*ListTile(
                  title: Text(todosVehiculos[index].id.toString(), style: TextStyle(fontSize: 20),),
                  subtitle: Text(todosVehiculos[index].tipo.toString(), style: TextStyle(fontSize: 15),),
                  trailing: Text(todosVehiculos[index].trabajador.toString(), style: TextStyle(fontSize: 25),)
              ),*/
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=> CapturarActualizarCoche(onInsert: actualizarLista)));
        },
        child: Icon(Icons.car_rental),
      ),
    );
  }

  void mostrarAlerta(int index) {
    showDialog(context: context, builder: (builder){
      return AlertDialog(
        title: Text("ACCIONES"),
        content: Text("¿ESTAS SEGURO DE QUERER ELIMINAR A ${todosVehiculos[index].placa}"),
        actions: [
          TextButton(onPressed: (){
            //if(todosVehiculos[index].placa != null) {
            FirestoreDB().eliminarVehiculo(todosVehiculos[index].id.toString()).then((value) => actualizarLista());
            //}
            Navigator.of(context).pop();
          }, child: Text("SI")),
          TextButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("NO")),
        ],
      );
    });
  }

}


///////////////////////////////////////////////////////////////////////////////////////////////////
class CapturarActualizarCoche extends StatefulWidget {
  final Vehiculo? vehiculo;
  final void Function()? onInsert;
  final void Function()? onUpdate;

  CapturarActualizarCoche({Key? key, this.vehiculo = null, this.onInsert, this.onUpdate}) : super(key: key);

  @override
  _CapturarActualizarCocheState createState() => _CapturarActualizarCocheState();
}

class _CapturarActualizarCocheState extends State<CapturarActualizarCoche> {
  final placaController = TextEditingController();
  final numeroSerieController = TextEditingController();
  final combustibleController = TextEditingController();
  final deptoController = TextEditingController();
  final resguardadoporController = TextEditingController();
  final tanqueController = TextEditingController();
  final tipoController = TextEditingController();
  final trabajadorController = TextEditingController();


  bool get isUpdating => widget.vehiculo != null;

  @override
  void initState() {
    super.initState();
    if (isUpdating) {
      placaController.text = widget.vehiculo!.placa ?? '';
      numeroSerieController.text = widget.vehiculo!.numeroserie ?? '';
      combustibleController.text = widget.vehiculo!.combustible ?? '';
      deptoController.text = widget.vehiculo!.depto ?? '';
      resguardadoporController.text = widget.vehiculo!.resguardadopor ?? '';
      tanqueController.text = widget.vehiculo!.tanque.toString() ?? '';
      tipoController.text = widget.vehiculo!.tipo ?? '';
      trabajadorController.text = widget.vehiculo!.trabajador ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isUpdating ? "ACTUALIZAR COCHE" : "CAPTURAR COCHE")),
      body: ListView(
        padding: EdgeInsets.all(40),
        children: [
          if (isUpdating)
            Text(
              'PLACA: ${placaController.text}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          if(!isUpdating)
            TextField(
              controller: placaController,
              decoration: InputDecoration(labelText: "PLACA", border: OutlineInputBorder(), prefixIcon: Icon(Icons.abc_outlined)),
            ),SizedBox(height: 15,),
          TextField(
            controller: numeroSerieController,
            decoration: InputDecoration(labelText: "NÚMERO DE SERIE", border: OutlineInputBorder(), prefixIcon: Icon(Icons.car_rental_outlined)),
          ),SizedBox(height: 15,),
          TextField(
            controller: combustibleController,
            decoration: InputDecoration(labelText: "COMBUSTIBLE", border: OutlineInputBorder(), prefixIcon: Icon(Icons.car_repair_outlined)),
          ),SizedBox(height: 15,),
          TextField(
            controller: deptoController,
            decoration: InputDecoration(labelText: "DEPARTAMENTO", border: OutlineInputBorder(), prefixIcon: Icon(Icons.account_balance_rounded)),
          ),SizedBox(height: 15,),
          TextField(
            controller: resguardadoporController,
            decoration: InputDecoration(labelText: "RESGUARDADO POR", border: OutlineInputBorder(), prefixIcon: Icon(Icons.accessibility_outlined)),
          ),SizedBox(height: 15,),
          TextField(
            controller: tanqueController,
            decoration: InputDecoration(labelText: "TANQUE", border: OutlineInputBorder(), prefixIcon: Icon(Icons.numbers)),
            keyboardType: TextInputType.number,
          ),SizedBox(height: 15,),
          TextField(
            controller: tipoController,
            decoration: InputDecoration(labelText: "TIPO", border: OutlineInputBorder(), prefixIcon: Icon(Icons.car_repair_rounded)),
          ),SizedBox(height: 15,),
          TextField(
            controller: trabajadorController,
            decoration: InputDecoration(labelText: "TRABAJADOR", border: OutlineInputBorder(), prefixIcon: Icon(Icons.accessibility)),
          ),
          SizedBox(height: 30,),
          FilledButton(
            onPressed: () async {
              Vehiculo vehiculo = Vehiculo(
                placa: placaController.text.trim(),
                numeroserie: numeroSerieController.text.trim(),
                combustible: combustibleController.text.trim(),
                depto: deptoController.text.trim(),
                resguardadopor: resguardadoporController.text.trim(),
                tanque: int.tryParse(tanqueController.text),
                tipo: tipoController.text.trim(),
                trabajador: trabajadorController.text.trim(),
              );
              if (isUpdating) {
                vehiculo.id = widget.vehiculo!.id;
                int filasAfectadas = await FirestoreDB().actualizarVehiculo(vehiculo);
                if (filasAfectadas > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE ACTUALIZÓ!")));
                  widget.onUpdate!();
                  Navigator.pop(context);
                }
              } else {
                int filasAfectadas = await FirestoreDB().insertarVehiculo(vehiculo);
                if (filasAfectadas > 0) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE INSERTÓ!")));
                  widget.onInsert!();
                  Navigator.pop(context);
                }
              }
            },
              child: Padding( padding: EdgeInsets.all(9.0), child:Text(isUpdating ? "Actualizar" : "Guardar", style: TextStyle(fontSize: 20)),)
          ),

        ],
      ),
    );
  }
}