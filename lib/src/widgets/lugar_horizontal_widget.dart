import 'package:flutter/material.dart';
import 'package:mmm/src/models/place_gm.dart';


class LugarHorizontal extends StatelessWidget {

  final List<PlaceToVisit> lugares;
  

  LugarHorizontal({ @required this.lugares});

  

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        controller: new PageController(
          viewportFraction: 0.4
        ),
        pageSnapping: false,
        itemCount: lugares.length,
        itemBuilder: (BuildContext context,i){
          return _tarjeta(context, lugares[i]);
        },
      ),
    );  
  
  }
  Widget _tarjeta(BuildContext context, PlaceToVisit lugar){

      return Card(
      elevation: 10.0,
     
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        //margin: EdgeInsets.only(right: 5.0),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
         
                 FadeInImage(
                  image: NetworkImage(lugar.icon),
                  placeholder: AssetImage('assets/img/loading.gif'),
                  fit: BoxFit.fill,
                  height: 50.0,
                  width: 50.0,
                  
                ),
         
         
            SizedBox(height: 5.0,),
                   ListTile(
              title: Text(
              lugar.name,
              overflow: TextOverflow.ellipsis, 
              style: Theme.of(context).textTheme.caption,
               ),
               subtitle: Text('Rating: '+lugar.rating+' Accesibilidad: '+_accesibilidad(lugar.priceLevel)),
            ),
         
          
           
           
           
        
          
          
          ],
          
        ),
      );
     


  }
  
String _accesibilidad(String priceLevel){
  Map<String,String> nivelesPrecio ={
    '0': 'Gratis',
    '1': 'Barato',
    '2' : 'Moderado',
    '3' : 'Costoso',
    '4' : 'Muy costoso',
    '': '',
  };
  return nivelesPrecio[priceLevel];
}

}