# 🎨 Icons Klasörü

Bu klasör, uygulama içinde kullanılacak ikon dosyaları için ayrılmıştır.

## 📦 Dosya Formatları

- **SVG**: Vektörel ikonlar (önerilen - ölçeklenebilir)
- **PNG**: Bitmap ikonlar (24x24, 48x48, 72x72)

## 🎯 Önerilen İkonlar

### Temel İkonlar
```
taxi_icon.svg          (Taksi ikonu)
wallet_icon.svg        (Cüzdan ikonu)
receipt_icon.svg       (Fiş ikonu)
payment_icon.svg       (Ödeme ikonu)
card_icon.svg          (Kart ikonu)
```

### Durum İkonları
```
success_icon.svg       (Başarılı - yeşil tik)
error_icon.svg         (Hata - kırmızı X)
warning_icon.svg       (Uyarı - sarı ünlem)
info_icon.svg          (Bilgi - mavi i)
```

### İşlem İkonları
```
arrow_up.svg          (Para çıkışı)
arrow_down.svg        (Para girişi)
transfer.svg          (Transfer)
withdraw.svg          (Para çekme)
```

## 🚀 Kullanım

### SVG İkonları için

1. Paket ekleyin:
```yaml
dependencies:
  flutter_svg: ^2.0.9
```

2. Kullanın:
```dart
import 'package:flutter_svg/flutter_svg.dart';

SvgPicture.asset(
  'assets/icons/taxi_icon.svg',
  width: 24,
  height: 24,
  color: Colors.white,
)
```

### PNG İkonları için

```dart
Image.asset(
  'assets/icons/wallet_icon.png',
  width: 24,
  height: 24,
)
```

## 📐 Boyut Standartları

- **Küçük**: 24x24 (liste öğeleri, butonlar)
- **Orta**: 48x48 (kart başlıkları)
- **Büyük**: 72x72 (önemli aksiyonlar)

## 📝 Not

SVG ikonları için `flutter_svg` paketini eklemeyi unutmayın!
