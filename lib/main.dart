import 'package:clima/screens/screens.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clima App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff123597)),
        useMaterial3: true,
      ),
      initialRoute: 'home', // Verifica el estado y establece la ruta inicial
        routes: {
          'home': (_) => HomeScreen(),
          'buscar': (_) => BuscarScreen(),
          'favoritos': (_) => FavoritesScreen(),
        },
    );
  }
}
