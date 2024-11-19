import 'package:clima/models/climamodelo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ...

Future<WeatherResponse> fetchWeather(BuildContext context, double lat, double lon) async {
  const String apiKey = 'ea777dc81a8fc2e089401d6733ec0d5c'; // API Key
  final String url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=es&appid=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));
    //print('Respuesta de la API: ${response.body}');

    if (response.statusCode == 200) {
      return weatherResponseFromJson(response.body);
    } else {
      IconButton(onPressed: (){
        fetchWeather(context, lat, lon);
      }, icon: Icon(Icons.restart_alt));
      throw Exception('Error al obtener el clima');
    }
  } catch (e) {
    // Muestra un SnackBar cuando ocurre un error, por ejemplo, sin conexión a internet.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No se pudo obtener el clima. Verifica tu conexión a internet.'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
        
      ),
    );
    throw Exception('No se pudo obtener el clima: $e');
  }
}