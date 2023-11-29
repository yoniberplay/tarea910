import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class screentwo extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String name;
  final String lastname;

  screentwo({
    required this.name,
    required this.lastname,
    required this.latitude,
    required this.longitude,
  });

  // latitude: 37.7749,
  // longitude: -122.4194,

  @override
  _MapScreenState createState() => _MapScreenState(
      lastname: lastname, name: name, latitude: latitude, longitude: longitude);
}

class _MapScreenState extends State<screentwo> {
  final double latitude;
  final double longitude;
  final String name;
  final String lastname;

  _MapScreenState(
      {required this.name,
      required this.lastname,
      required this.latitude,
      required this.longitude});

  late GoogleMapController mapController;
  late Marker _marker;
  @override
  void initState() {
    super.initState();
    _getLocationName(latitude, longitude);
    _marker = Marker(
      markerId: MarkerId('marker'),
      position: LatLng(latitude, longitude),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa con Marcador'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {if (_marker != null) _marker},
      ),
    );
  }

//Yoniber Encarnacion
//2021-1442
  Future<void> _getLocationName(double latitude, double longitude) async {
    const apiKey = '';
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
    String countryName = '';
    String cityName = '';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);

        if (decoded['status'] == 'OK' && decoded['results'].isNotEmpty) {
          List<dynamic> results = decoded['results'];
          if (results.isNotEmpty) {
            Map<String, dynamic> firstResult = results.first;

            List<dynamic> addressComponents = firstResult['address_components'];
            for (var component in addressComponents) {
              List<dynamic> types = component['types'];
              if (types.contains('country')) {
                countryName = component['long_name'];
                print('Nombre del país: $countryName');
              } else if (types.contains('locality')) {
                cityName = component['long_name'];
                print('Nombre de la ciudad: $cityName');
              }
            }
          }
          setState(() {
            _marker = _marker.copyWith(
              infoWindowParam: _marker.infoWindow.copyWith(
                titleParam: '$name $lastname',
                snippetParam: '$cityName $countryName',
              ),
            );
          });
          mapController.showMarkerInfoWindow(MarkerId('marker'));
        } else {
          setState(() {
            _marker = _marker.copyWith(
              infoWindowParam: _marker.infoWindow.copyWith(
                snippetParam: 'No se pudo obtener información de ubicación.',
              ),
            );
          });
          mapController.showMarkerInfoWindow(MarkerId('marker'));
        }
      } else {
        print('Error en la solicitud HTTP: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _marker = _marker.copyWith(
          infoWindowParam: _marker.infoWindow.copyWith(
            snippetParam: 'Exeption',
          ),
        );
      });
      mapController.showMarkerInfoWindow(MarkerId('marker'));
    }
  }
}
