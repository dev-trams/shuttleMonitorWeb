import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:shuttle_monitor_web/misc/tile_misc.dart';
import 'package:shuttle_monitor_web/server/api/client_firebase.dart' as client;

class TargetBusViewer extends StatefulWidget {
  final int target;

  const TargetBusViewer({super.key, required this.target});

  @override
  _TargetBusViewerState createState() => _TargetBusViewerState();
}

class _TargetBusViewerState extends State<TargetBusViewer> {
  late int _target;
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _target = widget.target;
    _mapController = MapController(); // MapController 초기화
  }

  void showCustomMenu(BuildContext context, Offset position,
      {required List<Map<String, dynamic>> data}) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: <PopupMenuEntry>[
        for (int i = 0; i < data.length; i++)
          PopupMenuItem(
            value: i,
            child: Text(data[i]['busCode']),
          ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          _target = value;
          // 지도의 중심 좌표를 선택된 버스의 위치로 갱신
          _mapController.move(
            LatLng(
              double.parse(data[_target]['bus_lat']),
              double.parse(data[_target]['bus_long']),
            ),
            17,
          );
        });
        print('선택된 옵션: $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: client.Read().fetchBusData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return Stack(
            children: [
              Listener(
                onPointerDown: (event) {
                  if (event.buttons == kSecondaryMouseButton) {
                    debugPrint('오른쪽 클릭 감지');
                    showCustomMenu(context, event.position, data: data);
                  }
                },
                child: FlutterMap(
                  mapController: _mapController, // MapController 추가
                  options: MapOptions(
                    initialCenter: LatLng(
                      double.parse(data[_target]['bus_lat']),
                      double.parse(data[_target]['bus_long']),
                    ),
                    initialZoom: 17,
                    cameraConstraint: CameraConstraint.contain(
                      bounds: LatLngBounds(
                        const LatLng(-90, -180),
                        const LatLng(90, 180),
                      ),
                    ),
                  ),
                  children: [
                    openStreetMapTileLayer,
                    MarkerLayer(
                      markers: [
                        const Marker(
                          point: LatLng(37.735389, 127.210794),
                          child: Icon(Icons.school_sharp),
                        ),
                        const Marker(
                          point: LatLng(37.733162, 127.212630),
                          child: Icon(Icons.bus_alert),
                        ),
                        for (int i = 0; i < data.length; i++)
                          Marker(
                            point: LatLng(
                              double.parse(data[i]['bus_lat']),
                              double.parse(data[i]['bus_long']),
                            ),
                            child: const Icon(Icons.hail),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black.withOpacity(0.7),
                  child: Text(
                    data[_target]['busCode'].toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
