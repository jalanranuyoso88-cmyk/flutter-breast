# App Store Connect - iPad Screenshots Upload Instructions

## Quick Fix for Guideline 2.3.3

### Issue
- 13-inch iPad screenshots show iPhone device frame
- Need proper iPad screenshots with correct device frames

### Solution
Upload new iPad screenshots that show proper iPad device frames instead of iPhone frames.

## Step-by-Step Upload Process

### 1. Access App Store Connect
1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Sign in with your Apple Developer account
3. Select **BreastLens** app
4. Go to **App Store** tab
5. Select **iOS App** section

### 2. Navigate to Screenshots
1. Scroll down to **App Previews and Screenshots**
2. Click **"View All Sizes in Media Manager"**
3. This opens the Media Manager with all device sizes

### 3. Select iPad Size
In Media Manager, select one of these iPad sizes:
- **iPad Pro (12.9-inch)** - for 13-inch iPad screenshots
- **iPad Pro (11-inch)** - for 11-inch iPad screenshots
- **iPad Air** - for iPad Air screenshots
- **iPad** - for standard iPad screenshots

### 4. Upload New Screenshots
1. **Delete existing screenshots** that show iPhone frames
2. **Upload new screenshots** with proper iPad frames
3. **Minimum:** 3 screenshots per device size
4. **Maximum:** 10 screenshots per device size
5. **Recommended:** 5-7 screenshots showing core features

### 5. Screenshot Requirements

#### Required Screenshots (in order of importance):
1. **Home Screen** - Main analysis interface
2. **Analysis Results** - AI pattern analysis display  
3. **BreastLens Guide** - Educational content and steps
4. **Breast Cancer Education** - Medical information with citations
5. **History Screen** - Analysis history and tracking

#### Technical Specifications:
- **iPad Pro (12.9-inch):** 2048 x 2732 pixels
- **iPad Pro (11-inch):** 1668 x 2388 pixels
- **Format:** PNG (preferred) or JPEG
- **File Size:** Under 5MB per screenshot
- **Quality:** High resolution, clear text

### 6. Quality Checklist

#### Before Upload:
- [ ] Screenshots show **iPad device frame** (not iPhone)
- [ ] Content is properly sized for iPad screen
- [ ] All UI elements are visible and readable
- [ ] Screenshots match actual app appearance
- [ ] Core features are prominently displayed
- [ ] Medical disclaimers are visible
- [ ] Professional, clean presentation

#### After Upload:
- [ ] Screenshots appear correctly in Media Manager
- [ ] Preview shows proper iPad frames
- [ ] All screenshots are visible
- [ ] Order is logical (most important first)

## How to Create Proper iPad Screenshots

### Method 1: Using iPad Simulator
1. **Open Simulator:** `open -a Simulator`
2. **Select iPad:** Device > iPad Pro (12.9-inch) or iPad Pro (11-inch)
3. **Run App:** `flutter run -d "iPad Pro (12.9-inch)"`
4. **Take Screenshots:** Device > Screenshot
5. **Save with descriptive names**

### Method 2: Using Script
1. **Run script:** `./capture_ipad_screenshots.sh`
2. **Follow prompts** to capture all required screenshots
3. **Review quality** before uploading

### Method 3: Manual Process
1. **Boot iPad simulator**
2. **Navigate to each screen** manually
3. **Take screenshots** using Simulator menu
4. **Verify iPad frames** are visible
5. **Organize files** with proper naming

## Common Mistakes to Avoid

### Technical Mistakes:
- ❌ Using iPhone frames for iPad screenshots
- ❌ Screenshots that don't match actual app
- ❌ Low resolution or blurry images
- ❌ Cut-off UI elements
- ❌ Wrong aspect ratio

### Content Mistakes:
- ❌ Marketing materials instead of actual UI
- ❌ Only splash screens or login screens
- ❌ Outdated app versions
- ❌ Missing core features
- ❌ Poor quality images

## Verification Steps

### 1. Pre-Upload Verification:
- [ ] Screenshots show iPad device frame
- [ ] Content matches actual app
- [ ] High quality and clear
- [ ] All features visible
- [ ] Professional appearance

### 2. Post-Upload Verification:
- [ ] Screenshots appear in Media Manager
- [ ] iPad frames are correct
- [ ] Preview looks professional
- [ ] Ready for submission

## Troubleshooting

### If Screenshots Still Show iPhone Frames:
1. **Check simulator:** Ensure iPad simulator is selected
2. **Verify resolution:** Use correct iPad screen resolution
3. **Re-capture:** Take new screenshots with iPad simulator
4. **Check file:** Verify screenshot shows iPad frame

### If Upload Fails:
1. **File size:** Ensure under 5MB per screenshot
2. **Format:** Use PNG or JPEG format
3. **Resolution:** Use correct iPad resolution
4. **Browser:** Try different browser or clear cache

## Success Criteria

### Technical Success:
- ✅ iPad screenshots show proper iPad device frames
- ✅ All screenshots are high quality and clear
- ✅ Content accurately reflects app functionality
- ✅ Proper aspect ratios and resolutions

### Compliance Success:
- ✅ Meets Guideline 2.3.3 requirements
- ✅ Accurate metadata representation
- ✅ Professional presentation
- ✅ Ready for App Store approval

## Next Steps After Upload

1. **Review:** Check all screenshots in Media Manager
2. **Test:** Verify preview appearance
3. **Submit:** Submit app for App Store review
4. **Monitor:** Track review status
5. **Address:** Handle any additional feedback

---

**This guide ensures compliance with Apple's Guideline 2.3.3 and provides accurate iPad screenshot representation for the BreastLens app.**
