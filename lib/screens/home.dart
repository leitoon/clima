


import 'package:clima/models/climamodelo.dart';
import 'package:clima/peticiones/getclima.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/gradientBackground.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<WeatherResponse> futureWeather;

  @override
  void initState() {
    super.initState();
    // Inicializamos la futura consulta del clima basada en la ubicación.
    futureWeather = _getLocationAndFetchWeather();
  }

  Future<WeatherResponse> _getLocationAndFetchWeather() async {
    try {
      // Solicitar permisos
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception("El servicio de ubicación está deshabilitado.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Permiso de ubicación denegado.");
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception(
            "Permiso de ubicación denegado permanentemente. Cambia esto en configuración.");
      }

      // Obtener la ubicación actual
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Llamar a la API del clima con la latitud y longitud obtenidas
      return fetchWeather(position.latitude, position.longitude);
    } catch (e) {
      // Manejo de errores
      print("Error al obtener la ubicación: $e");
      throw Exception("No se pudo obtener la ubicación: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GradientScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.049 * size.height),
        child: FutureBuilder<WeatherResponse>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            } else if (snapshot.hasData) {
              final weather = snapshot.data!;
              return Column(
                children: [
                  Text(
                    weather.name,
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 0.45 * size.width,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: ElevatedButton(
                        onPressed: _getLocationAndFetchWeather,
                        child: const Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xffacbaef),
                              size: 20,
                            ),
                            Text(
                              'Buscar Ubicación',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0.02 * size.height),
                  SizedBox(
                    height: 0.213 * size.height,
                    width: 0.856 * size.width,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 0.14 * size.height,
                              width: 0.3 * size.width,
                              child: Image.asset(
                                'assets/images/nublado.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              '${weather.main.temp.round()}°C',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              '${weather.weather[0].description} | Lon:${weather.coord.lon}°  Lat:${weather.coord.lat}°',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.25 * size.height,
                    width: 0.856 * size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color.fromARGB(41, 255, 255, 255)),
                      borderRadius: BorderRadius.circular(18.81),
                      color: const Color.fromARGB(41, 255, 255, 255)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Resumen:',style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),),
                        Text('Humedad:${weather.main.humidity}',style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),),
                        Text('Presion:${weather.main.pressure}',style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),),
                        Text('Nivel del mar:${weather.main.seaLevel}',style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),),
                        Text('Sensacion termica:${weather.main.feelsLike.round()}',style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
