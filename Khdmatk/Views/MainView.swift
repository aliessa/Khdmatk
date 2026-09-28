import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = WebViewModel()
    @ObservedObject private var networkMonitor = NetworkMonitor.shared
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                // Offline notice
                if !networkMonitor.isConnected {
                    OfflineBannerView {
                        viewModel.reload()
                    }
                }
                
                // Native Top Header
                NativeNavBar(viewModel: viewModel)
                
                // Thin progress bar
                LoadingProgressBar(
                    progress: viewModel.estimatedProgress,
                    isLoading: viewModel.isLoading
                )
                
                // Role Switcher (Customer / Merchant / Driver / Provider)
                RoleSelectorBar(viewModel: viewModel)
                
                Divider()
                
                // Main Hybrid Web Content
                WebViewContainer(viewModel: viewModel)
                    .edgesIgnoringSafeArea(.horizontal)
                
                // Customer Tab Bar (only shown when Customer role is active)
                if viewModel.selectedRole == .customer {
                    NativeTabBar(viewModel: viewModel)
                }
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .sheet(isPresented: $viewModel.showQuickActions) {
            QuickActionsSheet(viewModel: viewModel)
        }
        .sheet(isPresented: $viewModel.showSettings) {
            SettingsSheet(viewModel: viewModel)
        }
        .environment(\.layoutDirection, .rightToLeft) // Native Arabic RTL layout
    }
}
