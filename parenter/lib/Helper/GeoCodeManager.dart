
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/services/base.dart';

class GeoCodeManager{

  List<Address> results = [];
  Geocoding mode;

  Future<List<String>> getLatLongFromAddress(BuildContext context, String address) async{

      try {
        var geocoding = mode;
        var results = await geocoding.findAddressesFromQuery("17 Elizabeth Grove King City Canada");
        print(results);
      } catch (e) {
        print("Error occured: $e");
      } finally {

      }




  }





}