import 'package:flutter/material.dart';
import 'package:parenter/Models/Booking/BookingModel.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Widgets/AppButton.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:parenter/firebase/FirestoreDB.dart';
import 'dart:async';

import 'package:parenter/firebase/TrackRouteModel.dart';

const double CAMERA_ZOOM = 15;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.747932,-71.167889);
const LatLng DEST_LOCATION = LatLng(37.335685,-122.0605916);


class TrackScreen extends StatefulWidget {
  static final String routeName = '/TrackScreen';
  final BookingModel booking;
  TrackScreen(this.booking);
  @override
  _TrackScreenState createState() => _TrackScreenState();
}

class _TrackScreenState extends State<TrackScreen> {

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;
  // the user's initial location and current location
// as it moves
  LatLng currentLocation;
// a reference to the destination location
  LatLng destinationLocation;
// wrapper around the location API
  Location location;
  Timer getTimer;

  var currentIndex = 0;
  @override
  void initState() {
    super.initState();
    location = new Location();
    polylinePoints = PolylinePoints();
    //timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkForNewLocation(),);
    initilizeTimers();
    currentLocation = LatLng(destinationPoint[0],destinationPoint[1]);
    setSourceAndDestinationIcons();
    setInitialLocation();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    getTimer.cancel();
    super.dispose();
  }

  void initilizeTimers() async{
    getTimer = Timer.periodic(Duration(seconds: 2), (Timer t) => getRouteFromFirebase(),);
  }

  void getRouteFromFirebase() async{
    var result = await FirestoreDB.getRoute(widget.booking.serviceProviderId);
    if (result.id == ""){
      print("Not Found");
    }else{
      destinationLocation = LatLng(double.tryParse(result.lat) ?? 0, (double.tryParse(result.long) ?? 0));
      showPinsOnMap();
    }

  }

//  void checkForNewLocation(){
//    destinationLocation = LatLng(routePoints[currentIndex][0], routePoints[currentIndex][1]);
//    currentIndex += 1;
//    showPinsOnMap();
////    setState((){
////      // change state according to result of request
////    });
//
//  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.5),
        'resources/images/destinationMapPin.bmp');

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 1.5),
        'resources/images/sourceMapPin.bmp');
  }
  void setInitialLocation() async {
    currentLocation =  LatLng(destinationPoint[0], destinationPoint[1]);//await location.getLocation();
    destinationLocation = LatLng(routePoints[currentIndex][0], routePoints[currentIndex][1]);
  }
  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(currentLocation.latitude,
        currentLocation.longitude);
    // get a LatLng out of the LocationData object
    var destPosition = LatLng(destinationLocation.latitude,
        destinationLocation.longitude);
    // add the initial source location pin
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
        position: pinPosition,
        icon: sourceIcon
    ));
    // destination pin
    _markers.add(Marker(
        markerId: MarkerId('destPin'),
        position: destPosition,
        icon: destinationIcon
    ));
    // set the route lines on the map from source to destination
    // for more info follow this tutorial
    setPolylines();
  }
  void setPolylines() async {
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(
        kGoogleApiKey,
        currentLocation.latitude,
        currentLocation.longitude,
        destinationLocation.latitude,
        destinationLocation.longitude);
    _polylines.clear();
    polylineCoordinates.clear();

    if(result.isNotEmpty){
      result.forEach((PointLatLng point){
        polylineCoordinates.add(
            LatLng(point.latitude,point.longitude)
        );
      });
      setState(() {
        _polylines.add(Polyline(
            width: 5, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates
        ));
      });
    }
  }
  void updatePinOnMap() async {

    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude,
          currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));
    // do this inside the setState() so Flutter gets notified
    // that a widget update is due
    setState(() {
      // updated position
      var pinPosition = LatLng(currentLocation.latitude,
          currentLocation.longitude);

      // the trick is to remove the marker (by id)
      // and add it again at the updated location
      _markers.removeWhere(
              (m) => m.markerId.value == "sourcePin");
      _markers.add(Marker(
          markerId: MarkerId("sourcePin"),
          position: pinPosition, // updated position
          icon: sourceIcon
      ));
    });
  }

  @override
  Widget build(BuildContext context) {

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: SOURCE_LOCATION
    );
    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude,
              currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING
      );
    }

    return Scaffold(
      backgroundColor: AppColors.appBGColor,
      appBar: AppBar(
        title: Text('Track',
        style: Theme.of(context).textTheme.bodyText1,),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GoogleMap(
                myLocationEnabled: true,
                compassEnabled: true,
                tiltGesturesEnabled: false,
                markers: _markers,
                polylines: _polylines,
                mapType: MapType.normal,
                initialCameraPosition: initialCameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  // my map has completed being created;
                  // i'm ready to show the pins on the map
                  showPinsOnMap();
                })
          ],
        ),
      ),
    );
  }
}
