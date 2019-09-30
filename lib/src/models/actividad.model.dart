class ActividadList{
  List<Actividad> actividades = new List();
  ActividadList.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null ) return;
    jsonList.forEach((item){
      final actividad = new Actividad.fromJsonMap(item);
      actividades.add(actividad);
    });
  }
}

class Actividad{
  int pk;
  String nombre;
  String status;

  Actividad({
    this.pk,
    this.nombre,
    this.status
  });

  Actividad.fromJsonMap(Map<String, dynamic> jsonMap){
    pk = jsonMap['pk'];
    nombre = jsonMap['nombre'];
    status = jsonMap['status'];
  }

}