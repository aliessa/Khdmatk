# تطبيق خدماتك لنظام iOS (Khdmatk iOS Super App) 📱

تطبيق أصلي متطور بنظام **Swift & SwiftUI** لمنصة **خدماتك (khdmatk.store)** بنظام **Super App** متكامل يخدم (العميل، التاجر، مندوب التوصيل، وفني الصيانة) مع واجهة هجينة فائقة السرعة ومتوافقة مع أعلى معايير متجر آبل **App Store**.

---

## 🌟 مميزات التطبيق (Features)

### 1. تطبيق شامل متعدد الأدوار (All-in-One Super App)
- **🛍️ بوابة العميل (Customer):** تصفح المتاجر، الأقسام، السلة، الطلبات، والمفضلة مع شريط تنقل سفلي أصلي (Native Tab Bar).
- **🏪 بوابة التاجر (Merchant):** إدارة المتجر والمنتجات والطلبات والعروض عبر شريط الأدوار العلوي.
- **🛵 بوابة المندوب (Driver):** استقبال وتوصيل طلبات العملاء وتتبع المسارات.
- **🔧 بوابة الفني (Provider):** استقبال طلبات الصيانة والإصلاح المنزلي وضبط المواعيد.

### 2. محرك هجين ذكي وسلس (Native Hybrid Engine)
- مبني باستخدام **WKWebView** مخصص ومربوط بـ **SwiftUI**.
- دعم السحب للتحديث الأصلي (**Pull-to-Refresh**) عبر `UIRefreshControl`.
- شريط تقدم التحميل اللحظي بلون المنصة المعتمد (`#00875a`).
- دعم أزرار الرجوع والتقدم الأصلية وتاريخ التصفح.
- حفظ الجلسات والكوكيز بشكل دائم (`WKWebsiteDataStore.default()`).

### 3. الجسر البرمجي الذكي (JavaScript / Swift Bridge)
- قراءة وتحديث عداد السلة (`Cart Count`) تلقائياً وإظهاره على أيقونة السلة في شريط التطبيق.
- حقن أنماط CSS محسنة لشاشات الآيفون لمنع التكبير المفاجئ في حقول الإدخال، ودعم الجزيرة التفاعلية (**Dynamic Island**)، وسلاسة التمرير اللمسي.
- معالجة الروابط الخارجية تلقائياً (واتساب `wa.me`، الاتصال `tel:`, البريد `mailto:`, وخرائط جوجل وآبل).

### 4. وضع عدم الاتصال (Offline Detection & Resilience)
- مراقبة حالة الشبكة والإنترنت لحظياً عبر `NWPathMonitor`.
- ظهور شريط تنبيه أنيق عند انقطاع الإنترنت مع زر فوري لإعادة المحاولة.

### 5. جاهزية تامة لاعتماد متجر آبل (App Store Ready)
- نصوص أذونات واضحة باللغة العربية في ملف [Info.plist](file:///d:/EX/Khdmatk/Khdmatk/Resources/Info.plist) للكاميرا، الصور، الموقع، والميكروفون.
- تصميم أيقونات احترافي بالأبعاد القياسية `1024x1024`.
- شاشة افتتاحية متوافقة (**LaunchScreen Storyboard**) بلون المنصة وشعارها لمنع أي وميض أبيض أثناء فتح التطبيق.

---

## 📁 هيكل المشروع (Project Structure)

```text
Khdmatk/
├── Khdmatk.xcodeproj/              # ملف مشروع Xcode الجاهز للفتح المباشر
│   └── project.pbxproj
├── project.yml                     # ملف تكوين XcodeGen
├── Khdmatk/
│   ├── App/
│   │   ├── KhdmatkApp.swift        # نقطة دخول التطبيق الرئيسية (SwiftUI App)
│   │   └── AppDelegate.swift       # تهيئة الإشعارات والمظهر العام
│   ├── Core/
│   │   ├── AppConstants.swift      # روابط المنصة، الألوان، وثوابت التطبيق
│   │   ├── HapticManager.swift     # الاهتزازات التفاعلية (Haptics)
│   │   ├── LocationManager.swift   # إدارة أذونات وموقع الـ GPS
│   │   └── NetworkMonitor.swift    # مراقبة الاتصال بالإنترنت
│   ├── Models/
│   │   ├── AppRole.swift           # تعريف أدوار المنصة (عميل، تاجر، مندوب، فني)
│   │   ├── NavigationTab.swift     # تبويبات شريط العميل السفلي
│   │   └── QuickActionItem.swift   # مميزات المنصة السريعة
│   ├── ViewModels/
│   │   └── WebViewModel.swift      # إدارة الحالة والتنقل والتحميل
│   ├── Views/
│   │   ├── MainView.swift          # الشاشة الرئيسية الجامعة للمكونات
│   │   ├── WebViewContainer.swift  # حاوية الويب الأصلية WKWebView
│   │   ├── NativeNavBar.swift      # شريط العنوان والأدوات العلوي
│   │   ├── RoleSelectorBar.swift   # شريط التبديل بين الأدوار
│   │   ├── NativeTabBar.swift      # شريط التبويبات السفلي
│   │   ├── LoadingProgressBar.swift# شريط تقدم التحميل
│   │   ├── OfflineBannerView.swift # إشعار انقطاع الاتصال
│   │   ├── QuickActionsSheet.swift # نافذة الخدمات السريعة الذكية
│   │   └── SettingsSheet.swift     # نافذة الإعدادات ومسح الذاكرة
│   ├── Bridge/
│   │   ├── InjectedScripts.swift   # أكواد CSS و JS المحقونة
│   │   └── WebScriptBridge.swift   # مستقبل رسائل الويب في Swift
│   └── Resources/
│       ├── Info.plist              # إعدادات وأذونات آبل
│       ├── LaunchScreen.storyboard # شاشة البداية
│       ├── Khdmatk.entitlements    # صلاحيات الإشعارات
│       └── Assets.xcassets/        # الأيقونات والألوان والشعارات
```

---

## 🚀 طريقة التشغيل والبناء في Xcode (How to Run)

### المتطلبات:
- جهاز كمبيوتر ماك (**macOS**).
- برنامج **Xcode 14 أو 15 أو 16+**.
- حساب مطور آبل (**Apple Developer Account**) عند الرغبة في التوزيع على TestFlight أو App Store.

### خطوات التشغيل:
1. انسخ مجلد المشروع `Khdmatk` إلى جهاز الماك الخاص بك.
2. انقر نقراً مزدوجاً على الملف:
   ```bash
   Khdmatk.xcodeproj
   ```
3. في Xcode، اضغط على المشروع في الشريط الجانبي (**Project Navigator**).
4. اذهب إلى تبويب **Signing & Capabilities**:
   - فعّل خيار **Automatically manage signing**.
   - اختر حساب المطور الخاص بك في خانة **Team**.
   - يمكنك تعديل الـ **Bundle Identifier** إذا رغبت (افتراضياً: `store.khdmatk.app`).
5. اختر جهاز محاكي الآيفون المطلوب (مثل: **iPhone 16 Pro** أو **iPhone 15**).
6. اضغط على زر **تشغيل (Run ▶)** أو اختصار `Cmd + R`.

---

## 🛠️ تخصيص وتعديل الروابط والألوان (Customization)

يمكنك بكل سهولة تعديل أي إعداد أو رابط أو رقم واتساب من ملف:
[AppConstants.swift](file:///d:/EX/Khdmatk/Khdmatk/Core/AppConstants.swift):

```swift
// تعديل رقم واتساب الدعم الفني
static let supportWhatsAppNumber = "201XXXXXXXXX"

// تعديل ألوان الهوية
static let primaryColor = Color(red: 0.0, green: 0.529, blue: 0.353) // #00875a
```

---

## 📦 التصدير والنشر في متجر آبل (App Store Publishing)

1. من القائمة العلوية في Xcode اختر **Product > Destination > Any iOS Device (arm64)**.
2. من القائمة اختر **Product > Archive**.
3. بعد اكتمال البناء، ستفتح نافذة **Organizer**.
4. اضغط على **Distribute App** ثم اختر **App Store Connect** للرفع المباشر إلى TestFlight والمتجر.
