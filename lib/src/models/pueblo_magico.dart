class PuebloMagicoListado{

  List<PuebloMagico> pueblosMagicos = new List();

  PuebloMagicoListado.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item){
      final puebloMagico = new PuebloMagico.fromJsonMap(item);
      pueblosMagicos.add(puebloMagico);
    }); 
  }

}

class PuebloMagico{
  int pk;
  String nombre;
  String descripcion;
  String estado;
  // String lat;
  // String lon;
  String status;

  PuebloMagico({
    this.pk,
    this.nombre,
    this.descripcion,
    this.estado,
    // this.lat,
    // this.lon,
    this.status
  });

  PuebloMagico.fromJsonMap(Map<String, dynamic> jsonMap){
    pk  = jsonMap['pk'];
    nombre = jsonMap['nombre'];
    descripcion = jsonMap['descripcion'];
    estado = jsonMap['estado'];
    // lat = jsonMap['lat'];
    // lon = jsonMap['lon'];
    status = jsonMap['status'];
  }

  
}