import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parenter/API/HTTPManager.dart';
import 'package:parenter/Helper/HelperFunctions.dart';
import 'package:parenter/Models/User/ServiceProviderRigester.dart';
import 'package:parenter/Screens/Auth/ParentSignup.dart';
import 'package:parenter/Widgets/textFeild.dart';
import 'package:parenter/common/Constants.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:parenter/common/Singelton.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'SearchDetail.dart';
class MapScreen extends StatefulWidget {
  static final String routeName = '/MapScreen';
  final int searchType;

  MapScreen(this.searchType);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
  Mode _mode = Mode.overlay;
  GoogleMapController mapController;
  Completer<GoogleMapController> _mapController = Completer();
  TextEditingController addressController = TextEditingController();
  Set<Marker> _markers = {};
   LatLng _center = const LatLng(45.521563, -122.677433);
  int _markerIdCounter = 1;
  MarkerId selectedMarker;
  ProgressDialog progressDialog;
  int petCareRadioValue = 0;

  ServiceProviderRegisterListMode providers = ServiceProviderRegisterListMode();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  //  _center =  LatLng(double.parse(Global.currentUser.latitude) ?? 0, double.parse(Global.currentUser.longitude) ?? 0);
    setState(() {

    });
  }

  void _onCameraMove(CameraPosition position) {
    _center = position.target;
  }

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Please wait...',
      progressWidget: CircularProgressIndicator(
        backgroundColor: AppColors.appPinkColor,
      ),
    );
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.appBGColor,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:  Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      child: Icon(
                        Icons.filter_list,
                        size: 0,
                      ),
                      onTap: () {
                        _showFilterBottomSheet(context);
                      },
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 16.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          children:
                          [
                            Text(
                              'Map View',
                              style:
                              TextStyle(fontSize: 24, color: AppColors.textColor),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () async{

                    _handlePressButton();
                  },
                  child: appTextField(
                      'Address',
                      Icon(
                        Icons.pin_drop,
                        size: 25,
                        color: AppColors.appPinkColor,
                      ),
                     // controller: this.addressController,
                      isEnable: false,
                      keyBoardType: TextInputType.streetAddress,
                    controller: addressController
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: MediaQuery.of(context).size.height -230,
                  child: GoogleMap(

                    onMapCreated: _onMapCreated,
                    onCameraMove: _onCameraMove,

                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 6.0,
                    ),
                    markers: _markers,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _showFilterBottomSheet(context) {

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) => Container(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
              child: new Wrap(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Filters',
                        style:
                        TextStyle(color: AppColors.textColor, fontSize: 22.0),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.clear,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Location Radius',
                        style:
                        TextStyle(color: AppColors.textColor, fontSize: 17),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      RangeSlider(
                        values: RangeValues(0, 100),
                        activeColor: AppColors.appBottomNabColor,
                        min: 0,
                        max: 100,
                        onChanged: (value) {
                          print(value);
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Select Day',
                        style:
                        TextStyle(color: AppColors.textColor, fontSize: 17),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        maxLines: 1,
                        decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  width: 1,
                                  style: BorderStyle.none,
                                  color: AppColors.colorSecondaryText),
                            ),
                            filled: false,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 20.0),
                            hintText: 'Sunday',
                            hintStyle: TextStyle(
                              color: AppColors.colorSecondaryText,
                            ),
                            fillColor: AppColors.appBGColor),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 28.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Timings From',
                                style: TextStyle(
                                    color: AppColors.textColor, fontSize: 17),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          width: 1,
                                          style: BorderStyle.none,
                                          color: AppColors.colorSecondaryText),
                                    ),
                                    filled: false,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20.0),
                                    hintText: '07:00 AM',
                                    hintStyle: TextStyle(
                                      color: AppColors.colorSecondaryText,
                                    ),
                                    fillColor: AppColors.appBGColor),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'Timings To',
                                style: TextStyle(
                                    color: AppColors.textColor, fontSize: 17),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextField(
                                maxLines: 1,
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                          width: 1,
                                          style: BorderStyle.none,
                                          color: AppColors.colorSecondaryText),
                                    ),
                                    filled: false,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 20.0),
                                    hintText: '04:30 PM',
                                    hintStyle: TextStyle(
                                      color: AppColors.colorSecondaryText,
                                    ),
                                    fillColor: AppColors.appBGColor),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: this.widget.searchType == 0 ?
                    [   Text(
                      'Select Extra Services',
                      style: TextStyle(
                          color: AppColors.textColor, fontSize: 17),
                    ),
                      Container(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: false, onChanged: (value){
                              }),
                              Text('Special Needs'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: false, onChanged: (value){
                              }),
                              Text('Cleaning'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: false, onChanged: (value){
                              }),
                              Text('Cooking'),
                            ],
                          ),
                        ],
                      ),
                    ]:this.widget.searchType == 2 ?
                    [
                      Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            new Text(
                              'Please select a type',
                              textAlign: TextAlign.left,
                              style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Radio(
                                  value: 0,
                                  groupValue: petCareRadioValue,
                                  onChanged: _handlePetCareValueChange,
                                ),
                                new Text(
                                  'Pet Sitter ',
                                  style: new TextStyle(fontSize: 16.0),
                                ),
                                new Radio(
                                  value: 1,
                                  groupValue: petCareRadioValue,
                                  onChanged: _handlePetCareValueChange,
                                ),
                                new Text(
                                  'Dog Walker',
                                  style: new TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ] :[],
                  ),

                  Container(
                    height: 40,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: FlatButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(SearchDetail.routeName,arguments: widget.searchType);
                      },
                      color: AppColors.appBottomNabColor,
                      child: Text(
                        'Apply Filters',
                        style:
                        TextStyle(color: AppColors.colorWhite, fontSize: 18),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "ca")],
    );

    displayPrediction(p);
  }
  void onError(PlacesAutocompleteResponse response) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      var lat = detail.result.geometry.location.lat;
      var long = detail.result.geometry.location.lng;

      var address  = detail.result.formattedAddress;
      addressController.text = address;
       var position = LatLng(lat,long);
      _center = LatLng(lat, long);

      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _center,
            zoom: 6.0,
          ),
        ),
      );
      setState(() {
      });
      _sendFilterRequest(context,position);

      //_add(position);
      print(lat);
      print(long);
      print(address);
    }
  }

  void _addMarkers() {

    _markers.clear();
    for (var each in this.providers.values){
      _markers.add(
          Marker(
            markerId: MarkerId('${each.id}'),
            position: LatLng(double.tryParse(each.latitude)??0.0, double.tryParse(each.longitude)??0.0),
            //icon: pinLocationIcon,
            infoWindow: InfoWindow(title: each.getFullName(), snippet: '${each.getWorkingDaysTitle()}'),
              onTap: () {
          _onMarkerTapped(each);
        },
          )
      );
    }


    if (mounted) {setState(() {});}

//    var temp = <MarkerId, Marker>{};
//
//    temp.clear();
//
//    for (var each in this.providers.values){
//      final String markerIdVal = '${each.id}';
//      final MarkerId markerId = MarkerId(markerIdVal);
//      final Marker marker = Marker(
//        markerId: markerId,
//        position: LatLng(
//          double.parse(each.latitude) ?? 0.0,
//          double.parse(each.latitude) ?? 0.0,
//        ),
//        infoWindow: InfoWindow(title: each.getFullName(), snippet: '${each.getWorkingDaysTitle()}'),
//        onTap: () {
//          _onMarkerTapped(markerId);
//        },
//      );
//      temp[markerId] = marker;
//    }
//
////    final int markerCount = markers.length;
////    if (markerCount == 12) {
////      return;
////    }
//
//    setState(() {
//      markers = temp;
//    });
  }
  void _onMarkerTapped(ServiceProviderRegisterModel provider) {
    Global.bookingSP = provider;
    Navigator.of(context).pushNamed(SearchDetail.routeName,
        arguments: widget.searchType);
//    final Marker tappedMarker = markers[markerId];
//    if (tappedMarker != _center) {
//      setState(() {
//        if (markers.containsKey(selectedMarker)) {
//          final Marker resetOld = markers[selectedMarker]
//              .copyWith(iconParam: BitmapDescriptor.defaultMarker);
//          markers[selectedMarker] = resetOld;
//        }
//        selectedMarker = markerId;
//        final Marker newMarker = tappedMarker.copyWith(
//          iconParam: BitmapDescriptor.defaultMarkerWithHue(
//            BitmapDescriptor.hueGreen,
//          ),
//        );
//        markers[markerId] = newMarker;
//      });
//    }
  }


  void _sendFilterRequest(BuildContext context,LatLng position) {
    check().then((internet) {
      if (internet != null && internet) {
        progressDialog.show();
        Map<String, dynamic> parameters = Map();
        parameters['ServiceType'] = SEARCH_TYPES[this.widget.searchType];
        parameters['PetCareServiceType'] = null;
        parameters['Day'] = "";
        parameters['TimingsFrom'] = "";
        parameters['TimingsTo'] = "";
        parameters['TimingsTo'] = "";
        parameters['ParentLatitude'] = "${position.latitude}";
        parameters['ParentLongitude'] = "${position.longitude}";
        parameters['Radius'] =  500;
        HTTPManager().getServiceProviderByFilter(parameters).then((onValue) {
          progressDialog.hide();
          final response = onValue;
            providers = onValue;
            _addMarkers();
        });
      }else {
        showAlertDialog(context, 'No Internet',
            'Make sure you are connected to internet.', true, () {
              Navigator.of(context).pop();
              _sendFilterRequest(context,position);
            });
      }
    });
  }
  void _handlePetCareValueChange(int value) {
    setState(() {
      petCareRadioValue = value;
    });
  }

}
