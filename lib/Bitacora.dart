class Bitacora {
  String? id;
  String? evento;
  String? fecha;
  String? fechaverificacion;
  String? recursos;
  String? verifico;
  String? vehiculo;

  // Constructor
  Bitacora({
    this.id,
    this.evento,
    this.fecha,
    this.fechaverificacion,
    this.recursos,
    this.verifico,
    this.vehiculo
  });

  // Convert Bitacora object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'evento': evento,
      'fecha': fecha,
      'fechaverificacion': fechaverificacion,
      'recursos': recursos,
      'verifico': verifico,
      'vehiculo': vehiculo,
    };
  }

  // Create a Bitacora object from a Map
  factory Bitacora.fromMap(Map<String, dynamic> map) {
    return Bitacora(
      id: map['id'],
      evento: map['evento'],
      fecha: map['fecha'],
      fechaverificacion: map['fechaverificacion'],
      recursos: map['recursos'],
      verifico: map['verifico'],
      vehiculo: map['vehiculo'],
    );
  }

  @override
  String toString() {
    return 'Bitacora{id: $id, evento: $evento, fecha: $fecha, fechaverificacion: $fechaverificacion, '
        'recursos: $recursos, verifico: $verifico, vehiculo: $vehiculo}';
  }
}
