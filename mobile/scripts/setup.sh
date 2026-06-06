#!/bin/bash

echo "🍎 Dental Pro Growth - iOS Setup"
echo "================================"

if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found"
    exit 1
fi

echo "✅ Node.js found"

if ! command -v pod &> /dev/null; then
    echo "📥 Installing CocoaPods..."
    sudo gem install cocoapods
fi

echo "✅ CocoaPods ready"

cd "$(dirname "$0")/.."

echo "📥 Installing dependencies..."
npm install

echo "📥 Installing iOS pods..."
npm run pod-install

echo ""
echo "✅ Setup complete!"
echo ""
echo "🚀 To start:"
echo "   npm start"
echo "   npm run ios"
