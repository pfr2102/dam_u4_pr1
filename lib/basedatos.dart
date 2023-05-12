import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_u4_pro1_19400568/Vehiculo.dart';

import 'Bitacora.dart';
import 'firebase_service.dart';

class FirestoreDB {
  FirebaseFirestore db = FirebaseFirestore.instance;
 /* Future<List<Vehiculo>> consultaTodosVehiculos() async {
    QuerySnapshot snapshot = await db.collection('vehiculo').get();
    // La propiedad 'docs' de un QuerySnapshot nos devuelve una lista de QueryDocumentSnapshot,
    // cada uno de los cuales representa un documento de la colección.
    final List<QueryDocumentSnapshot> documentos = snapshot.docs;
    //convertimos la lista de documentos a una lista de map<string , dynamic>
    final List<Map<String, dynamic>> mapaVehiculos = documentos.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();

    return List.generate(mapaVehiculos.length,
           (index) => Vehiculo(
             combustible: mapaVehiculos[index]['combustible'],
             depto: mapaVehiculos[index]['depto'],
             numeroserie: mapaVehiculos[index]['numeroserie'],
             placa: mapaVehiculos[index]['placa'],
             resguardadopor: mapaVehiculos[index]['resguardadopor'],
             tanque: mapaVehiculos[index]['tanque'],
             tipo: mapaVehiculos[index]['tipo'],
             trabajador: mapaVehiculos[index]['trabajador'],
       ));
  }*/
 /* Future<List<Vehiculo>> consultaTodosVehiculos2() async {
    QuerySnapshot snapshot = await db.collection('vehiculo').get();
    // La propiedad 'docs' de un QuerySnapshot nos devuelve una lista de QueryDocumentSnapshot,
    // cada uno de los cuales representa un documento de la colección.
    final List<QueryDocumentSnapshot> documentos = snapshot.docs;
    return documentos.map((doc) => Vehiculo.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }*/
  /*
  Future<void> insertarVehiculo2(Vehiculo vehiculo) async {
    try {
      // Creamos una nueva referencia para el documento
      DocumentReference documentReference = db.collection('vehiculo').doc(vehiculo.numeroserie);
      // Insertamos los datos en el documento
      await documentReference.set({
        'placa': vehiculo.placa,
        'combustible': vehiculo.combustible,
        'tanque': vehiculo.tanque,
        'depto': vehiculo.depto,
        'resguardadopor': vehiculo.resguardadopor,
        'tipo': vehiculo.tipo,
        'trabajador': vehiculo.trabajador,
      });
    } catch (error) {
      // Manejo de errores
      print(error);
    }
  }*/


  Future<List<Vehiculo>> consultaTodosVehiculos() async {
    QuerySnapshot snapshot = await db.collection('vehiculo').get();
    // La propiedad 'docs' de un QuerySnapshot nos devuelve una lista de QueryDocumentSnapshot,
    // cada uno de los cuales representa un documento de la colección.
    final List<QueryDocumentSnapshot> documentos = snapshot.docs;
    //convertimos la lista de documentos a una lista de map<string , dynamic>
    final List<Map<String, dynamic>> mapaVehiculos = documentos.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();

    return List.generate(mapaVehiculos.length, (index) {
      Vehiculo vehiculo = Vehiculo(
        combustible: mapaVehiculos[index]['combustible'],
        depto: mapaVehiculos[index]['depto'],
        numeroserie: mapaVehiculos[index]['numeroserie'],
        placa: mapaVehiculos[index]['placa'],
        resguardadopor: mapaVehiculos[index]['resguardadopor'],
        tanque: mapaVehiculos[index]['tanque'],
        tipo: mapaVehiculos[index]['tipo'],
        trabajador: mapaVehiculos[index]['trabajador'],
      );
      vehiculo.id = documentos[index].id;
      return vehiculo;
    });
  }


  Future<int> actualizarVehiculo(Vehiculo vehiculo) async {
    try {
      // Obtenemos la referencia del documento que queremos actualizar
      DocumentReference documentReference = db.collection('vehiculo').doc(vehiculo.id.toString());

      // Actualizamos el documento con los nuevos datos
      await documentReference.update({
        'placa': vehiculo.placa,
        'combustible': vehiculo.combustible,
        'tanque': vehiculo.tanque,
        'depto': vehiculo.depto,
        'resguardadopor': vehiculo.resguardadopor,
        'tipo': vehiculo.tipo,
        'trabajador': vehiculo.trabajador,
      });

      return 1;
    } catch (error) {
      // Manejo de errores
      print(error);
      return 0;
    }
  }

  Future<void> eliminarVehiculo(String id) async {
    try {
      // Obtenemos la referencia del documento que queremos eliminar
      DocumentReference documentReference = db.collection('vehiculo').doc(id);
      // Eliminamos el documento
      await documentReference.delete();
    } catch (error) {
      // Manejo de errores
      print(error);
    }
  }

  Future<int> insertarVehiculo(Vehiculo vehiculo) async {
    try {
      // Creamos una nueva referencia para el documento sin especificar un identificador
      DocumentReference documentReference = db.collection('vehiculo').doc();
      // Insertamos los datos en el documento
      await documentReference.set({
        'placa': vehiculo.placa,
        'combustible': vehiculo.combustible,
        'tanque': vehiculo.tanque,
        'depto': vehiculo.depto,
        'resguardadopor': vehiculo.resguardadopor,
        'tipo': vehiculo.tipo,
        'trabajador': vehiculo.trabajador,
        'numeroserie': vehiculo.numeroserie // Guardamos el identificador único del vehículo en el documento
      });
      return 1;
    } catch (error) {
      // Manejo de errores
      print(error);
      return 0;
    }
  }

  ////////////////////////////////////////////METODOS BITACORAS/////////////////////////////////////////////////////
  Future<List<Bitacora>> consultaTodasBitacoras() async {
    QuerySnapshot snapshot = await db.collection('bitacora').get();
    final List<QueryDocumentSnapshot> documentos = snapshot.docs;
    final List<Map<String, dynamic>> mapaBitacoras =
    documentos.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();

    return List.generate(mapaBitacoras.length, (index) {
      Bitacora bitacora = Bitacora(
        evento: mapaBitacoras[index]['evento'],
        fecha: mapaBitacoras[index]['fecha'],
        fechaverificacion: mapaBitacoras[index]['fechaverificacion'],
        recursos: mapaBitacoras[index]['recursos'],
        verifico: mapaBitacoras[index]['verifico'],
        vehiculo: mapaBitacoras[index]['vehiculo'],
      );
      bitacora.id = documentos[index].id;
      return bitacora;
    });
  }

  Future<int> insertarRegistro(Bitacora registro) async {
    try {
       // Creamos una nueva referencia para el documento sin especificar un identificador
      DocumentReference documentReference = db.collection('bitacora').doc();
      // Insertamos los datos en el documento
      await documentReference.set({
        'evento': registro.evento,
        'fecha': registro.fecha,
        'fechaverificacion': registro.fechaverificacion,
        'recursos': registro.recursos,
        'verifico': registro.verifico,
        'vehiculo': registro.vehiculo,
      });
      return 1;
    } catch (error) {
      // Manejo de errores
      print(error);
      return 0;
    }
  }

  Future<int> actualizarBitacora(Bitacora bitacora) async {
    try {
      // Obtenemos la referencia del documento que queremos actualizar
      DocumentReference documentReference = db.collection('bitacora').doc(bitacora.id.toString());
      // Actualizamos el documento con los nuevos datos
      await documentReference.update({
        'evento': bitacora.evento,
        'fecha': bitacora.fecha,
        'fechaverificacion': bitacora.fechaverificacion,
        'recursos': bitacora.recursos,
        'verifico': bitacora.verifico,
        'vehiculo': bitacora.vehiculo,
      });
      return 1;
    } catch (error) {
      // Manejo de errores
      print(error);
      return 0;
    }
  }

  Future<void> eliminarBitacora(String id) async {
    try {
    // Obtenemos la referencia del documento que queremos eliminar
     DocumentReference documentReference = db.collection('bitacora').doc(id);
    // Eliminamos el documento
    await documentReference.delete();
    } catch (error) {
      // Manejo de errores
      print(error);
    }
  }

  //////////////////////////////////////////////////////////////
  /*Future<void> consultaBitacora1()async{
    QuerySnapshot snapshot = await db.collection('bitacora').where('vehiculo', isEqualTo: 'OA8DdEKYxFDwr51kzLqP').get();
    final List<QueryDocumentSnapshot> documentos = snapshot.docs;
    final List<Map<String, dynamic>> mapaBitacoras =
    documentos.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();


  }*/

  Future<String> consultaBitacora1(String id, String campo) async {
    QuerySnapshot snapshot =
    await db.collection('bitacora').where(campo, isEqualTo: id).get();
    final List<QueryDocumentSnapshot> documentos = snapshot.docs;
    final List<Map<String, dynamic>> mapaBitacoras =
    documentos.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();
    // Cadena concatenada de los documentos
    String concatenatedDocuments = '';
    for (var documento in mapaBitacoras) {
      // Concatenar el documento a la cadena
      concatenatedDocuments += "["+documento['evento'].toString()+", "+documento['fecha'].toString()+", "+documento['fechaverificacion'].toString()+']\n';
    }
    // Imprimir la cadena concatenada en la consola
    print(concatenatedDocuments);
    return concatenatedDocuments;
  }


  Future<String> consultavehiculo1(String id, String campo) async {
    QuerySnapshot snapshot =
    await db.collection('vehiculo').where(campo, isEqualTo: id).get();
    final List<QueryDocumentSnapshot> documentos = snapshot.docs;
    final List<Map<String, dynamic>> mapaBitacoras =
    documentos.map<Map<String, dynamic>>((doc) => doc.data() as Map<String, dynamic>).toList();
    // Cadena concatenada de los documentos
    String concatenatedDocuments = '';
    for (var documento in mapaBitacoras) {
      // Concatenar el documento a la cadena
      concatenatedDocuments += "["+documento['placa'].toString()+", "+documento['numeroserie'].toString()+", "+documento['trabajador'].toString()+", "+documento['depto'].toString()+']\n';
    }
    // Imprimir la cadena concatenada en la consola
    print(concatenatedDocuments);
    return concatenatedDocuments;
  }


}



