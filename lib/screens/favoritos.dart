

import 'package:clima/widgets/gradientBackground.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoritesJson = prefs.getStringList('favorites') ?? [];

  setState(() {
    _favorites = favoritesJson.map((item) {
      return json.decode(item) as Map<String, dynamic>;
    }).toList().reversed.toList(); // Invertir la lista aquí
  });
}


  Future<void> _removeFavorite(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritesJson = prefs.getStringList('favorites') ?? [];

    favoritesJson.removeAt(index);

    await prefs.setStringList('favorites', favoritesJson);

    setState(() {
      _favorites.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Eliminado de Favoritos')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return GradientScaffold(
     
        body: Padding(
          padding:  EdgeInsets.symmetric(
              vertical: 0.01* size.height, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,)),
              const Text(
                        'Favoritos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              _favorites.isEmpty
                  ? Padding(
                    padding: EdgeInsets.only(top:0.04*size.height),
                    child: const Center(child: Text('No hay favoritos guardados',style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),)),
                  )
                  : Expanded(
                    child: ListView.builder(
                        itemCount: _favorites.length,
                        itemBuilder: (context, index) {
                          final item = _favorites[index];
                          
                          return ListTile(
                            title: Text(item['name'],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                            subtitle: Text(
                                'Lat: ${item['lat']}, Lon: ${item['lon']}',style: const TextStyle(color: Colors.white)),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete,color: Colors.white),
                              onPressed: () => _removeFavorite(index),
                            ),
                            
                            onTap: () {
                              // pantalla de detalles si lo deseas
                            },
                          );
                        },
                      ),
                  ),
            ],
          ),
        ));
  }
}
