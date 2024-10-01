import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  String _data = 'Cargando...';
  String _imageUrl = '';
  String _recipeInstructions = '';

  @override
  void initState() {
    super.initState();
    _fetchRandomMeal();
  }
Future<void> _fetchRandomMeal() async {
  try {
    final response = await http.get(
      Uri.parse('https://www.googleapis.com/books/v1/volumes?q=harry+potter'), // Cambia esta URL según sea necesario
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      if (jsonData['items'] != null && jsonData['items'].isNotEmpty) {
        setState(() {
          _data = ''; // Reinicia _data para mostrar múltiples títulos
          for (var item in jsonData['items']) {
            _data += '${item['volumeInfo']['title']}\n'; // Agrega cada título a _data
          }
        });
      } else {
        setState(() {
          _data = 'No se encontraron libros.';
        });
      }
    } else {
      setState(() {
        _data = 'Error al cargar los datos: ${response.statusCode}';
      });
    }
  } catch (e) {
    setState(() {
      _data = 'Error: $e';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Libros Aleatorios', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 39, 137, 182),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20), 
              if (_imageUrl.isNotEmpty)
                Image.network(
                  _imageUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
               const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _data,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (_recipeInstructions.isNotEmpty)
                Padding(
                  padding:  const  EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       const Text(
                        'Instrucciones de lecturs:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const  SizedBox(height: 10),
                      Text(
                        _recipeInstructions,
                        style:  const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ElevatedButton(
                onPressed: _fetchRandomMeal,
                child: const  Text('Obtener otro libro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}