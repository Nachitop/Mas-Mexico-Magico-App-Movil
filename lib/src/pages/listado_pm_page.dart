import 'package:flutter/material.dart';
import 'package:mmm/src/models/place_gm.dart';
import 'package:mmm/src/models/pueblo_magico.dart';
import 'package:mmm/src/pages/detalle_page.dart';
import 'package:mmm/src/providers/google_maps_provider.dart';
import 'package:mmm/src/providers/mmm_provider.dart';

class ListadoPmPage extends StatelessWidget{

  final mmmProvider = new MmmProvider();
  final gmProvider = new GmProvider();
    final _containerVacio = new Container(
      height: 350.0,
      width: 350,
    );
  @override
  Widget build(BuildContext context){

    final _estado = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Pueblos mágicos en '+_estado),
        backgroundColor: Color(0xff40E0D0) ,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Color(0XFFFFB6C1),
        child: _crearListadoPm(context, _estado),
      ),
    );
  }

Widget _crearListadoPm(context, estado){
  return FutureBuilder(
    future: mmmProvider.getPueblosMagicos(estado) ,
    builder: (BuildContext context, AsyncSnapshot<List<PuebloMagico>> snapshot){
      if(snapshot.hasData){
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){
            return Container(child: _tarjetaPuebloMagico(snapshot.data[index],context));
          },
          // padding: EdgeInsets.all(20.0),
          // children: _tarjetasPueblosMagicos(snapshot.data, context),
        );
      }else{
        return Center(
          child: CircularProgressIndicator() ,
        );
      }
    },

  );
}

Widget _tarjetaPuebloMagico(PuebloMagico puebloMagico, context){
    Place place= new Place();
    final card = Container(
      
      child: Column(
        children: <Widget>[
          FutureBuilder(
            future: gmProvider.getIdPlace(puebloMagico.nombre),
            builder: (BuildContext context, AsyncSnapshot<List<Place>> snapshot){
              if(snapshot.hasData){
             
                return FutureBuilder(
                  future: gmProvider.getPlaceDetail(snapshot.data[0].placeId),
                  builder: (BuildContext context, AsyncSnapshot<Place> snapshot){
                    if(snapshot.hasData){
                      place = snapshot.data;
  
                      return FutureBuilder(
                            future: gmProvider.getFoto(snapshot.data.photos[0].photoReference),
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
                             if(snapshot.hasData){
                                return FadeInImage(
                                  image: NetworkImage(snapshot.data),
                                  placeholder: AssetImage('assets/img/loading.gif'),
                                  fadeInDuration: Duration(milliseconds: 300),
                                  height: 350.0,
                                  width: 350.0,
                                fit: BoxFit.cover,
                    );
                   }else{
                    
                       return _containerVacio;
                     
                   }
                
                  },
                );
                  }else{
                    return _containerVacio;
                  }
                },

              );
              }else{
                return _containerVacio;
              }
            } ,

          ),
   
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(puebloMagico.nombre, 
              style: TextStyle(fontSize: 25.0,
              fontFamily: 'Times New Roman'
                ),
              ),
          ),
        ],
      ),
    );

    final cardBordered = Container(
      margin: EdgeInsets.all(10.0),
      child: ClipRRect(
        child: card,
        borderRadius: BorderRadius.circular(20.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(2.0, 10.0)
          ),
        ],
      ),
    );
  
    final cardTapped =  GestureDetector(
      child: cardBordered,
      onTap: (){
        Navigator.push(context, new MaterialPageRoute(
          builder: (context) => DetallePage(place,puebloMagico),
        ));
        //Navigator.pushNamed(context, 'detalle',arguments: place);
      },
    );
   
    // pueblosMagicosContenedor.add(
    //  cardTapped
    // );
    //  pueblosMagicosContenedor.add(
    //  SizedBox(height: 20.0,)
    // );
  //});
  return cardTapped;
}

}