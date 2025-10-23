# Papel Taksi - Ödeme Uygulaması

Papel E-Para A.Ş.'nin Taksi POS Uygulaması - SoftPOS ve Fiziksel POS desteği ile taksi ödeme çözümü

## Proje Hakkında

Papel Taksi, taksi sürücülerinin hem ödeme alabilecekleri hem de hakedişlerini yönetebilecekleri entegre bir POS + dijital cüzdan çözümüdür. Uygulama, Android tabletler ve POS cihazlarında çalışarak şoförlerin yolculardan güvenli ve hızlı bir şekilde ödeme almalarını sağlar.

### Temel Özellikler

- ✅ **SoftPOS Entegrasyonu**: Payneos SoftPOS ile temassız ödeme alma
- ✅ **Fiziksel POS Desteği**: PAVO POS cihazları ile entegrasyon
- ✅ **Dijital Cüzdan**: Papel Wallet entegrasyonu ile anlık hakediş
- ✅ **Fraud Koruması**: FORMICA entegrasyonu ile güvenlik
- ✅ **KYC Onboarding**: Sürücü doğrulama ve kayıt sistemi
- ✅ **Modern UI/UX**: Şık ve kullanıcı dostu arayüz

## Teknoloji Stack

### Mobil Uygulama
- **Framework**: Flutter 3.x
- **Dil**: Dart
- **State Management**: Riverpod
- **Routing**: Go Router
- **HTTP Client**: Dio + Retrofit
- **Local Storage**: Hive + Shared Preferences

### Backend (Planlanan)
- **Framework**: Node.js + NestJS
- **Database**: PostgreSQL + Redis
- **API Docs**: OpenAPI/Swagger

## Proje Yapısı

```
papeltaksiapp/
├── android/                    # Android native konfigürasyonları
│   ├── app/
│   │   ├── src/main/
│   │   │   ├── kotlin/        # Kotlin native kodu
│   │   │   ├── res/           # Android resources
│   │   │   └── AndroidManifest.xml
│   │   └── build.gradle       # App level gradle
│   └── build.gradle           # Project level gradle
├── lib/                        # Flutter kaynak kodları
│   ├── core/                  # Çekirdek modüller
│   │   ├── constants/         # Sabitler (renkler, stringler)
│   │   ├── theme/             # Tema yapılandırması
│   │   ├── utils/             # Yardımcı fonksiyonlar
│   │   └── routes/            # Routing yapılandırması
│   ├── features/              # Özellik modülleri
│   │   ├── auth/              # Kimlik doğrulama
│   │   ├── payment/           # Ödeme işlemleri
│   │   ├── dashboard/         # Ana panel
│   │   └── wallet/            # Cüzdan yönetimi
│   ├── data/                  # Veri katmanı
│   │   ├── models/            # Veri modelleri
│   │   ├── repositories/      # Repository pattern
│   │   └── providers/         # Riverpod providers
│   ├── presentation/          # UI katmanı
│   │   ├── widgets/           # Tekrar kullanılabilir widget'lar
│   │   └── screens/           # Ekranlar
│   └── main.dart              # Uygulama giriş noktası
├── test/                       # Test dosyaları
├── assets/                     # Statik dosyalar
│   ├── images/                # Görseller
│   └── fonts/                 # Fontlar
└── pubspec.yaml               # Flutter bağımlılıkları

```

## Kurulum

### Gereksinimler

- Flutter SDK (3.0 veya üzeri)
- Android Studio / VS Code
- Android SDK (API Level 24+)
- Git

### Adımlar

1. **Projeyi klonlayın**
```bash
git clone https://github.com/papel/papeltaksiapp.git
cd papeltaksiapp
```

2. **Bağımlılıkları yükleyin**
```bash
flutter pub get
```

3. **Code generation çalıştırın**
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. **Uygulamayı çalıştırın**
```bash
# Debug modda
flutter run

# Release modda
flutter run --release
```

## APK Build

### Debug APK
```bash
flutter build apk --debug
```

### Release APK (İmzalı)
```bash
flutter build apk --release
```

APK dosyası şu konumda oluşturulur:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Farklı Environment'lar için Build

```bash
# Development
flutter build apk --flavor dev --debug

# Staging
flutter build apk --flavor staging --release

# Production
flutter build apk --flavor prod --release
```

## Renk Paleti

Uygulama aşağıdaki renk paletini kullanır:

| Renk Adı | Hex Kodu | Kullanım |
|----------|----------|----------|
| Primary | #373B49 | Ana renk, AppBar, önemli butonlar |
| Primary Dark | #1E2129 | Gradyan, koyu tonlar |
| Secondary | #8A93B4 | İkincil elemanlar |
| Accent | #4D38E7 | CTA butonları, vurgular |
| Text Primary | #1E2129 | Ana metinler |
| Text Secondary | #8A93B4 | Yardımcı metinler |
| Disabled Text | #9296A5 | Devre dışı metinler |
| Disabled Button | #F3F4F6 | Devre dışı butonlar |
| Ripple | #E94435 | Tıklama efektleri |

## Geliştirme Fazları

### ✅ Faz 0: Proje Altyapısı (Tamamlandı)
- Flutter projesi kurulumu
- Renk paleti ve tema sistemi
- Temel UI ekranları (Splash, Login, Dashboard, Payment)
- Android konfigürasyonu

### 🚧 Faz 1: SoftPOS Entegrasyonu (Devam Ediyor)
- [ ] Payneos API entegrasyonu
- [ ] Deeplink yönetimi
- [ ] Payment session token yönetimi
- [ ] Webhook listener implementasyonu
- [ ] Callback handling

### 📋 Faz 2: Dijital Cüzdan
- [ ] Papel Wallet API entegrasyonu
- [ ] KYC süreç ekranları
- [ ] Bakiye görüntüleme
- [ ] Hakediş yönetimi
- [ ] İşlem geçmişi

### 📋 Faz 3: Fraud ve Backoffice
- [ ] FORMICA fraud kontrol entegrasyonu
- [ ] Backoffice web paneli
- [ ] İşlem izleme
- [ ] Komisyon yönetimi
- [ ] Raporlama

### 📋 Faz 4: Fiziksel POS
- [ ] PAVO POS entegrasyonu
- [ ] Cihaz yönetimi
- [ ] Mesai başlangıç/bitiş
- [ ] Offline mode desteği

## API Entegrasyonları

### Payneos SoftPOS
- **Onboarding**: Sürücü kaydı ve cihaz eşleştirme
- **Payment**: Ödeme session oluşturma ve işlem yönetimi
- **Webhook**: İşlem sonuç bildirimleri

### Papel Wallet
- **KYC**: Kimlik doğrulama
- **Balance**: Bakiye sorgulama
- **Transfer**: Hakediş transferleri
- **IBAN**: IBAN bazlı ödemeler

### FORMICA Fraud
- **Risk Score**: İşlem risk değerlendirme
- **Blacklist**: Kara liste kontrolü
- **Alert**: Şüpheli işlem bildirimleri

## Deeplink Yapılandırması

Uygulama şu deeplink şemalarını destekler:

### App-to-App (SoftPOS Callback)
```
papeltaksi://payment?transactionId=xxx&status=success
```

### Web Deeplink
```
https://papeltaksi.com/payment?transactionId=xxx&status=success
```

## Güvenlik

- ✅ Şifrelenmiş local storage (flutter_secure_storage)
- ✅ SSL Pinning (planlı)
- ✅ Token bazlı authentication
- ✅ API request encryption
- ✅ Proguard ile kod gizleme

## Test

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter test integration_test/
```

## Dağıtım

### Google Play Store

1. Signing key oluşturun
2. `android/key.properties` dosyasını düzenleyin
3. Release APK build edin
4. Play Console'a yükleyin

### Internal Distribution

APK dosyasını direkt olarak paylaşabilirsiniz:
```bash
flutter build apk --release
adb install build/app/outputs/flutter-apk/app-release.apk
```

## Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit edin (`git commit -m 'feat: Add amazing feature'`)
4. Push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## Lisans

Bu proje Papel E-Para A.Ş. mülkiyetindedir. Tüm hakları saklıdır.

## İletişim

- **Proje Yöneticisi**: Papel E-Para A.Ş.
- **E-posta**: info@papel.com.tr
- **Website**: https://www.papel.com.tr

## Versiyon Geçmişi

### v1.0.0 (2025-10-23)
- ✅ İlk sürüm
- ✅ Temel UI/UX
- ✅ Login/Dashboard ekranları
- ✅ Ödeme tutar girişi
- ✅ Android yapılandırması

---

**Papel Taksi** ile modern, güvenli ve hızlı ödeme deneyimi! 🚕💳
