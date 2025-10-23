# Papel Taksi - Geliştirme Kılavuzu

## Başlangıç

Bu doküman, Papel Taksi projesinin geliştirilmesi için gerekli bilgileri içerir.

## Geliştirme Ortamı Kurulumu

### 1. Flutter Kurulumu

```bash
# Flutter SDK'yı indirin ve kurun
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Kurulumu doğrulayın
flutter doctor
```

### 2. Android Gereksinimler

- Android Studio
- Android SDK (API 24+)
- Android Emulator veya fiziksel cihaz

### 3. IDE Kurulumu

#### VS Code
```bash
# Flutter ve Dart eklentilerini yükleyin
code --install-extension Dart-Code.dart-code
code --install-extension Dart-Code.flutter
```

#### Android Studio
- Flutter plugin
- Dart plugin

## Proje Yapısı

### Klasör Organizasyonu

```
lib/
├── core/               # Uygulama çekirdeği
│   ├── constants/      # Sabitler (colors, strings, etc.)
│   ├── theme/          # Tema konfigürasyonu
│   ├── utils/          # Yardımcı fonksiyonlar
│   └── routes/         # Routing
├── features/           # Feature modülleri
│   ├── auth/          # Authentication
│   ├── payment/       # Payment
│   ├── dashboard/     # Dashboard
│   └── wallet/        # Wallet
├── data/              # Data layer
│   ├── models/        # Data models
│   ├── repositories/  # Repositories
│   └── providers/     # Riverpod providers
└── presentation/      # Presentation layer
    ├── widgets/       # Reusable widgets
    └── screens/       # Screens
```

## Kodlama Standartları

### Dart Style Guide

```dart
// ✅ İyi
class PaymentService {
  Future<PaymentResult> processPayment(double amount) async {
    // implementation
  }
}

// ❌ Kötü
class payment_service {
  processPayment(amount) {
    // implementation
  }
}
```

### Naming Conventions

- **Classes**: PascalCase (örn: `PaymentScreen`)
- **Functions**: camelCase (örn: `processPayment`)
- **Constants**: lowerCamelCase (örn: `maxAmount`)
- **Files**: snake_case (örn: `payment_screen.dart`)

### Widget Organization

```dart
class MyWidget extends StatelessWidget {
  // 1. Constructor
  const MyWidget({super.key});

  // 2. Build method
  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  // 3. Private methods
  Widget _buildContent() {
    return Container();
  }
}
```

## State Management

Projede **Riverpod** kullanılmaktadır.

### Provider Örneği

```dart
final paymentProvider = StateNotifierProvider<PaymentNotifier, PaymentState>((ref) {
  return PaymentNotifier();
});

class PaymentNotifier extends StateNotifier<PaymentState> {
  PaymentNotifier() : super(PaymentState.initial());

  Future<void> processPayment(double amount) async {
    state = state.copyWith(isLoading: true);
    try {
      // Payment logic
      state = state.copyWith(isSuccess: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
```

## API Entegrasyonu

### Dio Configuration

```dart
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.papel.com',
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
));

// Add interceptors
dio.interceptors.add(LogInterceptor());
dio.interceptors.add(AuthInterceptor());
```

### Retrofit Service

```dart
@RestApi(baseUrl: "https://api.papel.com")
abstract class PaymentService {
  factory PaymentService(Dio dio) = _PaymentService;

  @POST("/payment/create")
  Future<PaymentResponse> createPayment(@Body() PaymentRequest request);
}
```

## Testing

### Unit Test Örneği

```dart
void main() {
  group('PaymentService Tests', () {
    test('should create payment successfully', () async {
      final service = PaymentService(mockDio);
      final result = await service.createPayment(request);

      expect(result.success, true);
    });
  });
}
```

### Widget Test Örneği

```dart
void main() {
  testWidgets('Payment screen should display amount', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: PaymentScreen(),
    ));

    expect(find.text('₺0,00'), findsOneWidget);
  });
}
```

## Build ve Deploy

### Debug Build

```bash
# APK
flutter build apk --debug

# App Bundle
flutter build appbundle --debug
```

### Release Build

```bash
# APK
flutter build apk --release --flavor prod

# App Bundle
flutter build appbundle --release --flavor prod
```

### Flavor'lar

- **dev**: Geliştirme ortamı
- **staging**: Test ortamı
- **prod**: Production ortamı

```bash
# Development
flutter run --flavor dev -t lib/main_dev.dart

# Staging
flutter run --flavor staging -t lib/main_staging.dart

# Production
flutter run --flavor prod -t lib/main.dart
```

## Git Workflow

### Branch Stratejisi

```
main (production)
  ├── develop (development)
  │   ├── feature/payment-integration
  │   ├── feature/wallet-ui
  │   └── bugfix/login-issue
  └── hotfix/critical-bug
```

### Commit Messages

```bash
# Format
<type>(<scope>): <subject>

# Örnekler
feat(payment): Add SoftPOS integration
fix(auth): Resolve login timeout issue
docs(readme): Update installation guide
refactor(ui): Improve payment screen layout
test(payment): Add unit tests for payment service
```

### Types
- **feat**: Yeni özellik
- **fix**: Bug fix
- **docs**: Dokümantasyon
- **style**: Kod formatı
- **refactor**: Refactoring
- **test**: Test ekleme/güncelleme
- **chore**: Build, dependencies

## Debugging

### VS Code Launch Configuration

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter Dev",
      "request": "launch",
      "type": "dart",
      "args": [
        "--flavor",
        "dev"
      ]
    }
  ]
}
```

### Logging

```dart
import 'package:logger/logger.dart';

final logger = Logger();

logger.d('Debug message');
logger.i('Info message');
logger.w('Warning message');
logger.e('Error message');
```

## Performance

### Best Practices

1. **Lazy Loading**: Widget'ları gerektiğinde yükleyin
2. **Const Constructors**: Mümkün olduğunca const kullanın
3. **ListView.builder**: Uzun listeler için builder kullanın
4. **Image Caching**: Görselleri cache'leyin
5. **Debouncing**: API çağrılarını debounce edin

### Performance Monitoring

```dart
// Timeline events
Timeline.startSync('payment_processing');
// ... payment logic
Timeline.finishSync();
```

## Security

### Sensitive Data

```dart
// ✅ Secure Storage
final storage = FlutterSecureStorage();
await storage.write(key: 'token', value: token);

// ❌ Shared Preferences (for non-sensitive data only)
final prefs = SharedPreferences.getInstance();
await prefs.setString('theme', 'dark');
```

### API Keys

```dart
// .env file (NOT committed to git)
API_KEY=your_api_key_here

// Load in app
import 'package:flutter_dotenv/flutter_dotenv.dart';

await dotenv.load();
final apiKey = dotenv.env['API_KEY'];
```

## Troubleshooting

### Common Issues

#### 1. Gradle Build Errors

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### 2. iOS Build Issues

```bash
cd ios
pod deintegrate
pod install
cd ..
flutter clean
flutter pub get
```

#### 3. Flutter Doctor Issues

```bash
flutter doctor -v
flutter upgrade
```

## Resources

### Dokumentasyon
- [Flutter Docs](https://docs.flutter.dev/)
- [Dart Docs](https://dart.dev/guides)
- [Riverpod Docs](https://riverpod.dev/)

### Useful Packages
- [dio](https://pub.dev/packages/dio) - HTTP client
- [riverpod](https://pub.dev/packages/riverpod) - State management
- [go_router](https://pub.dev/packages/go_router) - Routing
- [freezed](https://pub.dev/packages/freezed) - Code generation
- [hive](https://pub.dev/packages/hive) - Local storage

## Support

Sorularınız için:
- Slack: #papel-taksi-dev
- Email: dev@papel.com.tr
- Wiki: https://wiki.papel.com.tr/taksi-app

---

Happy Coding! 🚀
