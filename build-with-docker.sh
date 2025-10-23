#!/bin/bash

echo "🚀 Building Papel Taksi APK with Docker..."
echo ""

# Build Docker image
echo "📦 Building Docker image..."
docker build -t papeltaksi-builder .

# Create output directory
mkdir -p build-output

# Copy APK from container
echo "📲 Extracting APK..."
docker create --name temp-container papeltaksi-builder
docker cp temp-container:/app/build/app/outputs/flutter-apk/app-prod-release.apk ./build-output/
docker rm temp-container

echo ""
echo "✅ Build completed!"
echo "📱 APK location: ./build-output/app-prod-release.apk"
echo ""
echo "To install on device:"
echo "  adb install ./build-output/app-prod-release.apk"
