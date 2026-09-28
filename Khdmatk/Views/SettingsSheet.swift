import SwiftUI

struct SettingsSheet: View {
    @ObservedObject var viewModel: WebViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var showingClearSuccess = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("معلومات التطبيق")) {
                    HStack {
                        Text("الاسم")
                        Spacer()
                        Text("خدماتك - Khedmatak")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("الإصدار")
                        Spacer()
                        Text("1.0.0 (Build 1)")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("الموقع الرسمي")
                        Spacer()
                        Text("khdmatk.store")
                            .foregroundColor(AppConstants.primaryColor)
                    }
                }
                
                Section(header: Text("إدارة البيانات والذاكرة")) {
                    Button(action: {
                        viewModel.clearCache {
                            showingClearSuccess = true
                        }
                    }) {
                        HStack {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                            Text("مسح الذاكرة المؤقتة وإعادة التحميل")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section(header: Text("الدعم والمساعدة")) {
                    Button(action: {
                        if let url = URL(string: "https://wa.me/\(AppConstants.supportWhatsAppNumber)") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        HStack {
                            Image(systemName: "message.fill")
                                .foregroundColor(.green)
                            Text("محادثة الدعم الفني عبر واتساب")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button(action: {
                        viewModel.load(url: AppConstants.privacyPolicyURL)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "hand.raised.fill")
                                .foregroundColor(.blue)
                            Text("سياسة الخصوصية")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Button(action: {
                        viewModel.load(url: AppConstants.termsURL)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "doc.text.fill")
                                .foregroundColor(.purple)
                            Text("شروط الاستخدام")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                Section(footer: Text("© 2026 منصة خدماتك للتجارة الإلكترونية. جميع الحقوق محفوظة.")) {
                    EmptyView()
                }
            }
            .navigationTitle("الإعدادات")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("تم") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .alert(isPresented: $showingClearSuccess) {
                Alert(
                    title: Text("تم بنجاح"),
                    message: Text("تم مسح الذاكرة المؤقتة وتحديث الجلسة بنجاح."),
                    dismissButton: .default(Text("حسناً"))
                )
            }
        }
    }
}
