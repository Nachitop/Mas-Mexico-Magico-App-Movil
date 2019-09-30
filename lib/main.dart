import 'package:flutter/material.dart';
import 'package:mmm/src/pages/home_page.dart';
import 'package:mmm/src/pages/listado_pm_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Más México Mágico',
      initialRoute: '/',
      routes: {
        '/' : (BuildContext context)=>HomePage(),
        'listado_pm': (BuildContext context) => ListadoPmPage(),
        //'detalle': (BuildContext context) => DetallePage( new Place()),
      },
    );
  }
}