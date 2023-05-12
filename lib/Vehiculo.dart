class Vehiculo {
  String? id;
  String? combustible;
  String? depto;
  String? numeroserie;
  String? placa;
  String? resguardadopor;
  int? tanque;
  String? tipo;
  String? trabajador;
  //List<Bitacora>? bitacora;

//CONSTRUCTOR
  Vehiculo({
    this.id,
    this.combustible,
    this.depto,
    this.numeroserie,
    this.placa,
    this.resguardadopor,
    this.tanque,
    this.tipo,
    this.trabajador
  });

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'combustible':combustible,
      'depto':depto,
      'numeroserie':numeroserie,
      'placa':placa,
      'resguardadopor':resguardadopor,
      'tanque':tanque,
      'tipo':tipo,
      'trabajador':trabajador,
      //'bitacora': bitacora?.map((bit) => bit.toMap()).toList(),
    };
  }

  factory Vehiculo.fromMap(Map<String, dynamic> map) {
    return Vehiculo(
        id:map['id'],
        combustible: map['combustible'],
        depto: map['depto'],
        numeroserie: map['numeroserie'],
        placa: map['placa'],
        resguardadopor: map['resguardadopor'],
        tanque: map['tanque'],
        tipo: map['tipo'],
        trabajador: map['trabajador'],
    );
  }

@override
  String toString() {
    return 'Vehiculo{id: $id, combustible: $combustible, depto: $depto, numeroserie: $numeroserie, '
        'placa: $placa, resguardadopor: $resguardadopor, tanque: $tanque, '
        'tipo: $tipo, trabajador: $trabajador}';
  }

}

