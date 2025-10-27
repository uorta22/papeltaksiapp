# 🔤 Fonts Klasörü

Bu klasör, özel font dosyaları için ayrılmıştır.

## 📦 Dosya Formatları

- **TTF** (TrueType Font): Yaygın kullanım
- **OTF** (OpenType Font): Gelişmiş özellikler

## 🎯 Önerilen Fontlar (Papel Taksi için)

### Profesyonel Görünüm

**Poppins** (Modern ve okunabilir)
```
Poppins-Regular.ttf
Poppins-Medium.ttf
Poppins-SemiBold.ttf
Poppins-Bold.ttf
```

**Inter** (Ekran okumaya optimize)
```
Inter-Regular.ttf
Inter-Medium.ttf
Inter-SemiBold.ttf
Inter-Bold.ttf
```

### Finansal Uygulamalar İçin

**Roboto** (Material Design)
```
Roboto-Regular.ttf
Roboto-Medium.ttf
Roboto-Bold.ttf
```

**SF Pro** (iOS tarzı)
```
SFProDisplay-Regular.ttf
SFProDisplay-Medium.ttf
SFProDisplay-Bold.ttf
```

## 🌐 Ücretsiz Font Kaynakları

- [Google Fonts](https://fonts.google.com/)
- [Font Squirrel](https://www.fontsquirrel.com/)
- [DaFont](https://www.dafont.com/)

## 🚀 Kullanım

### 1. Font Dosyalarını Ekleyin

Dosyaları bu klasöre kopyalayın:
```
assets/fonts/Poppins-Regular.ttf
assets/fonts/Poppins-Bold.ttf
```

### 2. pubspec.yaml'ı Güncelleyin

```yaml
flutter:
  fonts:
    - family: Poppins
      fonts:
        - asset: assets/fonts/Poppins-Regular.ttf
        - asset: assets/fonts/Poppins-Medium.ttf
          weight: 500
        - asset: assets/fonts/Poppins-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Poppins-Bold.ttf
          weight: 700
```

### 3. Tema'da Kullanın

```dart
// lib/core/theme/app_theme.dart

ThemeData(
  fontFamily: 'Poppins',
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.bold,
      fontSize: 32,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.normal,
      fontSize: 16,
    ),
  ),
)
```

### 4. Widget'ta Kullanın

```dart
// Direkt kullanım
Text(
  'Papel Taksi',
  style: TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
    fontSize: 24,
  ),
)

// Tema'dan kullanım
Text(
  'Papel Taksi',
  style: Theme.of(context).textTheme.displayLarge,
)
```

## 🎨 Font Ağırlıkları

```dart
FontWeight.w100  // Thin
FontWeight.w200  // ExtraLight
FontWeight.w300  // Light
FontWeight.w400  // Regular (normal)
FontWeight.w500  // Medium
FontWeight.w600  // SemiBold
FontWeight.w700  // Bold
FontWeight.w800  // ExtraBold
FontWeight.w900  // Black
```

## 💡 Papel Taksi İçin Öneriler

### Ana Font
**Poppins** veya **Inter** kullanın:
- Modern görünüm
- Ekranda okunabilir
- Türkçe karakter desteği
- Profesyonel

### Font Kullanım Hiyerarşisi

```dart
// Başlıklar
displayLarge: Poppins Bold, 32px

// Alt başlıklar
headlineMedium: Poppins SemiBold, 24px

// Normal metin
bodyLarge: Poppins Regular, 16px

// Küçük metin
bodySmall: Poppins Regular, 14px

// Tutar gösterimi
Custom: Poppins Bold, 42px (ödeme ekranı)
```

## 📐 Boyut Standartları

```dart
// Dashboard
Başlık: 24px Bold
Kart başlığı: 14px Regular
Tutar: 36px Bold
Alt yazı: 12px Regular

// Payment Screen
Yolculuk Tutarı başlık: 28px Bold
Tutar gösterimi: 42px Bold
Hizmet tutarı: 18px SemiBold

// Profil
İsim: 24px Bold
Bilgi etiketi: 12px Regular
Bilgi değeri: 14px SemiBold
```

## ⚠️ Önemli Notlar

1. **Lisans Kontrolü**: Font lisansını mutlaka kontrol edin
2. **Dosya Boyutu**: Gereksiz font ağırlıklarını eklemeyin
3. **Türkçe Karakter**: Türkçe karakter desteği olmalı (ğ, ü, ş, ı, ö, ç)
4. **Yükleme Süresi**: Çok fazla font dosyası uygulamayı yavaşlatır

## 📝 Şu Anda

Projede varsayılan olarak **Material Design** fontu kullanılıyor. Özel font eklemek opsiyoneldir.

## 🔄 Font Değiştirme Süreci

1. Font dosyalarını indir
2. Bu klasöre kopyala
3. `pubspec.yaml`'ı güncelle
4. `flutter pub get` çalıştır
5. `app_theme.dart`'ta fontFamily belirt
6. Uygulamayı restart et
