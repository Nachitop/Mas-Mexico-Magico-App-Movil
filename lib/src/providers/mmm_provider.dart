import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mmm/src/models/actividad.model.dart';
import 'package:mmm/src/models/estado_model.dart';
import 'package:mmm/src/models/pueblo_magico.dart';


class MmmProvider{

  String _url = '192.168.0.5:8000';

  //Servicio que trae los estados en donde hay pueblos mágicos
  Future<List<Estado>> getEstados() async{
    final url = Uri.http( _url, 'pueblos_magicos/estados/');
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final estadoList = new EstadoList.fromJsonList(decodeData);
    return estadoList.estados;
  }

  Future<List<Actividad>> getActividadesPM(int idPuebloMagico) async {
    final url = Uri.http(_url, 'pueblos_magicos/acpm/',{'pueblo_magico': idPuebloMagico.toString()});
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final actividadList = new ActividadList.fromJsonList(decodeData);
    return actividadList.actividades;
  }

  Future<List<PuebloMagico>> getPueblosMagicos(String estado)async{
    
    final url = Uri.http(_url, 'pueblos_magicos/listado/',{
      'estado': estado,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final pueblosMagicosList = new PuebloMagicoListado.fromJsonList(decodedData);
    return pueblosMagicosList.pueblosMagicos;
  }


}