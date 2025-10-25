# 🎨 Papel Taksi - Görsel ve Animasyon Ekleme Rehberi

Bu belge, Papel Taksi uygulamasına görsel, ikon ve animasyon ekleme konusunda tam bir rehber sunmaktadır.

## 📁 Klasör Yapısı

```
papeltaksiapp/
├── assets/
│   ├── images/          # PNG, JPG görsel dosyaları
│   ├── icons/           # SVG, PNG ikon dosyaları
│   ├── animations/      # Lottie JSON animasyonlar
│   └── fonts/           # Özel fontlar (opsiyonel)
```

## 🖼️ 1. Görsel Ekleme

### Adım 1: Görsel Dosyalarını Yerleştirin

Görsellerinizi şu klasörlere koyun:

```bash
# Logo için
assets/images/logo.png
assets/images/logo_white.png

# Kart arkaplan görselleri
assets/images/card_background.png
assets/images/wallet_card_bg.png

# Onboarding görselleri
assets/images/onboarding_1.png
assets/images/onboarding_2.png
assets/images/onboarding_3.png

# Boş durum görselleri
assets/images/empty_transactions.png
assets/images/no_data.png
```

### Adım 2: pubspec.yaml Dosyasını Güncelleyin

`pubspec.yaml` dosyasına assets bölümünü ekleyin:

```yaml
flutter:
  uses-material-design: true

  # Görseller
  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/
```

### Adım 3: Görseli Kullanın

```dart
// Basit kullanım
Image.asset(
  'assets/images/logo.png',
  width: 100,
  height: 100,
)

// DecorationImage ile (arka plan için)
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/card_background.png'),
      fit: BoxFit.cover,
    ),
  ),
)

// CircleAvatar ile
CircleAvatar(
  backgroundImage: AssetImage('assets/images/profile.png'),
  radius: 40,
)
```

## 🎭 2. İkonlar

### SVG İkonları İçin

1. **pubspec.yaml'a paket ekleyin:**

```yaml
dependencies:
  flutter_svg: ^2.0.9
```

2. **Kullanım:**

```dart
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
  'assets/icons/taxi.svg',
  width: 24,
  height: 24,
  color: Colors.white,
)
```

### PNG İkonları

```dart
Image.asset(
  'assets/icons/wallet_icon.png',
  width: 24,
  height: 24,
)
```

## ✨ 3. Animasyonlar

### Lottie Animasyonları (Önerilen)

1. **pubspec.yaml'a paket ekleyin:**

```yaml
dependencies:
  lottie: ^3.0.0
```

2. **Lottie dosyalarını ekleyin:**
   - [LottieFiles](https://lottiefiles.com/) sitesinden animasyon indirin
   - JSON dosyasını `assets/animations/` klasörüne atın

3. **Kullanım:**

```dart
import 'package:lottie/lottie.dart';

// Basit kullanım
Lottie.asset('assets/animations/loading.json')

// Gelişmiş kullanım
Lottie.asset(
  'assets/animations/success.json',
  width: 200,
  height: 200,
  repeat: false,
  animate: true,
)
```

### Flutter Yerleşik Animasyonları

#### A. Fade Geçişleri

```dart
AnimatedOpacity(
  opacity: _isVisible ? 1.0 : 0.0,
  duration: Duration(milliseconds: 500),
  child: YourWidget(),
)
```

#### B. Slide Geçişleri

```dart
AnimatedSlide(
  offset: _isVisible ? Offset.zero : Offset(0, 0.5),
  duration: Duration(milliseconds: 300),
  child: YourWidget(),
)
```

#### C. Sayfa Geçiş Animasyonları

```dart
// Dashboard'dan Payment'a geçişte kullanılabilir
Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => PaymentScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  ),
);
```

#### D. Hero Animasyonları (Kart Geçişleri)

```dart
// Dashboard'da
Hero(
  tag: 'wallet-card',
  child: WalletCard(),
)

// Cüzdan sayfasında
Hero(
  tag: 'wallet-card',
  child: DetailedWalletCard(),
)
```

## 🎬 4. Papel Taksi İçin Özel Animasyonlar

### Splash Screen için

```dart
class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Image.asset('assets/images/logo.png'),
      ),
    );
  }
}
```

### Kart Flip Animasyonu

```dart
class FlipCard extends StatefulWidget {
  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _flip() {
    if (_showFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _showFront = !_showFront);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * 3.14159;
          return Transform(
            transform: Matrix4.rotationY(angle),
            alignment: Alignment.center,
            child: angle < 3.14159 / 2
                ? CardFrontWidget()
                : Transform(
                    transform: Matrix4.rotationY(3.14159),
                    alignment: Alignment.center,
                    child: CardBackWidget(),
                  ),
          );
        },
      ),
    );
  }
}
```

### Shimmer Loading Effect

```dart
import 'package:shimmer/shimmer.dart';

// pubspec.yaml'a ekle: shimmer: ^3.0.0

Shimmer.fromColors(
  baseColor: Colors.grey[300]!,
  highlightColor: Colors.grey[100]!,
  child: Container(
    width: double.infinity,
    height: 200.0,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
    ),
  ),
)
```

## 📐 5. Görsel Boyutları (Önerilen)

### Launcher İkonları (Zaten var)
- mdpi: 48x48
- hdpi: 72x72
- xhdpi: 96x96
- xxhdpi: 144x144
- xxxhdpi: 192x192

### Uygulama İçi Görseller
- **Logo**: 512x512 (PNG, transparent background)
- **Kart Arkaplanı**: 1080x600
- **Splash Screen**: 1080x1920
- **Onboarding**: 1080x1350
- **İkonlar**: 24x24, 48x48, 72x72 (3 farklı boyut)

## 🎯 6. Papel Taksi İçin Önerilen Görseller

İşte eklemenizi önerdiğim görseller:

1. **Logo**
   - `assets/images/papel_logo.png` - Ana logo
   - `assets/images/papel_logo_white.png` - Beyaz versiyon

2. **Kart Görselleri**
   - `assets/images/card_chip.png` - Kart chip görseli
   - `assets/images/contactless.png` - Temassız ödeme ikonu

3. **Animasyonlar**
   - `assets/animations/payment_success.json` - Ödeme başarılı
   - `assets/animations/payment_processing.json` - Ödeme işleniyor
   - `assets/animations/loading.json` - Yükleniyor
   - `assets/animations/empty_state.json` - Boş durum

4. **Onboarding**
   - `assets/images/onboarding_payment.png` - Ödeme alma
   - `assets/images/onboarding_wallet.png` - Cüzdan yönetimi
   - `assets/images/onboarding_tracking.png` - İşlem takibi

## 🚀 7. Hızlı Başlangıç Kodu

Hemen kullanabileceğiniz örnek bir widget:

```dart
// lib/core/widgets/animated_card.dart
import 'package:flutter/material.dart';

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const AnimatedCard({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap?.call();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
```

## 📝 8. Kullanım Örnekleri

### Dashboard'da Logo Ekleme

```dart
// lib/presentation/screens/dashboard_screen.dart içinde

AppBar(
  title: Image.asset(
    'assets/images/papel_logo_white.png',
    height: 32,
  ),
  ...
)
```

### Ödeme Başarılı Animasyonu

```dart
// Payment screen'de başarı durumunda

Lottie.asset(
  'assets/animations/payment_success.json',
  width: 150,
  height: 150,
  repeat: false,
)
```

## 🔧 Sorun Giderme

### Görsel Görünmüyor?

1. `flutter clean` çalıştırın
2. `flutter pub get` çalıştırın
3. Uygulamayı yeniden build edin

### pubspec.yaml Hatası?

- Girintilerin doğru olduğundan emin olun (2 boşluk)
- Tire (-) işaretinden sonra boşluk olmalı
- Dosya yolları doğru yazılmalı

## 📚 Faydalı Kaynaklar

- **Lottie Animasyonlar**: https://lottiefiles.com/
- **Ücretsiz İkonlar**: https://www.flaticon.com/
- **Ücretsiz Görseller**: https://unsplash.com/
- **Flutter Animasyon Rehberi**: https://docs.flutter.dev/development/ui/animations

---

Bu rehberi kullanarak Papel Taksi uygulamanıza profesyonel görseller ve akıcı animasyonlar ekleyebilirsiniz!
