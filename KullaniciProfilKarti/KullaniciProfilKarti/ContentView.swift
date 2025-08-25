import SwiftUI

struct ContentView: View {
    @State private var isFollowing = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header: Geliştirilmiş Gradient Arka Plan
                ZStack {
                    // Çok katmanlı gradient efekti
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.purple.opacity(0.8),
                            Color.indigo,
                            Color.blue,
                            Color.cyan.opacity(0.6)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(height: 200)
                    .overlay(
                        // Işık efekti için ikinci gradient
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.white.opacity(0.3),
                                Color.clear,
                                Color.black.opacity(0.1)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    
                    // Dekoratif circles
                    GeometryReader { geometry in
                        Circle()
                            .fill(Color.white.opacity(0.1))
                            .frame(width: 120, height: 120)
                            .position(x: geometry.size.width * 0.2, y: 30)
                        
                        Circle()
                            .fill(Color.white.opacity(0.05))
                            .frame(width: 80, height: 80)
                            .position(x: geometry.size.width * 0.8, y: 60)
                    }
                    
                    VStack(spacing: 8) {
                        Text("Profil")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("Arda Çakmak")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .offset(y: -20)
                }
                .clipShape(
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 30,
                        bottomTrailingRadius: 30,
                        topTrailingRadius: 0
                    )
                )
                .shadow(color: Color.purple.opacity(0.3), radius: 15, y: 5)
                
                // Profil resmi - header'ın dışına taşan - Assets'ten fotoğraf kullanımı
                Image("profil") // Assets'e eklenen fotoğraf
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 110, height: 110)
                    .clipShape(Circle())
                    .background(
                        Circle()
                            .fill(Color.white)
                            .frame(width: 118, height: 118)
                    )
                    .overlay(
                        Circle()
                            .stroke(
                                LinearGradient(
                                    colors: [.white, .gray.opacity(0.3)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 4
                            )
                    )
                    .shadow(color: Color.black.opacity(0.15), radius: 10, y: 5)
                    .offset(y: -55)
                
                VStack(spacing: 25) {
                    // Profil bilgileri
                    VStack(spacing: 8) {
                        Text("iOS Developer")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        HStack(spacing: 4) {
                            Image(systemName: "location.fill")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text("İstanbul, Türkiye")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .offset(y: -30)
                    
                    // Geliştirilmiş Bilgi Kartları
                    HStack(spacing: 20) {
                        EnhancedInfoCard(
                            icon: "person.2.fill",
                            title: "Takipçi",
                            value: "329",
                            color: .blue
                        )
                        EnhancedInfoCard(
                            icon: "person.fill.badge.plus",
                            title: "Takip",
                            value: "416",
                            color: .green
                        )
                        EnhancedInfoCard(
                            icon: "heart.fill",
                            title: "Beğeni",
                            value: "5K",
                            color: .red
                        )
                    }
                    .padding(.horizontal)
                    .offset(y: -20)
                    
                    // Hakkımda Bölümü - Geliştirilmiş
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title2)
                            Text("Hakkımda")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                        
                        Text("Swift'te uygulamalı deneyime ve arka uç desteği ve otomasyonu için pratik Python becerilerine sahip, istekli iOS geliştiricisi. Mobil uygulamalarda gelişmiş veri sorgulama ve yönetimi için SQL konusunda yetkin.")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                            .multilineTextAlignment(.leading)
                        
                        // Beceriler tags
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                SkillTag(text: "Swift", color: .orange)
                                SkillTag(text: "iOS", color: .blue)
                                SkillTag(text: "Python", color: .green)
                                SkillTag(text: "SQL", color: .purple)
                                SkillTag(text: "SwiftUI", color: .pink)
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 20)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: Color.black.opacity(0.05), radius: 8, y: 2)
                    )
                    .padding(.horizontal)
                    
                    // Geliştirilmiş Butonlar
                    HStack(spacing: 15) {
                        // Mesaj Gönder Butonu
                        Button(action: {
                            // Mesaj gönderme işlemi
                        }) {
                            HStack {
                                Image(systemName: "message.fill")
                                Text("Mesaj Gönder")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                LinearGradient(
                                    colors: [.blue, .indigo],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(color: Color.blue.opacity(0.3), radius: 8, y: 4)
                        }
                        .scaleEffect(1.0)
                        .animation(.spring(response: 0.3), value: isFollowing)
                        
                        // Takip Et Butonu
                        Button(action: {
                            withAnimation(.spring(response: 0.3)) {
                                isFollowing.toggle()
                            }
                        }) {
                            HStack {
                                Image(systemName: isFollowing ? "checkmark" : "plus")
                                Text(isFollowing ? "Takip Ediliyor" : "Takip Et")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(
                                isFollowing ?
                                LinearGradient(colors: [.gray.opacity(0.3)], startPoint: .leading, endPoint: .trailing) :
                                LinearGradient(colors: [.green, .mint], startPoint: .leading, endPoint: .trailing)
                            )
                            .foregroundColor(isFollowing ? .secondary : .white)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(
                                color: isFollowing ? Color.clear : Color.green.opacity(0.3),
                                radius: 8,
                                y: 4
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .ignoresSafeArea(edges: .top)
    }
}

// Geliştirilmiş Bilgi Kartı
struct EnhancedInfoCard: View {
    var icon: String
    var title: String
    var value: String
    var color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .padding(.bottom, 4)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .fontWeight(.medium)
        }
        .frame(width: 100, height: 100)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: color.opacity(0.1), radius: 8, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// Beceri etiketi
struct SkillTag: View {
    var text: String
    var color: Color
    
    var body: some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .clipShape(Capsule())
    }
}

#Preview {
    ContentView()
}
