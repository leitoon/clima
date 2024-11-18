

String getWeatherImageById(int id) {
  if (id >= 200 && id <= 232) {
    return 'assets/images/relampago.png'; // Tormenta eléctrica
  } else if (id >= 300 && id <= 321) {
    return 'assets/images/trueno-sol.png'; // Llovizna
  } else if (id >= 500 && id <= 531) {
    return 'assets/images/lluvia.png'; // Lluvia
  } else if (id >= 600 && id <= 622) {
    return 'assets/images/nieve.png'; // Nieve
  } else if (id >= 700 && id <= 781) {
    return 'assets/images/nublado.png'; // Atmosférico
  } else if (id == 800) {
    return 'assets/images/sol.png'; // Cielo claro
  } else if (id >= 801 && id <= 804) {
    return 'assets/images/nublado.png'; // Nubes
  } else {
    return 'assets/images/nublado.png'; // Imagen por defecto
  }
}