import SwiftUI

struct OfflineBannerView: View {
    let retryAction: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "wifi.slash")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
            
            Text("لا يوجد اتصال بالإنترنت. يرجى التحقق من الشبكة.")
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            
            Button(action: retryAction) {
                Text("إعادة المحاولة")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(AppConstants.primaryColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.white)
                    .clipShape(Capsule())
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(Color.red.opacity(0.92))
        .transition(.move(edge: .top).combined(with: .opacity))
    }
}
