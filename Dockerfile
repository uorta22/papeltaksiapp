FROM cirrusci/flutter:3.24.0

WORKDIR /app

# Copy project files
COPY . .

# Get dependencies
RUN flutter pub get

# Build APK
RUN flutter build apk --release --flavor prod

# The APK will be available at:
# /app/build/app/outputs/flutter-apk/app-prod-release.apk
