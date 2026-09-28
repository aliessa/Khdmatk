import SwiftUI

struct QuickActionItem: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let iconName: String
    let color: Color
    let url: URL
    
    static let allActions: [QuickActionItem] = [
        QuickActionItem(
            title: "ابعت ليستة",
            subtitle: "اكتب طلباتك ومقاضيك ونوصلها فوراً",
            iconName: "square.and.pencil",
            color: .green,
            url: AppConstants.quickListURL
        ),
        QuickActionItem(
            title: "سلة على قد ميزانيتك",
            subtitle: "حدد المبلغ والتطبيق يختار لك الأنسب",
            iconName: "chart.pie.fill",
            color: .teal,
            url: AppConstants.budgetBasketURL
        ),
        QuickActionItem(
            title: "هنطبخ إيه النهارده؟",
            subtitle: "أفكار وجبات ومكوناتها بضغطة واحدة",
            iconName: "fork.knife",
            color: .orange,
            url: AppConstants.mealPlannerURL
        ),
        QuickActionItem(
            title: "احجزه وأنا جاي",
            subtitle: "احجز طلبك واستلمه بنفسك من المتجر",
            iconName: "clock.arrow.circlepath",
            color: .indigo,
            url: AppConstants.pickupReserveURL
        ),
        QuickActionItem(
            title: "أخبار منطقتك وحيك",
            subtitle: "عروض وإعلانات جيرانك في المنطقة",
            iconName: "newspaper.fill",
            color: .blue,
            url: AppConstants.communityURL
        ),
        QuickActionItem(
            title: "سلة البيت المشتركة",
            subtitle: "قائمة تسوق عائلية مشتركة لحظية",
            iconName: "person.2.fill",
            color: .purple,
            url: AppConstants.sharedListsURL
        ),
        QuickActionItem(
            title: "تسجيل الدخول",
            subtitle: "حسابك الشخصي ومتابعة نشاطك",
            iconName: "person.crop.circle.fill",
            color: .mint,
            url: AppConstants.customerLoginURL
        )
    ]
}
