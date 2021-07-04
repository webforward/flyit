import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() =>
    runApp(MaterialApp(
      home: LiveView(),
    ));

class LiveView extends StatefulWidget {
  const LiveView({Key? key}) : super(key: key);

  @override
  _LiveViewState createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition initialLocation = CameraPosition(
      target: LatLng(52.634289, -1.690710), zoom: 14.4746);

  Widget InfoBox(String title, String value) {
    return Expanded(
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(0, 0, 1, 1),
        padding: EdgeInsets.all(15),
        child: Column(
          children: [Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),), Text(value)],
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
        onPressed: () {},
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
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
