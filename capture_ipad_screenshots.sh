#!/bin/bash

# iPad Screenshots Capture Script
# This script helps capture proper iPad screenshots for App Store submission

echo "🖼️  iPad Screenshots Capture Script"
echo "=================================="
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Check if Simulator is available
if ! command -v xcrun &> /dev/null; then
    echo "❌ Xcode command line tools not found"
    exit 1
fi

echo "📱 Available iPad Simulators:"
echo "-----------------------------"
xcrun simctl list devices | grep "iPad" | grep -v "unavailable"
echo ""

# Function to capture screenshot
capture_screenshot() {
    local device_name="$1"
    local screenshot_name="$2"
    local description="$3"
    
    echo "📸 Capturing: $description"
    echo "   Device: $device_name"
    echo "   File: $screenshot_name"
    
    # Take screenshot
    xcrun simctl io "$device_name" screenshot "$screenshot_name"
    
    if [ $? -eq 0 ]; then
        echo "   ✅ Screenshot saved: $screenshot_name"
    else
        echo "   ❌ Failed to capture screenshot"
    fi
    echo ""
}

# Function to run app on simulator
run_app_on_simulator() {
    local device_name="$1"
    
    echo "🚀 Starting app on $device_name..."
    flutter run -d "$device_name" --release &
    
    # Wait for app to start
    echo "⏳ Waiting for app to start..."
    sleep 10
    
    echo "✅ App should be running on $device_name"
    echo "   Please navigate to the desired screen manually"
    echo "   Press Enter when ready to capture screenshots..."
    read -r
}

# Main execution
echo "🎯 iPad Screenshot Capture Process"
echo "=================================="
echo ""

# List available iPad simulators
echo "Available iPad Simulators:"
xcrun simctl list devices | grep "iPad" | grep -v "unavailable" | head -5
echo ""

# Get user choice
echo "Please select iPad simulator:"
echo "1) iPad Pro (12.9-inch) (6th generation)"
echo "2) iPad Pro (11-inch) (4th generation)"
echo "3) iPad Air (5th generation)"
echo "4) iPad (10th generation)"
echo "5) Custom device name"
echo ""

read -p "Enter choice (1-5): " choice

case $choice in
    1)
        DEVICE_NAME="iPad Pro (12.9-inch) (6th generation)"
        SCREENSHOT_PREFIX="ipad_pro_12_9"
        ;;
    2)
        DEVICE_NAME="iPad Pro (11-inch) (4th generation)"
        SCREENSHOT_PREFIX="ipad_pro_11"
        ;;
    3)
        DEVICE_NAME="iPad Air (5th generation)"
        SCREENSHOT_PREFIX="ipad_air_5th"
        ;;
    4)
        DEVICE_NAME="iPad (10th generation)"
        SCREENSHOT_PREFIX="ipad_10th"
        ;;
    5)
        read -p "Enter custom device name: " DEVICE_NAME
        SCREENSHOT_PREFIX="ipad_custom"
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

echo ""
echo "📱 Selected Device: $DEVICE_NAME"
echo "📁 Screenshot Prefix: $SCREENSHOT_PREFIX"
echo ""

# Check if device exists
if ! xcrun simctl list devices | grep -q "$DEVICE_NAME"; then
    echo "❌ Device '$DEVICE_NAME' not found"
    echo "Available devices:"
    xcrun simctl list devices | grep "iPad" | grep -v "unavailable"
    exit 1
fi

# Boot simulator if not running
echo "🔄 Booting simulator..."
xcrun simctl boot "$DEVICE_NAME" 2>/dev/null || echo "Simulator already running"

# Open Simulator app
open -a Simulator

echo ""
echo "📋 Screenshot Capture Checklist"
echo "================================"
echo ""

# Run app on simulator
run_app_on_simulator "$DEVICE_NAME"

# Create screenshots directory
mkdir -p "ipad_screenshots_$(date +%Y%m%d)"
cd "ipad_screenshots_$(date +%Y%m%d)"

echo "📸 Ready to capture screenshots!"
echo "   Screenshots will be saved in: $(pwd)"
echo ""

# Screenshot capture sequence
echo "🎯 Screenshot Capture Sequence"
echo "=============================="
echo ""

# 1. Home Screen
echo "1️⃣  Home Screen Screenshot"
echo "   Navigate to: Main analysis interface"
echo "   Should show: Image picker, medical disclaimer, clean layout"
read -p "   Press Enter when ready..."
capture_screenshot "$DEVICE_NAME" "${SCREENSHOT_PREFIX}_home_screen.png" "Home Screen"

# 2. Analysis Results
echo "2️⃣  Analysis Results Screenshot"
echo "   Navigate to: After analyzing an image"
echo "   Should show: AI results, pattern analysis, disclaimers"
read -p "   Press Enter when ready..."
capture_screenshot "$DEVICE_NAME" "${SCREENSHOT_PREFIX}_analysis_results.png" "Analysis Results"

# 3. BreastLens Guide
echo "3️⃣  BreastLens Guide Screenshot"
echo "   Navigate to: Guide screen"
echo "   Should show: Educational steps, visual instructions"
read -p "   Press Enter when ready..."
capture_screenshot "$DEVICE_NAME" "${SCREENSHOT_PREFIX}_guide_screen.png" "BreastLens Guide"

# 4. Education Screen
echo "4️⃣  Education Screen Screenshot"
echo "   Navigate to: Breast cancer education"
echo "   Should show: Risk factors, symptoms, citations"
read -p "   Press Enter when ready..."
capture_screenshot "$DEVICE_NAME" "${SCREENSHOT_PREFIX}_education_screen.png" "Education Screen"

# 5. History Screen
echo "5️⃣  History Screen Screenshot"
echo "   Navigate to: Analysis history"
echo "   Should show: Past results, clean data presentation"
read -p "   Press Enter when ready..."
capture_screenshot "$DEVICE_NAME" "${SCREENSHOT_PREFIX}_history_screen.png" "History Screen"

# Optional: Dark Mode
echo "6️⃣  Dark Mode Screenshot (Optional)"
echo "   Navigate to: Any screen in dark mode"
echo "   Should show: Dark theme appearance"
read -p "   Press Enter to capture dark mode (or 'skip' to skip)..."
if [[ $REPLY != "skip" ]]; then
    capture_screenshot "$DEVICE_NAME" "${SCREENSHOT_PREFIX}_dark_mode.png" "Dark Mode"
fi

echo ""
echo "✅ Screenshot Capture Complete!"
echo "==============================="
echo ""

# List captured screenshots
echo "📁 Captured Screenshots:"
ls -la *.png 2>/dev/null || echo "No screenshots found"

echo ""
echo "📋 Next Steps:"
echo "=============="
echo "1. Review screenshots for quality and content"
echo "2. Ensure iPad device frames are visible (not iPhone frames)"
echo "3. Verify all UI elements are properly displayed"
echo "4. Upload to App Store Connect Media Manager"
echo "5. Select 'View All Sizes in Media Manager' for iPad screenshots"
echo ""

echo "🔍 Quality Checklist:"
echo "====================="
echo "✅ Screenshots show iPad device frame (not iPhone)"
echo "✅ Content is properly sized for iPad screen"
echo "✅ All UI elements are visible and readable"
echo "✅ Screenshots match actual app appearance"
echo "✅ Core features are prominently displayed"
echo "✅ Medical disclaimers are visible"
echo "✅ Professional, clean presentation"
echo ""

echo "📱 App Store Connect Upload:"
echo "==========================="
echo "1. Go to App Store Connect"
echo "2. Select your app (BreastLens)"
echo "3. Go to App Store tab > iOS App"
echo "4. Scroll to 'App Previews and Screenshots'"
echo "5. Click 'View All Sizes in Media Manager'"
echo "6. Select appropriate iPad size"
echo "7. Upload screenshots with proper iPad frames"
echo ""

echo "🎉 Done! Screenshots are ready for App Store submission."
echo "   Location: $(pwd)"
echo ""

# Open screenshots folder
open .

echo "📖 For detailed instructions, see: IPAD_SCREENSHOTS_FIX_GUIDE.md"
