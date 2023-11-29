import 'package:flutter/material.dart';
import 'package:tarea910/views/screenone.dart';
import 'package:tarea910/views/screentwo.dart';

//Yoniber Encarnacion
//2021-1442

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == '/position') {
          final args = settings.arguments as Map<String, dynamic>;
          final name = args['name'];
          final lastname = args['lastname'];
          final latitude = double.parse(args['latitude']);
          final longitude = double.parse(args['longitude']);

          return MaterialPageRoute(
            builder: (context) {
              return screentwo(
                name: name,
                lastname: lastname,
                latitude: latitude,
                longitude: longitude,
              );
            },
          );
        }
        return null;
      },
      title: 'Tarea 9 y 10',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Tarea 9 y 10'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: screenone(),
    );
  }
}
