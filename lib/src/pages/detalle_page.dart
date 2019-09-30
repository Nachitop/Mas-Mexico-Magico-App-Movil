import 'package:flutter/material.dart';
import 'package:mmm/src/models/actividad.model.dart';
import 'package:mmm/src/models/place_gm.dart';
import 'package:mmm/src/models/pueblo_magico.dart';
import 'package:mmm/src/providers/google_maps_provider.dart';
import 'package:mmm/src/providers/mmm_provider.dart';
import 'package:mmm/src/widgets/card_swiper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmm/src/widgets/lugar_horizontal_widget.dart';

class DetallePage extends StatefulWidget {
  //Variables que obtiene de la page anterior
  final Place  place;
  final PuebloMagico puebloMagico;
  DetallePage( this.place, this.puebloMagico,{Key key}): super(key:key);
  
  _DetallePageState createState() => _DetallePageState();
}

class _DetallePageState extends State<DetallePage> {
  //Variables para las api de google maps y para recibir la lista de urls de fotos
  List<String> _urlsFoto = new List();

  final gmProvider = GmProvider();

  final _estiloTexto =  TextStyle(fontFamily: 'Times New Roman', fontSize: 20.0 );

  //Variables, controladores y métodos para que funcione google Maps
  LatLng _center;
  GoogleMapController mapController;
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Servici de djnago (pueblos mágicos)

  final mmmProvider = MmmProvider();
  List<PlaceToVisit> _restaurantes = new List();
  List<PlaceToVisit> _hoteles = new List();

  @override
  void initState() {

    super.initState();
    
    _center = new LatLng(widget.place.geometry.location.lat, widget.place.geometry.location.lng);
    widget.place.photos.forEach((foto){
      gmProvider.getFoto(foto.photoReference).then((url){
         _urlsFoto.add(url);
           setState(() {
       
           });
      });
     
    });

    gmProvider.getLugares(_center.latitude, _center.longitude, 'restaurants').then((lugares){
      _restaurantes = lugares;
 
         setState(() {
       
           });
    
    });
    gmProvider.getLugares(_center.latitude, _center.longitude, 'hotels').then((lugares){
      _hoteles = lugares;   
         setState(() {
       
           });    
      });




  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.formattedAddress),
        backgroundColor: Color(0xff40E0D0) ,
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: ListView(
        
          children: <Widget>[
            _dibujarMapa(_onMapCreated,_center),
            _swiperFotos(_urlsFoto),
            _ponerInformacion(widget.puebloMagico),
            _obtenerLugares(_restaurantes,'food'),
            _obtenerLugares(_hoteles,'hotels')
          ],
     
           
          ),
      ),
      );
  }

     Widget _dibujarMapa(onMapCreated, center){
      return Container(
        width: 250,
        height: 250,
        child: GoogleMap(
          indoorViewEnabled: false,
          mapType: MapType.normal,
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: center,
            zoom: 8.0,
          ),
          
        ),
      ); 
    }

    Widget _swiperFotos(List<String>  urlsFoto){
    if(urlsFoto.length<=0){
      return Center(child: CircularProgressIndicator());
    }else{
       return CardSwiper(
      fotosUrl: urlsFoto ,
    );
    }
   
  }

  Widget _ponerInformacion(PuebloMagico puebloMagico){
    return Column(
      //Descripción
      children: <Widget>[
        SizedBox(height: 30.0,),
        _titulo('Descripción'),
        SizedBox(height: 10.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5.0),
              width: 340.0,
              child: Text(puebloMagico.descripcion,
                style: _estiloTexto,
              ),

            ),
          ],
        ),

      //Actividades
      SizedBox(height: 30,),
      _titulo('Actividades'),
       SizedBox(height: 20.0,),
       FutureBuilder(
         future: mmmProvider.getActividadesPM(puebloMagico.pk),
         builder: (BuildContext context,  AsyncSnapshot<List<Actividad>> snapshot){
           if(snapshot.hasData){
             return Column(
              // padding: EdgeInsets.all(5.0),
               children: _crearActividades(snapshot.data),
             );
           }else{
             return Center(
               child: CircularProgressIndicator(),
             );
           }
           
         },
       ),

      ],
    );
  }

  

  Widget _titulo(String titulo){
    return Row(
          mainAxisAlignment:  MainAxisAlignment.start,
          children: <Widget>[
            Text(titulo,
              style: TextStyle(fontFamily: 'Times New Roman', fontSize: 25.0, fontStyle: FontStyle.italic ),
            ),
           
          ],
        );
  }

 List<Widget> _crearActividades(List<Actividad> actividades) {
   return actividades.map((actividad){
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(actividad.nombre,
              style: _estiloTexto,
            ),
          ),
          Divider(),
        ],
      );
   }).toList();

}
Widget _obtenerLugares(List<PlaceToVisit> lugares, String tipoLugar) {
  print(tipoLugar);
  String tituloLugar = (tipoLugar=="hotels")? 'Dónde hospedarse' : 'Dónde comer';
  return Column(
    children: <Widget>[
       SizedBox(height: 30,),
      _titulo(tituloLugar),
       SizedBox(height: 20.0,),
      LugarHorizontal(
        lugares: lugares,
      ),
    ],
  );
}





}