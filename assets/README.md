# 📦 Assets Klasörü

Bu klasör, Papel Taksi uygulamasının tüm görsel ve medya varlıklarını içerir.

## 📁 Klasör Yapısı

```
assets/
├── 🖼️ images/       → Görsel dosyaları (PNG, JPG)
├── 🎨 icons/        → İkon dosyaları (SVG, PNG)
├── ✨ animations/   → Lottie animasyonlar (JSON)
└── 🔤 fonts/        → Özel fontlar (TTF, OTF)
```

## 🚀 Hızlı Başlangıç

### 1. pubspec.yaml'ı Güncelle

```yaml
flutter:
  uses-material-design: true

  # Assets
  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/

  # Fonts (opsiyonel)
  # fonts:
  #   - family: Poppins
  #     fonts:
  #       - asset: assets/fonts/Poppins-Regular.ttf
  #       - asset: assets/fonts/Poppins-Bold.ttf
  #         weight: 700
```

### 2. Dosya Ekle

```bash
# Örnek: Logo eklemek
cp /path/to/logo.png assets/images/papel_logo.png
```

### 3. Kodu Yenile

```bash
flutter pub get
```

### 4. Kullan

```dart
Image.asset('assets/images/papel_logo.png')
```

## 📖 Detaylı Rehberler

Her klasörün kendi README.md dosyası var:

- **images/README.md** - Görsel ekleme rehberi
- **icons/README.md** - İkon ekleme rehberi
- **animations/README.md** - Animasyon ekleme rehberi
- **fonts/README.md** - Font ekleme rehberi

## 🎯 Papel Taksi İçin Öncelikli Varlıklar

### Yüksek Öncelik (Hemen Ekle)

1. **Logo**
   - `images/papel_logo.png` (512x512)
   - `images/papel_logo_white.png` (beyaz versiyon)

2. **Loading Animasyonu**
   - `animations/loading.json`
   - `animations/payment_processing.json`

3. **Success Animasyonu**
   - `animations/payment_success.json`

### Orta Öncelik

4. **Kart Görselleri**
   - `images/card_background.png`
   - `images/card_chip.png`

5. **Durum Animasyonları**
   - `animations/payment_failed.json`
   - `animations/empty_state.json`

### Düşük Öncelik (İleride)

6. **Onboarding Görselleri**
   - `images/onboarding_1.png`
   - `images/onboarding_2.png`
   - `images/onboarding_3.png`

7. **Özel Font**
   - `fonts/Poppins-Regular.ttf`
   - `fonts/Poppins-Bold.ttf`

## 💡 Kullanım Örnekleri

### Görsel

```dart
// AppBar'da logo
Image.asset(
  'assets/images/papel_logo_white.png',
  height: 32,
)

// Kart arkaplanı
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/card_background.png'),
      fit: BoxFit.cover,
    ),
  ),
)
```

### Animasyon

```dart
import 'package:lottie/lottie.dart';

// Ödeme başarılı
Lottie.asset(
  'assets/animations/payment_success.json',
  width: 200,
  height: 200,
  repeat: false,
)
```

### İkon (SVG)

```dart
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
  'assets/icons/wallet_icon.svg',
  width: 24,
  height: 24,
  color: Colors.white,
)
```

## 📐 Dosya Boyutu Önerileri

- **Görseller**: < 500 KB (optimize edin)
- **İkonlar**: < 50 KB
- **Animasyonlar**: < 100 KB
- **Fontlar**: < 200 KB per dosya

## 🔧 Optimizasyon Araçları

- **Görsel**: [TinyPNG](https://tinypng.com/)
- **SVG**: [SVGOMG](https://jakearchibald.github.io/svgomg/)
- **Lottie**: [LottieFiles Optimizer](https://lottiefiles.com/)

## 📚 Faydalı Kaynaklar

### Görsel Kaynakları
- [Unsplash](https://unsplash.com/) - Ücretsiz fotoğraflar
- [Pexels](https://www.pexels.com/) - Ücretsiz görseller

### İkon Kaynakları
- [Flaticon](https://www.flaticon.com/) - Ücretsiz ikonlar
- [Icons8](https://icons8.com/) - İkon kütüphanesi
- [Heroicons](https://heroicons.com/) - SVG ikonlar

### Animasyon Kaynakları
- [LottieFiles](https://lottiefiles.com/) - En büyük Lottie kütüphanesi
- [Lordicon](https://lordicon.com/) - Animated ikonlar

### Font Kaynakları
- [Google Fonts](https://fonts.google.com/) - Ücretsiz fontlar
- [Font Squirrel](https://www.fontsquirrel.com/) - Ticari kullanım OK

## ⚠️ Önemli Notlar

1. **Lisans**: Tüm varlıkların lisansını kontrol edin
2. **Optimizasyon**: Dosya boyutlarını küçük tutun
3. **İsimlendirme**: Küçük harf ve alt çizgi kullanın (logo_white.png)
4. **Türkçe Karakter**: Dosya adlarında Türkçe karakter kullanmayın

## 🆘 Sorun Giderme

**Varlık görünmüyor?**
```bash
flutter clean
flutter pub get
flutter run
```

**pubspec.yaml hatası?**
- Girintilere dikkat (2 boşluk)
- Tire (-) sonrası boşluk olmalı

**Dosya bulunamadı hatası?**
- Dosya yolunu kontrol edin
- Büyük/küçük harf duyarlı
- pubspec.yaml'da tanımlı mı?

## 📞 Yardım

Detaylı bilgi için:
- **Tam Rehber**: `ASSET_GUIDE.md`
- **Hızlı Başlangıç**: `QUICK_START_ASSETS.md`
- **Proje Yapısı**: `PROJECT_STRUCTURE_ANALYSIS.md`

---

**Not**: Bu klasörler GitHub'ta görünür olması için README.md dosyaları eklenmiştir.
Git boş klasörleri takip etmez, bu yüzden her klasörde en az bir dosya olmalıdır.
