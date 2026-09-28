import Foundation
import WebKit

final class WebScriptBridge: NSObject, WKScriptMessageHandler {
    weak var viewModel: WebViewModel?
    
    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "khdmatkBridge",
              let body = message.body as? [String: Any],
              let type = body["type"] as? String else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            switch type {
            case "pageInfo":
                if let cartCountStr = body["cartCount"] as? String, !cartCountStr.isEmpty {
                    self?.viewModel?.cartCount = Int(cartCountStr) ?? 0
                }
                if let title = body["title"] as? String, !title.isEmpty {
                    self?.viewModel?.pageTitle = title
                }
            case "haptic":
                HapticManager.shared.impact(style: .medium)
            default:
                break
            }
        }
    }
}
