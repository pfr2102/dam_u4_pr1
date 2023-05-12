import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getVehiculo() async{
  List vehiculo = [];
  CollectionReference collectionReferenceVehiculo = db.collection('vehiculo');
  QuerySnapshot queryVehiculo = await collectionReferenceVehiculo.get();
  queryVehiculo.docs.forEach((documento) {
    vehiculo.add(documento.data());
  });
  return vehiculo;
}