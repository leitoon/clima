


import 'package:clima/models/climamodelo.dart';
import 'package:clima/peticiones/getclima.dart';
import 'package:flutter/material.dart';

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
    futureWeather = fetchWeather(3.37, -76.52);
  }
  @override
  Widget build(BuildContext context) {
   
    final Size size = MediaQuery.sizeOf(context);
    return  GradientScaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 0.049*size.height),
        child: FutureBuilder<WeatherResponse>(
          future: futureWeather,
          builder: (context, snapshot){
            if (snapshot.hasData) {
                final weather = snapshot.data!;
                return 
                Column(
            children: [
            
              Text(
                weather.name,
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 0.45*size.width,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: ElevatedButton(onPressed: (){},
                  child:  const Row(
                      children: [
                        Icon(Icons.location_on ,color: Color(0xffacbaef),size: 20,),
                        Text('Buscar Ubicación',style: TextStyle(color: Colors.grey,fontSize: 12),)
                      ],
                    ),),
                ),
              ),
              SizedBox(height: 0.02*size.height,),
              SizedBox(
                
                height: 0.213*size.height,
                width:0.856*size.width ,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 0.14*size.height,
                          width: 0.3*size.width,
                          child: Image.asset('assets/images/nublado.png',fit: BoxFit.contain,),
                        ),
                        Text('${weather.main.temp}°C',style: const TextStyle(color: Colors.white,fontSize:50),)
                      ],
                    ),
                  ],
                ),
               
              ), // Más widgets aquí
            ],
          );
                
                
                // Text(
                //     'Ciudad: ${weather.name}\nTemperatura: ${weather.main.temp}°C\nDescripción: ${weather.weather[0].description}');
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return CircularProgressIndicator();
          }
          
        ),
      ),
    );
  }
}
