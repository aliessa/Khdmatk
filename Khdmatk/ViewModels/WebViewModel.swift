import SwiftUI
import WebKit
import Combine

final class WebViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var selectedRole: AppRole = .customer
    @Published var selectedTab: NavigationTab = .home
    @Published var currentURL: URL = AppConstants.customerHomeURL
    
    @Published var pageTitle: String = "خدماتك"
    @Published var isLoading: Bool = false
    @Published var estimatedProgress: Double = 0.0
    @Published var canGoBack: Bool = false
    @Published var canGoForward: Bool = false
    @Published var cartCount: Int = 0
    
    // UI Modals
    @Published var showQuickActions: Bool = false
    @Published var showSettings: Bool = false
    @Published var showShareSheet: Bool = false
    
    // WKWebView reference for imperative commands
    weak var webView: WKWebView?
    
    // MARK: - Actions
    func load(url: URL) {
        currentURL = url
        var request = URLRequest(url: url)
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 25.0
        webView?.load(request)
    }
    
    func switchRole(to role: AppRole) {
        guard role != selectedRole else { return }
        selectedRole = role
        HapticManager.shared.impact(style: .medium)
        load(url: role.targetURL)
    }
    
    func switchTab(to tab: NavigationTab) {
        selectedTab = tab
        HapticManager.shared.impact(style: .light)
        load(url: tab.targetURL)
    }
    
    func goBack() {
        if webView?.canGoBack == true {
            HapticManager.shared.impact(style: .light)
            webView?.goBack()
        }
    }
    
    func goForward() {
        if webView?.canGoForward == true {
            HapticManager.shared.impact(style: .light)
            webView?.goForward()
        }
    }
    
    func reload() {
        HapticManager.shared.impact(style: .light)
        webView?.reload()
    }
    
    func stopLoading() {
        webView?.stopLoading()
    }
    
    func clearCache(completion: @escaping () -> Void) {
        let websiteDataTypes = WKWebsiteDataStore.allWebsiteDataTypes()
        let date = Date(timeIntervalSince1970: 0)
        WKWebsiteDataStore.default().removeData(ofTypes: websiteDataTypes, modifiedSince: date) { [weak self] in
            DispatchQueue.main.async {
                self?.reload()
                completion()
            }
        }
    }
}
