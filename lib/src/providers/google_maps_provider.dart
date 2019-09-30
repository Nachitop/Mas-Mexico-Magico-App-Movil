
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mmm/src/models/place_gm.dart';

class GmProvider{
  String _url = 'maps.googleapis.com';
  String _key='AIzaSyCVMRTjr7iezqeeaEJpyLRjKm9TjQcMh-k' ;
  
  Future<List<Place>> getIdPlace(String place) async{
    final url = Uri.https(_url, 'maps/api/place/textsearch/json',{
      'query': place,
      'key': _key,
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final placeList = new PlaceList.fromJsonList(decodeData['results']);
    return placeList.places;
  }

    Future<Place> getPlaceDetail(String idPlace) async{
    final url = Uri.https(_url, 'maps/api/place/details/json',{
      'place_id': idPlace,
      'key': _key,
    });
   
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final place = new Place.fromJsonMap(decodeData['result']);
    return place;
  }


  Future<String> getFoto(String urlImage) async {

    final url = Uri.https(_url, 'maps/api/place/photo',{
      'photoreference': urlImage,
      'maxheight': '350',
      'maxwidth': '350',
      'key': _key
    });
    final client = http.Client();
    final request = new Request('GET',url)..followRedirects=false;
    final resp = await client.send(request);

    // print(resp.statusCode);
    // print(resp.headers['location']);
    return resp.headers['location'];
  }

  Future<List<PlaceToVisit>> getLugares(double lat, double lon, String tipoLugar) async{

    final url = Uri.https(_url, 'maps/api/place/nearbysearch/json',{
      'location': '$lat,$lon',
      'radius': '4000',
      'type': tipoLugar,
      'key': _key
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final placeToVisitList = new PlaceToVisitList.fromJsonList(decodedData['results']);

    return placeToVisitList.lugaresVisitar;


  }

}