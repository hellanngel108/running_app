
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:runningapp/blocs/maps_blocs.dart';



class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapBloc bloc = MapBloc();
  String _textButton;
  bool isClickButton = false;
  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(13.7315172,108.0598776),
    zoom: 15,
  );

  Future<void> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/pngwave.png");
    bloc.imageData = byteData.buffer.asUint8List();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarker();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: bloc.locationStream,
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                height: 300,
                child: Stack(
                  children: <Widget>[
                    GoogleMap(
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: initialLocation,
                      markers: Set.of((bloc.marker != null) ? [bloc.marker] : []),
                      circles: Set.of((bloc.circle != null) ? [bloc.circle] : []),
                      onMapCreated: (GoogleMapController controller) {
                        bloc.controller = controller;
                      },

                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(300, 240, 10, 0),
                      child: FloatingActionButton(
                          child: Icon(Icons.location_searching),
                          onPressed: () {
                            print("click");
                            bloc.getCurrentLocation();
                          }),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.red,
                child: Text(isClickButton ? "STOP":"START", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 16),),
                onPressed: (){
                  setState(() {
                    isClickButton = !isClickButton;
                  });
                  if(isClickButton == true){
                    bloc.getCurrentLocation();
                  }else {
                   bloc.disposeSub();
                  }
                },
              ),
            ],
          );
        }
      ),
    );
  }
}
