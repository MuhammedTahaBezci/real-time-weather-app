Weather App
Weather App, kullanıcının konum bilgilerini alarak mevcut hava durumunu gösteren basit bir Flutter uygulamasıdır. Bu proje, kullanıcının şehir bazlı hava durumu verilerini API üzerinden çekerek görsel olarak listeler.

Proje Dosya Yapısı

WEATHER/
│
├── android/
├── build/
├── lib/
│   ├── models/
│   │   └── weather_model.dart         # Hava durumu modeli (Veri formatı)
│   │
│   ├── screens/
│   │   └── home_page.dart             # Ana ekran tasarımı ve listeleme
│   │
│   ├── services/
│   │   └── weather_services.dart      # Konum alımı ve API istekleri
│   │
│   └── main.dart                      # Uygulamanın başlangıç noktası
│
├── test/
│   └── widget_test.dart
│
├── pubspec.yaml                       # Bağımlılıklar ve proje tanımı
├── assets/
│   └── screenshots/
│       └── screenshot_1.png
├── README.md                          # Proje açıklaması
└── weather.iml


Kurulum ve Çalıştırma

1. Gereksinimler
Flutter SDK (>=3.0.0)
Android Studio veya Visual Studio Code
Emülatör veya Fiziksel Cihaz

2. Proje Bağımlılıklarını Kurun
Aşağıdaki komut ile gerekli bağımlılıkları kurun:   
flutter pub get

3. Proje Bağımlılıkları
Proje pubspec.yaml dosyasında aşağıdaki paketleri kullanır:
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.0.0          # HTTP istekleri için kullanılır
  geolocator: ^9.0.0   # Kullanıcı konumu almak için
  geocoding: ^3.0.0    # Konum bilgisini şehre dönüştürmek için

4. API Anahtarı
Proje, CollectAPI üzerinden hava durumu verilerini çeker. Kendi API anahtarınızı almak için:

4.1. CollectAPI'ye kaydolun.
4.2. Weather API için anahtar oluşturun.
4.3. Anahtarı weather_services.dart dosyasındaki authorization başlığında güncelleyin:
const Map<String, dynamic> headers = {
  'authorization': "apikey YOUR_API_KEY",
  'content-type': 'application/json',
};


Kod Açıklamaları

1. Ana Giriş Noktası (main.dart)
Uygulama HomePage widget'ını çalıştırır.
void main() {
  runApp(const Home());
}

2. Hava Durumu Servisi (weather_services.dart)
2.1.Kullanıcı konumunu alır ve API'den hava durumu verilerini çeker.
2.2 Konum servisleri için geolocator kullanılır.
final Position position = await Geolocator.getCurrentPosition();
2.3.API isteği:
final response = await dio.get(url, options: Options(headers: headers));

3. Ana Ekran (home_page.dart)
3.1.Hava durumu verilerini liste şeklinde gösterir.
3.2.Her bir hava durumu öğesi için:
    Görsel ikon
    Gün, sıcaklık, nem bilgileri gösterilir.

Çalıştırma

Uygulamayı aşağıdaki komutla çalıştırabilirsiniz:
flutter run

![screenshot_1](assets/screenshots/screenshot_1.png)