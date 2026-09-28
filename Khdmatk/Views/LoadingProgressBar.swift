import SwiftUI

struct LoadingProgressBar: View {
    let progress: Double
    let isLoading: Bool
    
    var body: some View {
        if isLoading && progress < 1.0 {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 3)
                    
                    LinearGradient(
                        colors: [AppConstants.primaryColor, AppConstants.secondaryColor, AppConstants.goldAccent],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geometry.size.width * CGFloat(progress), height: 3)
                    .animation(.easeInOut(duration: 0.2), value: progress)
                }
            }
            .frame(height: 3)
            .transition(.opacity)
        }
    }
}
