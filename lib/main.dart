import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

void main() => runApp(MaterialApp(
      home: LiveView(),
    ));

class LiveView extends StatefulWidget {
  const LiveView({Key? key}) : super(key: key);

  @override
  _LiveViewState createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  late GoogleMapController _controller;
  late StreamSubscription _locationSubscription;
  Location _locationTracker = Location();


  static final CameraPosition initialLocation =
      CameraPosition(target: LatLng(52.634289, -1.690710), zoom: 14.4746);





  void getCurrentLocation() async {
    try {

      var location = await _locationTracker.getLocation();

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(newLocalData.latitude == null? 0.0 : newLocalData.latitude!, newLocalData.longitude == null? 0.0 : newLocalData.longitude!),
              tilt: 0,
              zoom: 18.00)));
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  Widget InfoBox(String title, String value) {
    return Expanded(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 0, 1, 1),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(value)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black54,
        child: Icon(Icons.settings),
        onPressed: () {
          getCurrentLocation();
        },
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(1, 1, 0, 0),
              color: Colors.brown,
              child: Column(
                children: [
                  Row(
                    children: [
                      InfoBox('Speed', '32'),
                      InfoBox('something', '4'),
                      InfoBox('something', '4'),
                    ],
                  ),
                  Row(
                    children: [
                      InfoBox('something', '4'),
                      InfoBox('something', '4'),
                      InfoBox('something', '4'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: initialLocation,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                tiltGesturesEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  _controller = controller;
                },
                onCameraMoveStarted: () {
                  print('drag');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
