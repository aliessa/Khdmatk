import Foundation

enum InjectedScripts {
    
    // MARK: - Native Feel CSS
    static let nativeCSS: String = """
    (function() {
        var style = document.createElement('style');
        style.type = 'text/css';
        style.innerHTML = `
            /* Fix iOS tap highlight & input zoom */
            * {
                -webkit-tap-highlight-color: rgba(0, 135, 90, 0.15) !important;
            }
            input, select, textarea {
                font-size: 16px !important; /* Prevents auto-zoom in Safari iOS */
            }
            body {
                -webkit-overflow-scrolling: touch !important;
                overscroll-behavior-y: contain;
                padding-bottom: env(safe-area-inset-bottom);
            }
            /* Remove duplicate fixed mobile navigation if native tab bar is active */
            .mobile-bottom-nav, .fixed-bottom-nav {
                display: none !important;
            }
        `;
        document.head.appendChild(style);
    })();
    """
    
    // MARK: - Cart & State Bridge Script
    static let bridgeJS: String = """
    (function() {
        // Send page title and ready state
        function notifyPageReady() {
            var badgeElem = document.querySelector('.cart-count, .badge-cart, #cartCount, .cart-badge');
            var badgeVal = badgeElem ? badgeElem.innerText.trim() : "";
            
            if (window.webkit && window.webkit.messageHandlers && window.webkit.messageHandlers.khdmatkBridge) {
                window.webkit.messageHandlers.khdmatkBridge.postMessage({
                    type: "pageInfo",
                    title: document.title,
                    url: window.location.href,
                    cartCount: badgeVal
                });
            }
        }
        
        if (document.readyState === "complete" || document.readyState === "interactive") {
            notifyPageReady();
        } else {
            window.addEventListener("DOMContentLoaded", notifyPageReady);
        }
        
        // Observe cart changes dynamically
        var observer = new MutationObserver(function() {
            notifyPageReady();
        });
        
        observer.observe(document.body, { childList: true, subtree: true });
    })();
    """
}
