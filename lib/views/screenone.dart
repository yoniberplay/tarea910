import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class screenone extends StatefulWidget {
  @override
  _screenoneState createState() => _screenoneState();
}

class _screenoneState extends State<screenone> {
  //Yoniber Encarnacion
//2021-1442
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _latitudeController = TextEditingController();
  TextEditingController _longitudeController = TextEditingController();

  _gotoscreentwo() async {
    if (_lastnameController.text.isEmpty ||
        _nameController.text.isEmpty ||
        _latitudeController.text.isEmpty ||
        _longitudeController.text.isEmpty) {
      _showMyDialog();
      return;
    } else {
      Navigator.pushNamed(context, '/position', arguments: {
        'name': _nameController.text,
        'lastname': _lastnameController.text,
        'latitude': _latitudeController.text,
        'longitude': _longitudeController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Container(
                width: 350,
                child: TextFormField(
                  style: const TextStyle(),
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      labelText: 'Ingrese su nombre',
                      hintText: 'Ingrese su nombre',
                      border: OutlineInputBorder(),
                      fillColor: Colors.green),
                )),
            const SizedBox(height: 20),
            Container(
                width: 350,
                child: TextFormField(
                  style: const TextStyle(),
                  controller: _lastnameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      labelText: 'Ingrese su apellido',
                      hintText: 'Ingrese su apellido',
                      border: OutlineInputBorder(),
                      fillColor: Colors.green),
                )),
            const SizedBox(height: 20),
            Container(
                width: 350,
                child: TextFormField(
                  style: const TextStyle(),
                  controller: _longitudeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      labelText: 'Ingrese longitud',
                      hintText: 'Ingrese longitud',
                      border: OutlineInputBorder(),
                      fillColor: Colors.green),
                )),
            const SizedBox(height: 20),
            Container(
                width: 350,
                child: TextFormField(
                  style: const TextStyle(),
                  controller: _latitudeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      labelText: 'Ingrese latitud',
                      hintText: 'Ingrese latitud',
                      border: OutlineInputBorder(),
                      fillColor: Colors.green),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _gotoscreentwo,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 8),
                  Text('Presionar'),
                  Icon(Icons.navigate_next),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datos Incompletos'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Debe completar todos los campos.',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
