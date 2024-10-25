import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shuttle_monitor_web/misc/tile_misc.dart';
import 'package:shuttle_monitor_web/pages/sections/section_a_a.dart';
import 'package:shuttle_monitor_web/pages/sections/section_target_viewer.dart';
import 'package:shuttle_monitor_web/server/api/client_firebase.dart' as client;

Color backgroundColor = const Color(0xFF2c3135);
Color sectionBoxColor = const Color(0xFF363c43);
Color sectionBorColor = const Color(0xFF2b3034);

Scaffold operScreen(BuildContext context) => Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: backgroundColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 3.5,
                        decoration: BoxDecoration(
                            border: Border.all(color: sectionBorColor),
                            color: sectionBoxColor),
                        child: const Center(
                          child: SectionA_A() ??
                              Text(
                                '섹션A-A',
                                style: TextStyle(color: Colors.white),
                              ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 3.5,
                        decoration: BoxDecoration(
                            border: Border.all(color: sectionBorColor),
                            color: sectionBoxColor),
                        child: const TargetBusViewer(target: 1),
                        // child: const Center(
                        //     child: Text('섹션A-B',
                        //         style: TextStyle(color: Colors.white))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: MediaQuery.of(context).size.height / 3.5,
                        decoration: BoxDecoration(
                            border: Border.all(color: sectionBorColor),
                            color: sectionBoxColor),
                        child: const TargetBusViewer(target: 0),
                        // child: const Center(
                        //     child: Text('섹션A-C',
                        //         style: TextStyle(color: Colors.white))),
                      ),
                    ),
                  ],
                )),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: backgroundColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: const LatLng(37.733162, 127.212630),
                      initialZoom: 14,
                      cameraConstraint: CameraConstraint.contain(
                        bounds: LatLngBounds(
                          const LatLng(-90, -180),
                          const LatLng(90, 180),
                        ),
                      ),
                    ),
                    children: [
                      openStreetMapTileLayer,
                      FutureBuilder(
                          future: client.Read().fetchBusData(),
                          builder: (context, snapshot) {
                            debugPrint(snapshot.hasData.toString());
                            if (snapshot.hasData) {
                              var data = snapshot.data!;
                              return MarkerLayer(markers: [
                                const Marker(
                                    point: LatLng(37.735389, 127.210794),
                                    child: Icon(Icons.school_sharp)),
                                const Marker(
                                    point: LatLng(37.733162, 127.212630),
                                    child: Icon(Icons.bus_alert)),
                                for (int i = 0; i < data.length; i++)
                                  Marker(
                                      point: LatLng(
                                        double.parse(data[i]['bus_lat']),
                                        double.parse(data[i]['bus_long']),
                                      ),
                                      child: const Icon(Icons.hail)),
                              ]);
                            } else {
                              return const MarkerLayer(markers: [
                                Marker(
                                    point: LatLng(37.735389, 127.210794),
                                    child: Icon(Icons.school_sharp)),
                                Marker(
                                    point: LatLng(37.733162, 127.212630),
                                    child: Icon(Icons.bus_alert)),
                              ]);
                            }
                          })
                    ],
                  ),
                )),
            Container(
              width: MediaQuery.of(context).size.width / 4,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  color: backgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(color: Colors.black)),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 3.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: sectionBorColor),
                          color: sectionBoxColor),
                      child: const Center(
                          child: Text('섹션C-A',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 3.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: sectionBorColor),
                          color: sectionBoxColor),
                      child: const Center(
                          child: Text('섹션C-B',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 3.5,
                      decoration: BoxDecoration(
                          border: Border.all(color: sectionBorColor),
                          color: sectionBoxColor),
                      child: const Center(
                          child: Text('섹션C-C',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
