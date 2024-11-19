## Weather App - Flutter

# Descripción General

Esta aplicación de Flutter permite a los usuarios obtener información meteorológica basada en su ubicación actual o ingresando manualmente las coordenadas. Proporciona una experiencia amigable con una interfaz atractiva, mapas, y la posibilidad de guardar ubicaciones favoritas. La aplicación utiliza el API de OpenWeatherMap para obtener la información del clima en tiempo real.

# Funcionalidades Principales

Pantalla Principal - HomeScreen

Muestra el clima actual basado en la ubicación del dispositivo del usuario.

Usa el paquete Geolocator para solicitar permisos de ubicación y obtener la latitud y longitud del usuario.

Utiliza FutureBuilder para manejar y mostrar los datos del clima una vez obtenidos.

Incluye un botón de "Buscar Ubicación" que navega a una pantalla para introducir manualmente las coordenadas.

Muestra un mapa usando FlutterMap para visualizar la ubicación del clima consultado.

En caso de no tener conexión a internet o si ocurre un error, se muestra un mensaje con un botón para reintentar la solicitud.

Buscar Ubicación - BuscarScreen

Permite a los usuarios buscar el clima ingresando manualmente la latitud y longitud.

Los datos del clima se muestran con un resumen y un mapa indicando la ubicación.

Los usuarios pueden guardar las ubicaciones como favoritas para un acceso rápido.

Incluye validación y manejo de errores si los datos ingresados son incorrectos.

Favoritos - FavoritesScreen

Muestra una lista de ubicaciones guardadas por el usuario.

Los datos se almacenan utilizando SharedPreferences, permitiendo persistencia entre sesiones.

Los usuarios pueden eliminar ubicaciones de sus favoritos, y se muestra un mensaje de confirmación.

# API del Clima - fetchWeather

Utiliza el API de OpenWeatherMap para obtener el clima actual basado en coordenadas geográficas.

Maneja errores como la falta de conexión a internet, mostrando un SnackBar con un mensaje amigable al usuario.

# Dependencias Utilizadas

http: Para realizar solicitudes HTTP a la API de OpenWeatherMap.

Geolocator: Para obtener la ubicación actual del usuario y solicitar permisos de ubicación.

SharedPreferences: Para almacenar ubicaciones favoritas de manera persistente.

FlutterMap: Para mostrar mapas con ubicaciones y marcadores en base a las coordenadas proporcionadas.

# Arquitectura y Organización

HomeScreen: Es la pantalla principal que muestra el clima según la ubicación actual del usuario. Incluye un botón para buscar otras ubicaciones.

BuscarScreen: Permite al usuario ingresar coordenadas manualmente para obtener el clima de una ubicación específica.

FavoritesScreen: Muestra todas las ubicaciones guardadas como favoritas por el usuario.

fetchWeather(): Función para obtener los datos del clima mediante una solicitud HTTP. Maneja los errores y muestra mensajes claros al usuario.

getWeatherImageById(): Función que devuelve la imagen correspondiente al tipo de clima utilizando los identificadores de clima de OpenWeatherMap.

# Cómo Ejecutar la Aplicación

Clona este repositorio en tu máquina local:

git clone <URL del repositorio>

Navega al directorio del proyecto:

cd nombre_del_proyecto

Instala las dependencias de Flutter:

flutter pub get

Crea una cuenta en OpenWeatherMap y obtén una API Key.

Actualiza la constante apiKey en el archivo fetchWeather con tu clave API.

Ejecuta la aplicación:

flutter run

Consideraciones

Permisos de Ubicación: Asegúrate de tener los permisos de ubicación habilitados en el dispositivo. Si los permisos están desactivados, la aplicación mostrará un mensaje de error indicando la necesidad de activarlos.

Almacenamiento Local: Los favoritos se almacenan utilizando SharedPreferences, lo que significa que los datos se mantendrán entre las sesiones de la aplicación.

Manejo de Errores: La aplicación maneja errores como falta de internet y permisos negados para mejorar la experiencia del usuario.

# Capturas de Pantalla

HomeScreen: Muestra el clima actual con un botón para buscar nuevas ubicaciones y muestra un mapa.

BuscarScreen: Permite buscar por coordenadas y guardar como favorito.

FavoritesScreen: Muestra las ubicaciones guardadas y permite eliminar favoritos.

