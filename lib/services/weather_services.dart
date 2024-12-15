import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/models/weather_model.dart';

class WeatherServices {
  Future<String> _getLocation() async {
    //kullanici konumu acik mi kontrol edildi
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Konum Kapalı");
    }

    //kullanici konum izni vermis mi kontrol edildi
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      //konum izni vermemisse tekrar izin istenildi
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //yine vermemisse hata dönderildi
        Future.error("konum izni ver");
      }
    }

    // kullanici pozisyonu alma
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    //kullanici pozisyonundan yerlesim noktasini bulma
    final List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    //sehri yerlesim noktasindan kaydetti
    final String? city = placemark[0].administrativeArea;

    if (city == null) Future.error("sorun oluştu");

    return city!;
  }

  Future<List<WeatherModel>> getWeatherData() async {
    final String city = await _getLocation();

    final String url =
        'https://api.collectapi.com/weather/getWeather?data.lang=tr&data.city=$city';
    const Map<String, dynamic> headers = {
      'authorization': "apikey 4I8DBYg8ETDeJrEZwwa0Pl:3Ht4IwjahVH2H75O2ecEDa",
      'content-type': 'application/json',
    };

    final dio = Dio();

    final response = await dio.get(url, options: Options(headers: headers));

    if (response.statusCode != 200) {
      return Future.error("bir sorun oluştu");
    }

    final List list = response.data['result'];

    final List<WeatherModel> weatherList =
        list.map((e) => WeatherModel.fromJyson(e)).toList();

    return weatherList;
  }
}
