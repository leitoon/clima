import 'package:clima/models/climamodelo.dart';
import 'package:clima/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../peticiones/getclima.dart';

class BuscarScreen extends StatefulWidget {
  const BuscarScreen({super.key});

  @override
  State<BuscarScreen> createState() => _BuscarScreenState();
}

class _BuscarScreenState extends State<BuscarScreen> {
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _lonController = TextEditingController();
  WeatherResponse? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _fetchWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final double lat = double.parse(_latController.text.trim());
      final double lon = double.parse(_lonController.text.trim());

      // Llama a tu función para obtener el clima
      WeatherResponse weather = await fetchWeather(lat, lon);

      setState(() {
        _weatherData = weather;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al obtener los datos: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    print(_latController.text);
    print(_lonController.text);

    return SafeArea(
      child: GradientScaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 0.01* size.height, horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,)),
                const Text(
                  'Buscar Ubicación',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Campo de entrada para la latitud
                TextField(
                  controller: _latController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Latitud',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Ingresa la latitud',
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Campo de entrada para la longitud
                TextField(
                  controller: _lonController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Longitud',
                    labelStyle: TextStyle(color: Colors.white),
                    hintText: 'Ingresa la longitud',
                    hintStyle: TextStyle(color: Colors.white54),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Botón de búsqueda
                Center(
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _fetchWeather,
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Buscar'),
                  ),
                ),
                SizedBox(height: 24),
                // Mostrar error si existe
                if (_errorMessage != null)
                  Center(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.redAccent, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                // Mostrar los datos obtenidos
                if (_weatherData != null) ...[
                  SizedBox(height: 16),
                  // Aquí puedes reutilizar tus widgets existentes para mostrar los datos
                  // Por ejemplo, el Container con 'Resumen:' y el mapa
                  _buildWeatherSummary(size),
                  SizedBox(height: 16),
                  _buildMap(size),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherSummary(Size size) {
    final weather = _weatherData!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(41, 255, 255, 255)),
        borderRadius: BorderRadius.circular(18.81),
        color: const Color.fromARGB(41, 255, 255, 255),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ciudad: ${weather.name} - ${weather.weather[0].description}', style: _summaryTitleStyle),
            const SizedBox(height: 8),
            Text('Resumen:', style: _summaryTitleStyle),
            const SizedBox(height: 8),
            // Puedes reutilizar tus widgets ResumenClima aquí
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ResumenClima(
                  size: size,
                  informacion: '${weather.main.humidity}%',
                  titulo: 'Humedad',
                  icono: Icons.water_drop_outlined,
                ),
                ResumenClima(
                  size: size,
                  informacion: '${weather.main.pressure} hPa',
                  titulo: 'Presión',
                  icono: Icons.compress,
                ),
                ResumenClima(
                  size: size,
                  informacion: '${weather.wind.speed} m/s',
                  titulo: 'Viento',
                  icono: Icons.air,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ResumenClima(
                  size: size,
                  informacion: '${weather.main.temp.round()}°C',
                  titulo: 'Temperatura',
                  icono: Icons.thermostat,
                ),
                ResumenClima(
                  size: size,
                  informacion: '${weather.clouds.all}%',
                  titulo: 'Nubosidad',
                  icono: Icons.cloud,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMap(Size size) {
    final weather = _weatherData!;
    return SizedBox(
      height: 0.3 * size.height,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18.81),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(weather.coord.lat, weather.coord.lon),
            initialZoom: 13.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(weather.coord.lat, weather.coord.lon),
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle get _summaryTitleStyle => const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
}
