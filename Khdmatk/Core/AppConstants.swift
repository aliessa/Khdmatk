import SwiftUI

enum AppConstants {
    // MARK: - URLs
    static let baseDomain = "khdmatk.store"
    static let baseURL = URL(string: "https://khdmatk.store/")!
    
    // Customer URLs
    static let customerHomeURL = URL(string: "https://khdmatk.store/Default.aspx")!
    static let customerCartURL = URL(string: "https://khdmatk.store/Cart.aspx")!
    static let customerOrdersURL = URL(string: "https://khdmatk.store/Orders.aspx")!
    static let customerFavoritesURL = URL(string: "https://khdmatk.store/Favorites.aspx")!
    static let customerServicesURL = URL(string: "https://khdmatk.store/ServiceRequest.aspx")!
    static let customerLoginURL = URL(string: "https://khdmatk.store/UserLogin.aspx")!
    
    // Dedicated Role Portals
    static let merchantLoginURL = URL(string: "https://khdmatk.store/Merchant/Login.aspx")!
    static let driverLoginURL = URL(string: "https://khdmatk.store/Driver/Login.aspx")!
    static let providerLoginURL = URL(string: "https://khdmatk.store/Provider/Login.aspx")!
    
    // Specialized Smart Features
    static let quickListURL = URL(string: "https://khdmatk.store/QuickList.aspx")!
    static let budgetBasketURL = URL(string: "https://khdmatk.store/BudgetBasket.aspx")!
    static let mealPlannerURL = URL(string: "https://khdmatk.store/MealPlanner.aspx")!
    static let pickupReserveURL = URL(string: "https://khdmatk.store/PickupReserve.aspx")!
    static let communityURL = URL(string: "https://khdmatk.store/Community.aspx")!
    static let neighborhoodURL = URL(string: "https://khdmatk.store/Neighborhood.aspx")!
    static let sharedListsURL = URL(string: "https://khdmatk.store/SharedLists.aspx")!
    static let featuresURL = URL(string: "https://khdmatk.store/Features.aspx")!
    
    // Support & Info
    static let privacyPolicyURL = URL(string: "https://khdmatk.store/PrivacyPolicy.aspx") ?? baseURL
    static let termsURL = URL(string: "https://khdmatk.store/Terms.aspx") ?? baseURL
    static let supportWhatsAppNumber = "201000000000" // Can be updated to store's official WhatsApp
    
    // User Agent enhancement
    static let userAgentSuffix = "Khdmatk-iOS-Native-App/1.0.0 (Apple; iOS)"
    
    // MARK: - Theme Colors
    static let primaryColor = Color(red: 0.0, green: 0.529, blue: 0.353) // #00875a
    static let secondaryColor = Color(red: 0.0, green: 0.769, blue: 0.494) // #00c47e
    static let goldAccent = Color(red: 1.0, green: 0.831, blue: 0.475) // #ffd479
    static let darkBackground = Color(red: 0.051, green: 0.090, blue: 0.071) // #0d1712
}
