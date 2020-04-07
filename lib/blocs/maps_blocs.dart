import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapBloc{

  StreamSubscription _locationSubscription;
  StreamController _locationController = StreamController();
  Stream get locationStream => _locationController.stream;
  Location _locationTracker = Location();
  LocationData _locationData;
  GoogleMapController _controller;

  GoogleMapController get controller => _controller;

  set controller(GoogleMapController value) {
    _controller = value;
  }

  LocationData get locationData => _locationData;
  Marker marker;
  Circle circle;
  Uint8List _imageData;


  Uint8List get imageData => _imageData;

  set imageData(Uint8List value) {
    _imageData = value;
  }

  void updateMarkerAndCircle(LocationData newLocalData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);

      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      _locationController.sink.add(marker);
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    _locationController.sink.add(circle);

  }

  void getCurrentLocation() async {
    try {
      print("I'm here");
      var location = await _locationTracker.getLocation();
      updateMarkerAndCircle(location);
      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }
      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude, newLocalData.longitude),
              zoom: 15.00)));
          _locationController.sink.add("OK");
        }
      });

    }on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }
  void dispose(){
    _locationController.close();
  }
  void disposeSub(){
    _locationSubscription.cancel();
  }
}