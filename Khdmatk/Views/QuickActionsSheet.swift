import SwiftUI

struct QuickActionsSheet: View {
    @ObservedObject var viewModel: WebViewModel
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    // Header Card
                    HStack(spacing: 12) {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("خدمات ومزايا منصة خدماتك")
                                .font(.system(size: 16, weight: .bold))
                            
                            Text("كل ما يحتاجه بيتك وحيك في مكان واحد")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(14)
                    
                    // Grid of Actions
                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(QuickActionItem.allActions) { action in
                            Button(action: {
                                HapticManager.shared.impact(style: .medium)
                                viewModel.load(url: action.url)
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Image(systemName: action.iconName)
                                            .font(.system(size: 18, weight: .bold))
                                            .foregroundColor(action.color)
                                            .frame(width: 38, height: 38)
                                            .background(action.color.opacity(0.12))
                                            .clipShape(Circle())
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.left")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(Color(UIColor.tertiaryLabel))
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 3) {
                                        Text(action.title)
                                            .font(.system(size: 14, weight: .bold))
                                            .foregroundColor(.primary)
                                            .lineLimit(1)
                                        
                                        Text(action.subtitle)
                                            .font(.system(size: 11, weight: .regular))
                                            .foregroundColor(.secondary)
                                            .lineLimit(2)
                                    }
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(UIColor.secondarySystemBackground))
                                .cornerRadius(12)
                            }
                            .buttonStyle(ScaleButtonStyle())
                        }
                    }
                }
                .padding(16)
            }
            .navigationTitle("المميزات السريعة")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("إغلاق") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
