import SwiftUI

@main
struct KhdmatkApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .accentColor(AppConstants.primaryColor)
        }
    }
}
