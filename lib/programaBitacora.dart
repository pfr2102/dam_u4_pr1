import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_pro1_19400568/Bitacora.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Vehiculo.dart';
import 'Bitacora.dart';
import 'basedatos.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class PrograBitacora extends StatefulWidget {
  const PrograBitacora({super.key});
  @override
  State<PrograBitacora> createState() => _PrograBitacoraState();
}

class _PrograBitacoraState extends State<PrograBitacora> {
  List<Bitacora> todosBitacoras = [];

  void actualizarLista() async {
    List<Bitacora> temporal = await FirestoreDB().consultaTodasBitacoras();
    setState(() {
      todosBitacoras = temporal;
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
      appBar: AppBar(title: Center(child: Text("Administrar Bitacoras")),),
      body: ListView.builder(
          itemCount: todosBitacoras.length,
          itemBuilder: (itemBuilder, index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (builder)=> CapturarActualizarBitacora(bitacora: todosBitacoras[index] ,onUpdate: actualizarLista)));
              },
              onLongPress: (){ mostrarAlerta(index);},
              child: Container(
                decoration: BoxDecoration( border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)) ),
                child:ListTile(
                    leading: Icon(Icons.app_registration),
                    title: Text(todosBitacoras[index].evento.toString(), style: TextStyle(fontSize: 20),),
                    subtitle: Text(todosBitacoras[index].fecha.toString(), style: TextStyle(fontSize: 15),),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.date_range,),
                        Text(todosBitacoras[index].fechaverificacion.toString(), style: TextStyle(fontSize: 15),)
                      ],
                    ),
                ),
              )
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=> CapturarActualizarBitacora(onInsert: actualizarLista)));
        },
        child: Icon(Icons.document_scanner_sharp),
      ),
    );
  }

  void mostrarAlerta(int index) {
    showDialog(context: context, builder: (builder){
      return AlertDialog(
        title: Text("ACCIONES"),
        content: Text("¿ESTAS SEGURO DE QUERER ELIMINAR A ${todosBitacoras[index].id}"),
        actions: [
          TextButton(onPressed: (){
            //if(todosVehiculos[index].placa != null) {
            FirestoreDB().eliminarBitacora(todosBitacoras[index].id.toString()).then((value) => actualizarLista());
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
class CapturarActualizarBitacora extends StatefulWidget {
  final Bitacora? bitacora;
  final void Function()? onInsert;
  final void Function()? onUpdate;

  CapturarActualizarBitacora({Key? key, this.bitacora = null, this.onInsert, this.onUpdate}) : super(key: key);

  @override
  _CapturarActualizarBitacoraState createState() => _CapturarActualizarBitacoraState();
}

class _CapturarActualizarBitacoraState extends State<CapturarActualizarBitacora> {
  final eventoController = TextEditingController();
  final fechaController = TextEditingController();
  final fechaVerificacionController = TextEditingController();
  final recursosController = TextEditingController();
  final verificoController = TextEditingController();
  final vehiculoController = TextEditingController();

  bool get isUpdating => widget.bitacora != null;

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
/////////////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
    if (isUpdating) {
      eventoController.text = widget.bitacora!.evento ?? '';
      fechaController.text = widget.bitacora!.fecha ?? '';
      fechaVerificacionController.text = widget.bitacora!.fechaverificacion ?? '';
      recursosController.text = widget.bitacora!.recursos ?? '';
      verificoController.text = widget.bitacora!.verifico ?? '';
      _claveDoc = widget.bitacora!.vehiculo ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isUpdating ? "ACTUALIZAR BITÁCORA" : "CAPTURAR BITÁCORA")),
      body: ListView(
          padding: EdgeInsets.all(30),
          children: [
            if(!isUpdating)
                TextField(
                   controller: eventoController,
                   decoration: InputDecoration(labelText: "EVENTO", border: OutlineInputBorder(), prefixIcon: Icon(Icons.event)),
                ),SizedBox(height: 15,),
            if(!isUpdating)
                TextField(
                   controller: fechaController,
                   decoration: InputDecoration(labelText: "FECHA", border: OutlineInputBorder(), prefixIcon: Icon(Icons.calendar_today_outlined)),
                ),SizedBox(height: 15,),
                TextField(
                   controller: fechaVerificacionController,
                   decoration: InputDecoration(labelText: "FECHA DE VERIFICACIÓN", border: OutlineInputBorder(), prefixIcon: Icon(Icons.calendar_view_day_outlined)),
                ),SizedBox(height: 15,),
            if(!isUpdating)
                TextField(
                   controller: recursosController,
                   decoration: InputDecoration(labelText: "RECURSOS", border: OutlineInputBorder(), prefixIcon: Icon(Icons.folder_open)),
                ),SizedBox(height: 15,),
                TextField(
                   controller: verificoController,
                   decoration: InputDecoration(labelText: "VERIFICÓ", border: OutlineInputBorder(), prefixIcon: Icon(Icons.person_outline)),
                ),SizedBox(height: 15,),
            if(!isUpdating)
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

                /*TextField(
                   controller: vehiculoController,
                   decoration: InputDecoration(labelText: "VEHÍCULO", border: OutlineInputBorder(), prefixIcon: Icon(Icons.directions_car)),
                ),*/
                SizedBox(height: 30,),
                FilledButton(
                onPressed: () async {
                  Bitacora bitacora = Bitacora(
                    evento: eventoController.text.trim(),
                    fecha: fechaController.text.trim(),
                    fechaverificacion: fechaVerificacionController.text.trim(),
                    recursos: recursosController.text.trim(),
                    verifico: verificoController.text.trim(),
                    vehiculo:_claveDoc,
                  );
                  if (isUpdating) {
                    bitacora.id = widget.bitacora!.id;
                    int filasAfectadas = await FirestoreDB().actualizarBitacora(bitacora);
                    if (filasAfectadas > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE ACTUALIZÓ!")));
                      widget.onUpdate!();
                      Navigator.pop(context);
                    }
                  } else {
                    int filasAfectadas = await FirestoreDB().insertarRegistro(bitacora);
                    if (filasAfectadas > 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("SE INSERTÓ!")));
                      widget.onInsert!();
                      Navigator.pop(context);
                    }
                  }
                },
                  child: Padding( padding: EdgeInsets.all(9.0), child:Text(isUpdating ? "ACTUALIZAR" : "GUARDAR", style: TextStyle(fontSize: 20)),)
                ),
          ],
      ),
    );
  }
}






/*
class CapturarActualizarBitacora extends StatefulWidget {
  final Bitacora? bitacora;
  final void Function()? onInsert;
  final void Function()? onUpdate;

  CapturarActualizarBitacora({Key? key, this.bitacora = null, this.onInsert, this.onUpdate}) : super(key: key);

  @override
  _CapturarActualizarBitacoraState createState() => _CapturarActualizarBitacoraState();
}

class _CapturarActualizarBitacoraState extends State<CapturarActualizarBitacora> {
  final placaController = TextEditingController();
  final numeroSerieController = TextEditingController();
  final combustibleController = TextEditingController();
  final deptoController = TextEditingController();
  final resguardadoporController = TextEditingController();
  final tanqueController = TextEditingController();
  final tipoController = TextEditingController();
  final trabajadorController = TextEditingController();


  bool get isUpdating => widget.bitacora != null;

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
        padding: EdgeInsets.all(30),
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
            child: Text(isUpdating ? "ACTUALIZAR" : "GUARDAR", style: TextStyle(fontSize: 20)),
          ),

        ],
      ),
    );
  }
}
*/


/*
class _CapturarActualizarBitacoraState extends State<CapturarActualizarBitacora> {
  final eventoController = TextEditingController();
  final fechaController = TextEditingController();
  final fechaVerificacionController = TextEditingController();
  final recursosController = TextEditingController();
  final verificoController = TextEditingController();
  final vehiculoController = TextEditingController();

  bool get isUpdating => widget.bitacora != null;

  @override
  void initState() {
    super.initState();
    if (isUpdating) {
      eventoController.text = widget.bitacora!.evento ?? '';
      fechaController.text = widget.bitacora!.fecha ?? '';
      fechaVerificacionController.text = widget.bitacora!.fechaverificacion ?? '';
      recursosController.text = widget.bitacora!.recursos ?? '';
      verificoController.text = widget.bitacora!.verifico ?? '';
      vehiculoController.text = widget.bitacora!.vehiculo ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isUpdating ? "ACTUALIZAR BITÁCORA" : "CAPTURAR BITÁCORA")),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          if (isUpdating)
            Text(
              'EVENTO: ${eventoController.text}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          if(!isUpdating)
            TextField(
              controller: eventoController,
              decoration: InputDecoration(labelText: "EVENTO", border: OutlineInputBorder(), prefixIcon: Icon(Icons.event)),
            ),SizedBox(height: 15,),
          TextField(
            controller: fechaController,
            decoration: InputDecoration(labelText: "FECHA", border: OutlineInputBorder(), prefixIcon: Icon(Icons.calendar_today_outlined)),
          ),SizedBox(height: 15,),
          TextField(
            controller: fechaVerificacionController,
            decoration: InputDecoration(labelText: "FECHA DE VERIFICACIÓN", border: OutlineInputBorder(), prefixIcon: Icon(Icons.calendar_view_day_outlined)),
          ),SizedBox(height: 15,),
          TextField(
            controller: recursosController,
            decoration: InputDecoration(labelText: "RECURSOS", border: OutlineInputBorder(), prefixIcon: Icon(Icons.folder_open)),
          ),SizedBox(height: 15,),
          TextField(
            controller: verificoController,
            decoration: InputDecoration(labelText: "VERIFICÓ", border: OutlineInputBorder(), prefixIcon: Icon(Icons.person_outline)),
          ),SizedBox(height: 15,),
          TextField(
            controller: vehiculoController,
            decoration: InputDecoration(labelText: "VEHÍCULO", border: OutlineInputBorder(), prefixIcon: Icon(Icons.directions_car)),
          ),
          SizedBox(height: 30,),
          FilledButton(
            onPressed: () async {
              Bitacora bitacora = Bitacora(
                evento: eventoController.text.trim(),
                fecha: fechaController.text.trim(),
                fechaverificacion: fechaVerificacionController.text.trim(),
                recursos: recursosController.text.trim(),
                verifico: verificoController.text.trim(),
                vehiculo:vehiculoController.text.trim(),
              );
              bool result = await bitacoraProvider.insertBitacora(bitacora);
              if (result) {
                Navigator.pop(context, true);
              } else {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Error'),
                    content: Text('Error al guardar la bitácora'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cerrar'),
                      )
                    ],
                  ),
                );
              }
            },
            child: Text('Guardar'),
          ),
        ],
      ),
    );
  }
}


*/