# 🚀 Logo Kurulum Talimatları

## ✅ HAZIR! Kod güncellenmiş durumda.

Şimdi sadece logo dosyalarınızı eklemeniz gerekiyor:

---

## 📍 1. SVG Logo Ekleyin (Uygulama İçi)

```bash
# SVG dosyanızı buraya kopyalayın:
assets/icons/papel_logo.svg
```

**Kullanıldığı yerler:**
- ✅ Splash Screen (uygulama açılışı)
- ✅ AppBar (ileride eklenebilir)
- ✅ Login Screen (ileride eklenebilir)

---

## 📍 2. PNG Logo Ekleyin (Launcher Icon)

```bash
# PNG dosyanızı buraya kopyalayın (512x512 veya 1024x1024):
assets/images/papel_logo.png
```

**SVG'yi PNG'ye nasıl çevirebilirsiniz?**
- Online: https://cloudconvert.com/svg-to-png
- Boyut: 512x512 veya 1024x1024
- Format: PNG (şeffaf arka plan)

---

## 🔧 3. Komutları Çalıştırın

```bash
# 1. Paketleri yükle
flutter pub get

# 2. Launcher icon'ları oluştur (PNG ekledikten sonra)
flutter pub run flutter_launcher_icons

# 3. Uygulamayı çalıştır
flutter run
```

---

## 📂 Dosya Konumları

```
papeltaksiapp/
├── assets/
│   ├── icons/
│   │   └── papel_logo.svg        ← SVG LOGONUZ BURAYA
│   └── images/
│       └── papel_logo.png        ← PNG LOGONUZ BURAYA (512x512)
│
└── android/app/src/main/res/
    ├── mipmap-mdpi/ic_launcher.png    ← Otomatik oluşturulur
    ├── mipmap-hdpi/ic_launcher.png    ← Otomatik oluşturulur
    ├── mipmap-xhdpi/ic_launcher.png   ← Otomatik oluşturulur
    ├── mipmap-xxhdpi/ic_launcher.png  ← Otomatik oluşturulur
    └── mipmap-xxxhdpi/ic_launcher.png ← Otomatik oluşturulur
```

---

## ✨ Yapılan Güncellemeler

### ✅ pubspec.yaml
- `flutter_launcher_icons` paketi eklendi
- Assets klasörleri tanımlandı
- Launcher icon yapılandırması eklendi

### ✅ splash_screen.dart
- `flutter_svg` import edildi
- SVG logo kullanımı eklendi
- Beyaz renk filtresi uygulandı

### ✅ Mevcut Paketler
- `flutter_svg: ^2.0.9` ← Zaten yüklü!
- `flutter_launcher_icons: ^0.13.1` ← YENİ eklendi

---

## 🎨 Logo Renklendirme

### Splash Screen'de (Beyaz)
```dart
// Zaten uygulandı - değişiklik gerekmez
SvgPicture.asset(
  'assets/icons/papel_logo.svg',
  colorFilter: ColorFilter.mode(
    Colors.white,
    BlendMode.srcIn,
  ),
)
```

### Koyu Arka Planda (Papel rengi)
```dart
SvgPicture.asset(
  'assets/icons/papel_logo.svg',
  colorFilter: ColorFilter.mode(
    AppColors.primary,  // #373B49
    BlendMode.srcIn,
  ),
)
```

### Orijinal Renkler
```dart
SvgPicture.asset(
  'assets/icons/papel_logo.svg',
  // colorFilter kullanmayın
)
```

---

## 🆘 Sorun Giderme

### SVG görünmüyor?

**1. Dosya var mı?**
```bash
ls -la assets/icons/papel_logo.svg
```

**2. Temizle ve yeniden çalıştır:**
```bash
flutter clean
flutter pub get
flutter run
```

### Launcher Icon değişmedi?

**1. Icon'ları yeniden oluştur:**
```bash
flutter pub run flutter_launcher_icons
```

**2. Uygulamayı cihazdan kaldır ve yeniden yükle:**
```bash
# Cihazdan kaldır
adb uninstall com.papel.taksi

# Yeniden yükle
flutter run
```

### SVG hatalı mı?

**SVG dosyanız şu özelliklere sahip olmalı:**
- ✅ Geçerli SVG formatı
- ✅ Sadece path/shape elementleri (resim embed yok)
- ✅ Boyut bilgisi var (width/height veya viewBox)

**Test edin:**
```bash
# SVG'yi tarayıcıda açın
# Hata varsa SVG editörde (Figma, Illustrator) düzeltin
```

---

## 📋 Adım Adım Kontrol Listesi

- [ ] SVG logo `assets/icons/papel_logo.svg` konumuna eklendi
- [ ] PNG logo `assets/images/papel_logo.png` konumuna eklendi (512x512)
- [ ] `flutter pub get` çalıştırıldı
- [ ] `flutter pub run flutter_launcher_icons` çalıştırıldı
- [ ] Uygulama çalıştırıldı ve splash screen'de logo görüldü
- [ ] Ana ekranda uygulama ikonu kontrol edildi

---

## 💡 İpuçları

1. **SVG Optimizasyonu:**
   - SVGO ile optimize edin: https://jakearchibald.github.io/svgomg/
   - Gereksiz metadata'ları kaldırın

2. **PNG Kalitesi:**
   - Minimum 512x512
   - Önerilen 1024x1024
   - Şeffaf arka plan

3. **Renk Uyumu:**
   - Papel primary: #373B49
   - Papel accent: #4D38E7
   - Beyaz splash arka planında iyi görünür

---

## 📞 Yardım

Detaylı bilgi için:
- `LOGO_SETUP_GUIDE.md` - Tam rehber
- `ASSET_GUIDE.md` - Genel asset rehberi

---

**Hazırlayan:** Claude Code
**Tarih:** 27 Ekim 2024
