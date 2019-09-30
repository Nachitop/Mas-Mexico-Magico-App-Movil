class PlaceList{
  List<Place> places = new List();
  PlaceList.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item){
      final place = new Place.fromJsonMap(item);
      places.add(place);
    });
  }


}

class Place {
  Geometry geometry;
  List<Photo> photos;
  String placeId;
  String formattedAddress;

  Place({
    this.geometry,
    this.photos,
    this.placeId,
    this.formattedAddress,
  });

  Place.fromJsonMap(Map<String, dynamic> jsonMap){
    placeId = jsonMap['place_id'];
    formattedAddress = jsonMap['formatted_address'];

    geometry = Geometry.fromJsonMap( jsonMap['geometry']);
   
    final list = jsonMap['photos'] as List;
    // print(list.runtimeType); //returns List<dynamic>
    List<Photo> photosList = list.map((i) => Photo.fromJsonMap(i)).toList();
    photos = photosList;
  }

}

class Geometry {
  Location location;

  Geometry({
    this.location,
  });

 factory Geometry.fromJsonMap(Map<String,dynamic> jsonMap){
   return Geometry(
     location: Location.fromJsonMap( jsonMap['location']),
   );
  
  }

}

class Location {
  double lat;
  double lng;

  Location({
    this.lat,
    this.lng,
  });

  
  factory Location.fromJsonMap(Map<String,dynamic> jsonMap){
    return Location(
    lat : jsonMap['lat'],
    lng : jsonMap['lng'],
    );
  }

}

class Photo {
  int height;
  String photoReference;
  int width;

  Photo({
    this.height,
    this.photoReference,
    this.width,
  });

  factory Photo.fromJsonMap(Map<String, dynamic> jsonMap){
    return Photo(
      height: jsonMap['height'],
      width: jsonMap['width'],
      photoReference: jsonMap['photo_reference'],


    );
  }



}


//Nearby search  some (not all) returned data

class PlaceToVisitList{
  List<PlaceToVisit> lugaresVisitar = new List();
  PlaceToVisitList.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    jsonList.forEach((item){
      final lugarVisitar = new PlaceToVisit.fromJsonMap(item);
      lugaresVisitar.add(lugarVisitar);
    });
  }
} 

class PlaceToVisit {
  
  String icon;
  String name;
  String priceLevel;
  String rating;


  PlaceToVisit({
    this.icon,
    this.name,
    this.priceLevel,
    this.rating,
  });

  
  PlaceToVisit.fromJsonMap(Map<String, dynamic> jsonMap){
 
    icon = jsonMap['icon'];
    name = jsonMap['name'];
    if (jsonMap['price_level']!=null){
       priceLevel = jsonMap['price_level'].toString();
    }else{
      priceLevel = "";
    }
    if (jsonMap['rating']!=null){
      rating = (jsonMap['rating'] /1).toString();
    }else{
      rating = "";
    }
  }
}

