import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BranchMapPage extends StatefulWidget {
  const BranchMapPage({Key? key}) : super(key: key);

  @override
  State<BranchMapPage> createState() => _BranchMapPageState();
}

class _BranchMapPageState extends State<BranchMapPage> {
  static const LatLng _branchPosition = LatLng(18.9261, -99.2216);

  static const CameraPosition _initialCamera = CameraPosition(
    target: _branchPosition,
    zoom: 16,
  );

  final Set<Marker> _markers = {};

  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _markers.add(
      Marker(
        markerId: const MarkerId('branch'),
        position: _branchPosition,
        infoWindow: const InfoWindow(title: 'Sucursal Principal'),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de sucursal')),
      body: GoogleMap(
        initialCameraPosition: _initialCamera,
        markers: _markers,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
