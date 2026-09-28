import SwiftUI

enum NavigationTab: String, CaseIterable, Identifiable {
    case home
    case cart
    case orders
    case favorites
    case services
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .home: return "الرئيسية"
        case .cart: return "السلة"
        case .orders: return "طلباتي"
        case .favorites: return "المفضلة"
        case .services: return "خدمات"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .cart: return "cart.fill"
        case .orders: return "bag.fill"
        case .favorites: return "heart.fill"
        case .services: return "wrench.and.screwdriver.fill"
        }
    }
    
    var targetURL: URL {
        switch self {
        case .home: return AppConstants.customerHomeURL
        case .cart: return AppConstants.customerCartURL
        case .orders: return AppConstants.customerOrdersURL
        case .favorites: return AppConstants.customerFavoritesURL
        case .services: return AppConstants.customerServicesURL
        }
    }
}
