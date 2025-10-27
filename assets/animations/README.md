# ✨ Animations Klasörü

Bu klasör, Lottie JSON animasyon dosyaları için ayrılmıştır.

## 📦 Dosya Formatı

- **JSON**: Lottie animasyon dosyaları

## 🎯 Önerilen Animasyonlar

### Ödeme Animasyonları
```
payment_success.json    (Ödeme başarılı - yeşil tik)
payment_failed.json     (Ödeme başarısız - kırmızı X)
payment_processing.json (Ödeme işleniyor - yükleme)
```

### Yükleme Animasyonları
```
loading.json           (Genel yükleme)
loading_dots.json      (Noktalı yükleme)
splash_animation.json  (Splash ekran animasyonu)
```

### Durum Animasyonları
```
empty_state.json       (Boş durum - kutu açılıyor)
no_transactions.json   (İşlem yok)
success_checkmark.json (Başarı - tik animasyonu)
error_cross.json       (Hata - X animasyonu)
```

### Etkileşim Animasyonları
```
card_swipe.json        (Kart kaydırma)
money_transfer.json    (Para transferi)
wallet_animation.json  (Cüzdan açılma)
```

## 🌐 Animasyon Kaynakları

**Ücretsiz Lottie Animasyonları:**
- [LottieFiles.com](https://lottiefiles.com/) - En popüler kaynak
- [Icons8 Animated Icons](https://icons8.com/animated-icons)
- [Lordicon](https://lordicon.com/)

## 🚀 Kullanım

### 1. Paket Ekleyin

```yaml
# pubspec.yaml
dependencies:
  lottie: ^3.0.0
```

### 2. Animasyonu Kullanın

```dart
import 'package:lottie/lottie.dart';

// Basit kullanım
Lottie.asset('assets/animations/payment_success.json')

// Gelişmiş kullanım
Lottie.asset(
  'assets/animations/payment_success.json',
  width: 200,
  height: 200,
  repeat: false,  // Bir kez oynat
  animate: true,  // Otomatik başlat
)

// Controller ile kontrol
class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/animations/payment_processing.json',
      controller: _controller,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        _controller.forward();
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
```

## 💡 Kullanım Örnekleri

### Ödeme Başarılı Ekranında

```dart
void _showPaymentSuccess() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            'assets/animations/payment_success.json',
            width: 150,
            height: 150,
            repeat: false,
          ),
          SizedBox(height: 16),
          Text('Ödeme Başarılı!'),
        ],
      ),
    ),
  );
}
```

### Yükleme Animasyonu

```dart
Center(
  child: Lottie.asset(
    'assets/animations/loading.json',
    width: 100,
    height: 100,
  ),
)
```

### Boş Durum

```dart
if (transactions.isEmpty)
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Lottie.asset(
        'assets/animations/empty_state.json',
        width: 200,
        height: 200,
      ),
      Text('Henüz işlem yok'),
    ],
  )
```

## 📐 Boyut Önerileri

- **Küçük**: 100x100 (inline animasyonlar)
- **Orta**: 150x150 (dialog animasyonları)
- **Büyük**: 200x200 (splash/boş durum)

## ⚡ Performans İpuçları

1. Animasyon dosyalarını optimize edin (< 100KB)
2. Karmaşık animasyonları az kullanın
3. Gereksiz repeat: true kullanmayın
4. dispose() metodunda controller'ı temizleyin

## 📝 Not

- Lottie dosyaları After Effects'ten export edilir
- Boyut önemli - büyük dosyalar performansı etkiler
- Renkler kodda değiştirilebilir (bazı animasyonlar için)
