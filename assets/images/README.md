# 🖼️ Images Klasörü

Bu klasör, uygulama içinde kullanılacak görsel dosyaları için ayrılmıştır.

## 📦 Dosya Formatları

- **PNG**: Şeffaf arkaplan gerektiren görseller (logolar, ikonlar)
- **JPG**: Fotoğraflar ve arka plan görselleri
- **WebP**: Optimize edilmiş görseller (opsiyonel)

## 📐 Önerilen Görseller

### Logo
```
papel_logo.png          (512x512 - transparent background)
papel_logo_white.png    (512x512 - beyaz versiyon)
```

### Kart Görselleri
```
card_background.png     (1080x600 - kart arkaplanı)
card_chip.png          (80x60 - kart çipi)
contactless_icon.png   (48x48 - temassız ödeme ikonu)
```

### Onboarding Görselleri
```
onboarding_1.png       (1080x1350 - ödeme alma)
onboarding_2.png       (1080x1350 - cüzdan yönetimi)
onboarding_3.png       (1080x1350 - işlem takibi)
```

### Boş Durum Görselleri
```
empty_transactions.png (512x512)
no_data.png           (512x512)
```

## 🚀 Kullanım

```dart
// Logo örneği
Image.asset('assets/images/papel_logo.png', height: 50)

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

## 📝 Not

Görsel ekledikten sonra `flutter pub get` komutunu çalıştırmayı unutmayın!
