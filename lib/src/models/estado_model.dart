
class EstadoList{
  List<Estado> estados = new List();
  EstadoList.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null )return;
    jsonList.forEach((item){
      final estado = new Estado(nombre: item.toString());
      estados.add(estado);
    });
  }
}

class Estado{
  String nombre;

  Estado({this.nombre});

}