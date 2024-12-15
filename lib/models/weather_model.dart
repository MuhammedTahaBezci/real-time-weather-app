class WeatherModel {
  final String gun;
  final String ikon;
  final String durum;
  final String derece;
  final String min;
  final String max;
  final String gece;
  final String nem;

  WeatherModel(this.gun, this.ikon, this.durum, this.derece, this.min, this.max,
      this.gece, this.nem);

  WeatherModel.fromJyson(Map<String, dynamic> jyson)
      : gun = jyson['day'],
        ikon = jyson['icon'],
        durum = jyson['description'],
        derece = jyson['degree'],
        min = jyson['min'],
        max = jyson['max'],
        gece = jyson['night'],
        nem = jyson['humidity'];
}
