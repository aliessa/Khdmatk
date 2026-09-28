import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    @ObservedObject var viewModel: WebViewModel
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        
        let userContentController = WKUserContentController()
        
        // Inject custom CSS
        let cssScript = WKUserScript(
            source: InjectedScripts.nativeCSS,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        userContentController.addUserScript(cssScript)
        
        // Inject Bridge script
        let bridgeScript = WKUserScript(
            source: InjectedScripts.bridgeJS,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: false
        )
        userContentController.addUserScript(bridgeScript)
        
        // Add script message handler
        let bridgeHandler = WebScriptBridge(viewModel: viewModel)
        userContentController.add(bridgeHandler, name: "khdmatkBridge")
        
        configuration.userContentController = userContentController
        
        // Website data store with persistent cookies
        configuration.websiteDataStore = WKWebsiteDataStore.default()
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.bounces = true
        webView.scrollView.alwaysBounceVertical = true
        webView.scrollView.keyboardDismissMode = .onDrag
        
        // Custom user agent
        if let baseUA = webView.customUserAgent ?? (webView.value(forKey: "userAgent") as? String) {
            webView.customUserAgent = "\(baseUA) \(AppConstants.userAgentSuffix)"
        } else {
            webView.customUserAgent = AppConstants.userAgentSuffix
        }
        
        // Pull-to-refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(AppConstants.primaryColor)
        refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.handleRefresh(_:)), for: .valueChanged)
        webView.scrollView.refreshControl = refreshControl
        context.coordinator.refreshControl = refreshControl
        
        // KVO Observers
        context.coordinator.setupObservers(for: webView)
        
        // Bind webView to ViewModel
        viewModel.webView = webView
        
        // Initial load
        var request = URLRequest(url: viewModel.currentURL)
        request.cachePolicy = .useProtocolCachePolicy
        request.timeoutInterval = 25.0
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // State updates handled reactively via viewModel methods
    }
    
    // MARK: - Coordinator
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebViewContainer
        weak var refreshControl: UIRefreshControl?
        private var progressObservation: NSKeyValueObservation?
        private var canGoBackObservation: NSKeyValueObservation?
        private var canGoForwardObservation: NSKeyValueObservation?
        private var titleObservation: NSKeyValueObservation?
        private var urlObservation: NSKeyValueObservation?
        
        init(_ parent: WebViewContainer) {
            self.parent = parent
            super.init()
        }
        
        func setupObservers(for webView: WKWebView) {
            progressObservation = webView.observe(\.estimatedProgress, options: [.new]) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    self?.parent.viewModel.estimatedProgress = webView.estimatedProgress
                }
            }
            
            canGoBackObservation = webView.observe(\.canGoBack, options: [.new]) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    self?.parent.viewModel.canGoBack = webView.canGoBack
                }
            }
            
            canGoForwardObservation = webView.observe(\.canGoForward, options: [.new]) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    self?.parent.viewModel.canGoForward = webView.canGoForward
                }
            }
            
            titleObservation = webView.observe(\.title, options: [.new]) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    if let title = webView.title, !title.isEmpty {
                        self?.parent.viewModel.pageTitle = title
                    }
                }
            }
            
            urlObservation = webView.observe(\.url, options: [.new]) { [weak self] webView, _ in
                DispatchQueue.main.async {
                    if let url = webView.url {
                        self?.parent.viewModel.currentURL = url
                    }
                }
            }
        }
        
        @objc func handleRefresh(_ sender: UIRefreshControl) {
            HapticManager.shared.impact(style: .light)
            parent.viewModel.reload()
        }
        
        // MARK: - WKNavigationDelegate
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }
            
            let scheme = url.scheme?.lowercased() ?? ""
            
            // External schemas (WhatsApp, Tel, Mailto, Maps)
            if scheme == "tel" || scheme == "mailto" || scheme == "sms" || scheme == "whatsapp" {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    decisionHandler(.cancel)
                    return
                }
            }
            
            // WhatsApp Web links (wa.me or api.whatsapp.com)
            if let host = url.host?.lowercased(), host.contains("wa.me") || host.contains("whatsapp.com") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
                return
            }
            
            // Handle target="_blank" links within the same webview
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
                decisionHandler(.cancel)
                return
            }
            
            decisionHandler(.allow)
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.viewModel.isLoading = true
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.async {
                self.parent.viewModel.isLoading = false
                self.refreshControl?.endRefreshing()
            }
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.viewModel.isLoading = false
                self.refreshControl?.endRefreshing()
            }
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            DispatchQueue.main.async {
                self.parent.viewModel.isLoading = false
                self.refreshControl?.endRefreshing()
            }
        }
        
        // MARK: - WKUIDelegate (Native Alerts)
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            let alert = UIAlertController(title: "خدماتك", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "موافق", style: .default) { _ in
                completionHandler()
            })
            topViewController()?.present(alert, animated: true)
        }
        
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            let alert = UIAlertController(title: "خدماتك", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "موافق", style: .default) { _ in
                completionHandler(true)
            })
            alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel) { _ in
                completionHandler(false)
            })
            topViewController()?.present(alert, animated: true)
        }
        
        private func topViewController() -> UIViewController? {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
                return nil
            }
            var topController = window.rootViewController
            while let presented = topController?.presentedViewController {
                topController = presented
            }
            return topController
        }
    }
}
