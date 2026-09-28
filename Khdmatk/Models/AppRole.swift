import SwiftUI

enum AppRole: String, CaseIterable, Identifiable {
    case customer
    case merchant
    case driver
    case provider
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .customer: return "العميل"
        case .merchant: return "التاجر"
        case .driver: return "المندوب"
        case .provider: return "الفني"
        }
    }
    
    var fullTitle: String {
        switch self {
        case .customer: return "🛍️ تسوّق العميل"
        case .merchant: return "🏪 بوابة التاجر"
        case .driver: return "🛵 مندوب التوصيل"
        case .provider: return "🔧 فني الصيانة"
        }
    }
    
    var subtitle: String {
        switch self {
        case .customer: return "تصفح المتاجر واطلب الخدمات"
        case .merchant: return "إدارة المنتجات والعروض والطلبات"
        case .driver: return "استقبال وتوصيل طلبات العملاء"
        case .provider: return "إدارة حجوزات وبلاغات الصيانة"
        }
    }
    
    var systemIcon: String {
        switch self {
        case .customer: return "cart.fill"
        case .merchant: return "building.2.crop.circle.fill"
        case .driver: return "figure.walk.motion"
        case .provider: return "wrench.and.screwdriver.fill"
        }
    }
    
    var targetURL: URL {
        switch self {
        case .customer: return AppConstants.customerHomeURL
        case .merchant: return AppConstants.merchantLoginURL
        case .driver: return AppConstants.driverLoginURL
        case .provider: return AppConstants.providerLoginURL
        }
    }
    
    var badgeColor: Color {
        switch self {
        case .customer: return AppConstants.primaryColor
        case .merchant: return Color.blue
        case .driver: return Color.orange
        case .provider: return Color.purple
        }
    }
}
