import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';



class CardSwiper extends StatelessWidget{

  final List<String> fotosUrl;

  CardSwiper({@required this.fotosUrl});
  @override
  Widget build(BuildContext context){

    final _screenSize = MediaQuery.of(context).size;
    return Container(
    padding: EdgeInsets.only(top: 10.0),
    child: Swiper(
    itemBuilder: (BuildContext context, int index){
      return ClipRRect(
        child: FadeInImage(
        image: NetworkImage(fotosUrl[index]),
        placeholder: AssetImage('assets/img/loading.gif'),
        fit: BoxFit.cover,
        ),
      borderRadius: BorderRadius.circular(20.0),
      );
  
  
      },
        itemCount: fotosUrl.length,
        itemHeight: _screenSize.height*0.45,
        itemWidth: _screenSize.width*0.6,
        layout: SwiperLayout.STACK,
      ) ,
    );

        }


  }

