import SwiftUI

struct RoleSelectorBar: View {
    @ObservedObject var viewModel: WebViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(AppRole.allCases) { role in
                    Button(action: {
                        viewModel.switchRole(to: role)
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: role.systemIcon)
                                .font(.system(size: 13, weight: .bold))
                            
                            Text(role.title)
                                .font(.system(size: 13, weight: .semibold))
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 7)
                        .background(
                            Group {
                                if viewModel.selectedRole == role {
                                    role.badgeColor
                                } else {
                                    Color(UIColor.secondarySystemBackground)
                                }
                            }
                        )
                        .foregroundColor(
                            viewModel.selectedRole == role ? .white : .primary
                        )
                        .clipShape(Capsule())
                        .overlay(
                            Capsule()
                                .stroke(
                                    viewModel.selectedRole == role ? Color.white.opacity(0.2) : Color.clear,
                                    lineWidth: 1
                                )
                        )
                        .shadow(
                            color: viewModel.selectedRole == role ? role.badgeColor.opacity(0.35) : Color.clear,
                            radius: 4, x: 0, y: 2
                        )
                    }
                    .buttonStyle(ScaleButtonStyle())
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 6)
        }
        .background(Color(UIColor.systemBackground).opacity(0.95))
    }
}

// Micro-interaction bounce button style
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(.spring(response: 0.25, dampingFraction: 0.65), value: configuration.isPressed)
    }
}
