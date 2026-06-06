#!/bin/bash

echo "🚀 Building iOS App for TestFlight..."

if ! command -v xcodebuild &> /dev/null; then
    echo "❌ Xcode is not installed"
    exit 1
fi

echo "✅ Prerequisites met"
echo "Building archive..."

xcodebuild -workspace ios/DentalProGrowth.xcworkspace \
  -scheme DentalProGrowth \
  -configuration Release \
  archive

echo ""
echo "✅ Build successful!"
echo "📱 Open Xcode organizer to upload to TestFlight"
echo "Steps:"
echo "1. Open Xcode"
echo "2. Window → Organizer"
echo "3. Select your archive"
echo "4. Click 'Distribute App'"
echo "5. Select 'TestFlight & App Store'"
echo "6. Follow the upload steps"
