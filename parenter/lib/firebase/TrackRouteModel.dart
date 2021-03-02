
class TrackRouteModel{

  var id;
  var serviceProviderId;
  var lat;
  var long;

  TrackRouteModel(){
    id = "";
    serviceProviderId = "";
    lat = "";
    long = "";
  }

  TrackRouteModel.fromJson(Map<String,dynamic> json){
    id = json["id"] ?? "";
    serviceProviderId = json["serviceProviderId"] ?? "";
    lat = json["lat"] ?? "";
    long = json["long"] ?? "";
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'serviceProviderId': serviceProviderId,
    'lat': lat,
    'long': long,
  };
}