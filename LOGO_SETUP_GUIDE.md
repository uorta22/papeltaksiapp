# 🎨 Logo Kullanım Rehberi - Papel Taksi

## 📍 Logo Dosyanız Nerede Olmalı?

### SVG Logo İçin (Uygulama İçi Kullanım)
```
assets/icons/papel_logo.svg  ← Buraya koyun
```

### PNG Logo İçin (Launcher Icon)
```
assets/images/papel_logo.png (512x512 veya 1024x1024)
```

---

## 🎯 3 Farklı Kullanım Yeri

### 1️⃣ Splash Screen'de Logo
**Konum:** Uygulama açılırken gösterilen logo

### 2️⃣ Uygulama İçinde Logo
**Konum:** AppBar, Dashboard vs.

### 3️⃣ Launcher Icon (Uygulama İkonu)
**Konum:** Ana ekran, uygulama listesi

---

## 🚀 Adım Adım Kurulum

### Adım 1: SVG Dosyasını Yerleştirin

```bash
# SVG dosyanızı buraya kopyalayın:
assets/icons/papel_logo.svg
```

### Adım 2: Flutter SVG Paketini Ekleyin

```yaml
# pubspec.yaml
dependencies:
  flutter_svg: ^2.0.9
```

```bash
flutter pub get
```

### Adım 3: Splash Screen'de Kullanın

```dart
// lib/presentation/screens/splash_screen.dart

import 'package:flutter_svg/flutter_svg.dart';

// Container yerine SvgPicture kullanın:
SvgPicture.asset(
  'assets/icons/papel_logo.svg',
  width: 120,
  height: 120,
  colorFilter: ColorFilter.mode(
    Colors.white,
    BlendMode.srcIn,
  ),
)
```

### Adım 4: AppBar'da Kullanın

```dart
// lib/presentation/screens/dashboard_screen.dart

AppBar(
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      SvgPicture.asset(
        'assets/icons/papel_logo.svg',
        height: 28,
        colorFilter: ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        ),
      ),
      SizedBox(width: 8),
      Text('Papel Taksi'),
    ],
  ),
)
```

---

## 📱 Launcher Icon İçin (Uygulama İkonu)

**ÖNEMLİ:** Launcher icon SVG formatında OLAMAZ! PNG formatında olmalı.

### Seçenek 1: Otomatik Oluşturma (ÖNERİLEN)

#### 1. flutter_launcher_icons Paketini Ekleyin

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/papel_logo.png"  # 512x512 PNG
  adaptive_icon_background: "#373B49"  # Papel rengi
  adaptive_icon_foreground: "assets/images/papel_logo.png"
```

#### 2. PNG Logo Hazırlayın

SVG'nizi PNG'ye çevirin (512x512 veya 1024x1024):
- Online: [CloudConvert](https://cloudconvert.com/svg-to-png)
- Photoshop/Figma'da export edin

```
assets/images/papel_logo.png  ← Buraya koyun
```

#### 3. Launcher Icon Oluşturun

```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

Bu komut otomatik olarak:
- ✅ android/app/src/main/res/mipmap-*/ic_launcher.png dosyalarını oluşturur
- ✅ Tüm boyutları (mdpi, hdpi, xhdpi, xxhdpi, xxxhdpi) oluşturur
- ✅ iOS için de ikon oluşturur

### Seçenek 2: Manuel Oluşturma

#### 1. PNG'leri Farklı Boyutlarda Hazırlayın

```
mipmap-mdpi:     48x48
mipmap-hdpi:     72x72
mipmap-xhdpi:    96x96
mipmap-xxhdpi:   144x144
mipmap-xxxhdpi:  192x192
```

#### 2. Manuel Olarak Kopyalayın

```bash
cp logo_48.png android/app/src/main/res/mipmap-mdpi/ic_launcher.png
cp logo_72.png android/app/src/main/res/mipmap-hdpi/ic_launcher.png
cp logo_96.png android/app/src/main/res/mipmap-xhdpi/ic_launcher.png
cp logo_144.png android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png
cp logo_192.png android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png
```

---

## 📋 Tam Örnek Kod

### Güncellenmiş Splash Screen

```dart
// lib/presentation/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:papeltaksi/core/constants/app_colors.dart';
import 'package:papeltaksi/presentation/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _navigateToLogin();
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _animationController.forward();
  }

  Future<void> _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SVG Logo
                      SvgPicture.asset(
                        'assets/icons/papel_logo.svg',
                        width: 120,
                        height: 120,
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'Papel Taksi',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Ödeme Çözümü',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 48),
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
```

---

## 🎨 Logo Renklendirme

### Beyaz Logo (Koyu Arka Plan)
```dart
SvgPicture.asset(
  'assets/icons/papel_logo.svg',
  colorFilter: ColorFilter.mode(
    Colors.white,
    BlendMode.srcIn,
  ),
)
```

### Koyu Logo (Açık Arka Plan)
```dart
SvgPicture.asset(
  'assets/icons/papel_logo.svg',
  colorFilter: ColorFilter.mode(
    AppColors.primary,
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

## 📂 Önerilen Klasör Yapısı

```
assets/
├── icons/
│   ├── papel_logo.svg          ← SVG logo (uygulama içi)
│   └── papel_logo_white.svg    ← Beyaz versiyon (opsiyonel)
│
└── images/
    ├── papel_logo.png          ← PNG logo (512x512 - launcher için)
    └── papel_logo_1024.png     ← Yüksek çözünürlük (opsiyonel)
```

---

## ⚡ Hızlı Başlangıç (3 Dakika)

### 1. Dosyaları Yerleştirin
```bash
# SVG'yi kopyalayın
cp /path/to/logo.svg assets/icons/papel_logo.svg

# PNG'yi hazırlayın (512x512)
# SVG → PNG çevirici: https://cloudconvert.com/svg-to-png
cp /path/to/logo.png assets/images/papel_logo.png
```

### 2. pubspec.yaml Güncelleyin
```yaml
dependencies:
  flutter_svg: ^2.0.9

dev_dependencies:
  flutter_launcher_icons: ^0.13.1

flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/images/papel_logo.png"
  adaptive_icon_background: "#373B49"
  adaptive_icon_foreground: "assets/images/papel_logo.png"
```

### 3. Komutları Çalıştırın
```bash
flutter pub get
flutter pub run flutter_launcher_icons
```

### 4. Splash Screen'i Güncelleyin
Yukarıdaki "Güncellenmiş Splash Screen" kodunu kullanın.

---

## 🔧 Sorun Giderme

### SVG Görünmüyor?
```bash
flutter clean
flutter pub get
flutter run
```

### Launcher Icon Değişmedi?
```bash
# Android
flutter clean
flutter run

# Veya cihazdan uygulamayı kaldırıp yeniden yükleyin
```

### SVG Renkleri Yanlış?
```dart
// colorFilter kullanarak tek renge çevirin
colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn)
```

---

## 📚 Kaynak Araçları

**SVG → PNG Çevirme:**
- [CloudConvert](https://cloudconvert.com/svg-to-png)
- [SVG to PNG Converter](https://svgtopng.com/)
- [Online Convert](https://image.online-convert.com/convert-to-png)

**Icon Oluşturucu:**
- [App Icon Generator](https://appicon.co/)
- [MakeAppIcon](https://makeappicon.com/)

---

## ✅ Kontrol Listesi

- [ ] SVG dosyası `assets/icons/` klasörüne eklendi
- [ ] PNG dosyası `assets/images/` klasörüne eklendi (512x512)
- [ ] `flutter_svg` paketi eklendi
- [ ] `flutter_launcher_icons` paketi eklendi (dev_dependencies)
- [ ] `pubspec.yaml` yapılandırıldı
- [ ] `flutter pub get` çalıştırıldı
- [ ] `flutter pub run flutter_launcher_icons` çalıştırıldı
- [ ] Splash screen kodu güncellendi
- [ ] Uygulama test edildi

---

**Hazırlayan:** Claude Code
**Tarih:** 27 Ekim 2024
**Proje:** Papel Taksi
