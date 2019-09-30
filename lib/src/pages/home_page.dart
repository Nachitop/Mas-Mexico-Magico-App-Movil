import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mmm/src/models/estado_model.dart';
import 'package:mmm/src/providers/mmm_provider.dart';

class HomePage extends StatelessWidget{

 final mmmProvider = new MmmProvider();
 final List<Color> colores = [
    Color(0XFFDC143C),
    Color(0XFFB22222),
    Color(0XFFFF4500),
    Color(0XFFFFA500),
    // Color(0XFFFF69B4),
    // Color(0XFFFF1493),
    // Color(0XFFC71585),
    // Color(0XFFDB7093),
    Color(0XFFFFD700),
    Color(0XFFBDB76B),
    // Color(0XFF40E0D0),
    // Color(0XFF00CED1),

  ];

  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text('Estados de México'),
        backgroundColor: Color(0xff40E0D0),
      ),
      body: Container(child:  _crearEstados(context),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          stops: [0.2, 0.4, 0.6, 0.8],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.pink[50],
            Colors.pink[100],
            Colors.pink[200],
            Colors.pink[300],
          ],
        ),
        ),
      ),

    );

  }

  Widget _crearEstados(BuildContext context){
    // List<Widget> estados = new List<Widget>();
    return FutureBuilder(
      future: mmmProvider.getEstados() ,
      builder: (BuildContext context, AsyncSnapshot<List<Estado>> snapshot){
        if(snapshot.hasData){
          return GridView.extent(
            maxCrossAxisExtent: 250.0,
            padding:const EdgeInsets.all(10.0),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            children: _containerEstados(snapshot.data, context),
            );
         
        }else{
          return Container(
            height: 600.0,
            child: Center(child: CircularProgressIndicator(),),
          );
        }
      },

    );
  }

  List<GestureDetector> _containerEstados(List<Estado> estados, context) { 
    final random = Random();
    return List.generate(
      estados.length, (i)=> GestureDetector(child: Container(
        decoration: BoxDecoration(
          color: colores[random.nextInt(colores.length)] ,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            spreadRadius: 5.0,
            offset: Offset(2.0, 10.0)
          ),
        ],
          ),
      
      child: Center(
        child: Text(estados[i].nombre,
         style: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontFamily: 'Times New Roman',
         ),
         ),
        ),
        ),
        onTap: ()=> Navigator.pushNamed(context, 'listado_pm', arguments: estados[i].nombre),
        )
        ); 
    
  }
}