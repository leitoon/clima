import 'package:clima/models/climamodelo.dart';
import 'package:http/http.dart' as http;

// ...

Future<WeatherResponse> fetchWeather(double lat, double lon) async {
  const String apiKey = 'ea777dc81a8fc2e089401d6733ec0d5c'; //  API Key
  final String url =
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=metric&lang=es&appid=$apiKey';
      print(url);
      

  final response = await http.get(Uri.parse(url));
  //print('Respuesta de la API: ${response.body}');

  if (response.statusCode == 200) {
    return weatherResponseFromJson(response.body);
  } else {
    throw Exception('Error al obtener el clima');
  }
}
