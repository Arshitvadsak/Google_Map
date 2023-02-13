import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map_Page extends StatefulWidget {

  @override
  State<Map_Page> createState() => _Map_PageState();
}

class _Map_PageState extends State<Map_Page> {
  double lat = 0;
  double long = 0;

  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Placemark? placemark;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> CompanyDetails =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print(CompanyDetails.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${CompanyDetails['companyname']}",
        ),
        backgroundColor: Colors.orange[200],
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          child: StreamBuilder<Position?>(
            stream: Geolocator.getPositionStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.hasError}"),
                );
              } else if (snapshot.hasData) {
                Position? data = snapshot.data;

                placemarkFromCoordinates(CompanyDetails['latitude'],CompanyDetails['longitude'])
                    .then((List<Placemark> Placemarks) {
                  setState(() {
                    placemark = Placemarks[0];
                  });
                });
                return (data != null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${placemark?.street}, ${placemark?.name}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${placemark?.locality}, ${placemark?.country}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "${placemark?.postalCode}\n",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                           // "Point :- $lat, $long",
                            "${CompanyDetails['latitude']}, ${CompanyDetails['longitude']}",
                            style: TextStyle(fontSize: 14),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Geolocator.getPositionStream().listen(
                                (position) {
                                  setState(
                                    () {
                                      lat = position.latitude;
                                      long = position.longitude;
                                      GoogleMap(
                                        mapType: MapType.satellite,
                                        onMapCreated: _onMapCreated,
                                        initialCameraPosition: CameraPosition(
                                          target: LatLng(CompanyDetails['latitude'], CompanyDetails['longitude']),
                                          zoom: 11.0,
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.orange[200],
                              ),
                            ),
                            child: Text("Get Location"),
                          ),
                          Container(
                            height: 500,
                            width: 340,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: GoogleMap(
                              mapType: MapType.hybrid,
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(CompanyDetails['latitude'], CompanyDetails['longitude']),
                                zoom: 11.0,
                              ),
                              markers: {
                                Marker(
                                  markerId: MarkerId("source"),
                                  position: LatLng(CompanyDetails['latitude'], CompanyDetails['longitude']),
                                ),
// const Marker(
//   markerId: MarkerId("destination"),
//   position: destination,
// ),
                              },
                            ),
                          ),
                        ],
                      )
                    : Container();
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
