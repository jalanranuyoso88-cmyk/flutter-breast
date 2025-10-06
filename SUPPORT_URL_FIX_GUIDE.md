# Support URL Fix - Guideline 1.5 Compliance

## Issue Description
**Guideline 1.5 - Safety**
- Support URL `http://instagram.com/sadari.app` is invalid
- Instagram URL doesn't meet Apple's requirements for Support URL
- Must direct to functional webpage with support information

## Apple Requirements for Support URL

According to Apple's documentation, Support URL must:
- Lead to actual contact information (legal address, email address, telephone number)
- Allow users to reach you regarding app issues, general feedback, and feature enhancement requests
- Include the entire URL with protocol (http:// or https://)
- Be a functional webpage with support information

## Solution Options

### Option 1: Create Simple Support Website (Recommended)

#### Create a basic HTML support page:
```html
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BreastLens - Support</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
        .header { text-align: center; margin-bottom: 30px; }
        .contact-info { background: #f5f5f5; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .disclaimer { background: #fff3cd; padding: 15px; border-radius: 8px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="header">
        <h1>BreastLens - Support</h1>
        <p>Aplikasi Skrining Awal & Edukasi Kanker Payudara</p>
    </div>

    <div class="contact-info">
        <h2>Informasi Kontak</h2>
        <p><strong>Developer:</strong> KangJaga</p>
        <p><strong>Email:</strong> jalanranuyoso88@gmail.com</p>
        <p><strong>Alamat:</strong> Indonesia</p>
        <p><strong>Versi Aplikasi:</strong> 4.0.8</p>
    </div>

    <div class="contact-info">
        <h2>Cara Menghubungi Kami</h2>
        <p>Untuk pertanyaan, masukan, atau dukungan teknis, silakan hubungi kami melalui:</p>
        <ul>
            <li><strong>Email:</strong> jalanranuyoso88@gmail.com</li>
            <li><strong>Subjek Email:</strong> [BreastLens Support] - [Topik Pertanyaan]</li>
        </ul>
        <p>Kami akan merespons dalam 24-48 jam.</p>
    </div>

    <div class="contact-info">
        <h2>Jenis Dukungan yang Tersedia</h2>
        <ul>
            <li>Pertanyaan teknis tentang aplikasi</li>
            <li>Masalah dengan fitur aplikasi</li>
            <li>Saran dan masukan untuk pengembangan</li>
            <li>Laporan bug atau error</li>
            <li>Pertanyaan tentang privasi dan keamanan data</li>
        </ul>
    </div>

    <div class="disclaimer">
        <h3>⚠️ Peringatan Medis</h3>
        <p>BreastLens adalah aplikasi edukasi dan skrining awal. Aplikasi ini BUKAN pengganti konsultasi medis profesional. Untuk pertanyaan medis, silakan konsultasikan dengan dokter.</p>
    </div>

    <div class="contact-info">
        <h2>Informasi Aplikasi</h2>
        <p><strong>Nama:</strong> BreastLens</p>
        <p><strong>Kategori:</strong> Medical / Health & Fitness</p>
        <p><strong>Platform:</strong> iOS</p>
        <p><strong>Versi Minimum:</strong> iOS 13.0</p>
        <p><strong>Bundle ID:</strong> com.breastlens.detection</p>
    </div>

    <footer style="text-align: center; margin-top: 40px; color: #666;">
        <p>&copy; 2025 KangJaga. All rights reserved.</p>
        <p>BreastLens - Melindungi Kesehatan Payudara Anda dengan Teknologi AI Terdepan</p>
    </footer>
</body>
</html>
```

### Option 2: Use GitHub Pages (Free)

#### Steps to create GitHub Pages support site:
1. Create GitHub repository: `breastlens-support`
2. Create `index.html` with support information
3. Enable GitHub Pages
4. Use URL: `https://[username].github.io/breastlens-support`

### Option 3: Use Free Web Hosting

#### Recommended free hosting services:
- **GitHub Pages** (Free, reliable)
- **Netlify** (Free tier available)
- **Vercel** (Free tier available)
- **Firebase Hosting** (Free tier available)

## Recommended Support URL

### Best Option: GitHub Pages
```
https://kangjaga.github.io/breastlens-support
```

### Alternative: Simple Domain
```
https://breastlens-support.netlify.app
```

## Implementation Steps

### Step 1: Create Support Website
1. Choose hosting option (GitHub Pages recommended)
2. Create HTML support page with contact information
3. Include all required contact details
4. Test website functionality

### Step 2: Update App Store Connect
1. Go to App Store Connect
2. Select BreastLens app
3. Go to App Information
4. Update Support URL to new functional website
5. Save changes

### Step 3: Verify Compliance
- [ ] Support URL leads to functional website
- [ ] Website contains contact information
- [ ] Users can reach developer for support
- [ ] Website is accessible and professional
- [ ] Contact information is accurate

## Contact Information to Include

### Required Information:
- **Developer Name:** KangJaga
- **Email Address:** jalanranuyoso88@gmail.com
- **Legal Address:** Indonesia (or specific address)
- **Phone Number:** (Optional but recommended)

### Additional Information:
- **App Version:** 4.0.8
- **Support Hours:** Response time expectations
- **Types of Support:** What kind of help is available
- **Medical Disclaimer:** Important medical warnings

## Compliance Checklist

### Before Updating:
- [ ] Support website is created and functional
- [ ] Contact information is accurate and accessible
- [ ] Website loads properly on mobile and desktop
- [ ] All required information is included
- [ ] Professional appearance and presentation

### After Updating:
- [ ] Support URL works in App Store Connect
- [ ] Website is accessible to users
- [ ] Contact information is clearly visible
- [ ] Support process is clear and user-friendly
- [ ] Ready for App Store submission

## Next Steps

1. **Immediate:** Create support website using one of the options above
2. **Short-term:** Update Support URL in App Store Connect
3. **Medium-term:** Test support process and user accessibility
4. **Long-term:** Maintain support website and respond to user inquiries

---

**This guide ensures full compliance with Apple's Guideline 1.5 and provides a functional Support URL for the BreastLens app.**
