import SwiftUI

struct NativeNavBar: View {
    @ObservedObject var viewModel: WebViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Navigation controls (Back / Forward)
            HStack(spacing: 6) {
                Button(action: {
                    viewModel.goBack()
                }) {
                    Image(systemName: "chevron.right") // In RTL, right is back
                        .font(.system(size: 15, weight: .bold))
                        .frame(width: 34, height: 34)
                        .background(Color(UIColor.secondarySystemBackground))
                        .foregroundColor(viewModel.canGoBack ? .primary : Color(UIColor.tertiaryLabel))
                        .clipShape(Circle())
                }
                .disabled(!viewModel.canGoBack)
                
                Button(action: {
                    viewModel.goForward()
                }) {
                    Image(systemName: "chevron.left") // In RTL, left is forward
                        .font(.system(size: 15, weight: .bold))
                        .frame(width: 34, height: 34)
                        .background(Color(UIColor.secondarySystemBackground))
                        .foregroundColor(viewModel.canGoForward ? .primary : Color(UIColor.tertiaryLabel))
                        .clipShape(Circle())
                }
                .disabled(!viewModel.canGoForward)
            }
            
            Spacer()
            
            // Brand Center Logo & Title
            HStack(spacing: 8) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
                VStack(alignment: .center, spacing: 1) {
                    Text("خدماتك")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(AppConstants.primaryColor)
                    
                    Text(viewModel.selectedRole.title)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            // Action buttons (Reload, Fast Features, Settings)
            HStack(spacing: 6) {
                Button(action: {
                    if viewModel.isLoading {
                        viewModel.stopLoading()
                    } else {
                        viewModel.reload()
                    }
                }) {
                    Image(systemName: viewModel.isLoading ? "xmark" : "arrow.clockwise")
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 34, height: 34)
                        .background(Color(UIColor.secondarySystemBackground))
                        .foregroundColor(.primary)
                        .clipShape(Circle())
                }
                
                Button(action: {
                    HapticManager.shared.impact(style: .medium)
                    viewModel.showQuickActions.toggle()
                }) {
                    Image(systemName: "square.grid.2x2.fill")
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 34, height: 34)
                        .background(AppConstants.primaryColor.opacity(0.12))
                        .foregroundColor(AppConstants.primaryColor)
                        .clipShape(Circle())
                }
                
                Button(action: {
                    HapticManager.shared.impact(style: .light)
                    viewModel.showSettings.toggle()
                }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 14, weight: .bold))
                        .frame(width: 34, height: 34)
                        .background(Color(UIColor.secondarySystemBackground))
                        .foregroundColor(.secondary)
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(UIColor.systemBackground))
    }
}
