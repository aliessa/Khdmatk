import SwiftUI

struct NativeTabBar: View {
    @ObservedObject var viewModel: WebViewModel
    
    var body: some View {
        HStack {
            ForEach(NavigationTab.allCases) { tab in
                Button(action: {
                    viewModel.switchTab(to: tab)
                }) {
                    VStack(spacing: 4) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: tab.icon)
                                .font(.system(size: 20, weight: viewModel.selectedTab == tab ? .bold : .regular))
                                .frame(height: 24)
                            
                            // Badge for cart
                            if tab == .cart && viewModel.cartCount > 0 {
                                Text("\(viewModel.cartCount)")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background(Color.red)
                                    .clipShape(Capsule())
                                    .offset(x: 10, y: -6)
                            }
                        }
                        
                        Text(tab.title)
                            .font(.system(size: 11, weight: viewModel.selectedTab == tab ? .bold : .medium))
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(
                        viewModel.selectedTab == tab ? AppConstants.primaryColor : Color(UIColor.tertiaryLabel)
                    )
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 10)
        .padding(.bottom, 22) // Space for home indicator
        .background(
            Color(UIColor.systemBackground)
                .shadow(color: Color.black.opacity(0.06), radius: 8, x: 0, y: -4)
        )
    }
}
