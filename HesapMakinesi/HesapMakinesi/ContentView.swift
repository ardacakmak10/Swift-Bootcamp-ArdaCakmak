import SwiftUI

enum Islem: String, CaseIterable, Identifiable {
    case topla = "Topla (+)"
    case cikar = "Çıkar (−)"
    case carp  = "Çarp (×)"
    case bol   = "Böl (÷)"
    var id: String { rawValue }
}

func hesapla(_ a: Double, _ b: Double, islem: Islem) -> Double? {
    switch islem {
    case .topla: return a + b
    case .cikar: return a - b
    case .carp:  return a * b
    case .bol:
        return b == 0 ? nil : a / b
    }
}

enum FiltreModu: String, CaseIterable, Identifiable {
    case tumu = "Tümü"
    case cift = "Çift"
    case tek  = "Tek"
    var id: String { rawValue }
}

enum SiralamaModu: String, CaseIterable, Identifiable {
    case artan = "Artan"
    case azalan = "Azalan"
    var id: String { rawValue }
}

struct ContentView: View {
    @State private var sayi1: String = ""
    @State private var sayi2: String = ""
    @State private var secilenIslem: Islem = .topla
    @State private var sonucMetni: String = "Henüz işlem yapılmadı."
    @State private var gecmis: [Double] = []
    @State private var filtre: FiltreModu = .tumu
    @State private var siralama: SiralamaModu = .artan
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    Group {
                        TextField("Birinci sayı", text: $sayi1)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("İkinci sayı", text: $sayi2)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Picker("İşlem", selection: $secilenIslem) {
                            ForEach(Islem.allCases) { islem in
                                Text(islem.rawValue).tag(islem)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Button {
                        let a = Double(sayi1.replacingOccurrences(of: ",", with: "."))
                        let b = Double(sayi2.replacingOccurrences(of: ",", with: "."))
                        
                        guard let a, let b else {
                            sonucMetni = "Lütfen geçerli iki sayı girin."
                            return
                        }
                        if let sonuc = hesapla(a, b, islem: secilenIslem) {
                            sonucMetni = "Sonuç: \(sonuc)"
                            gecmis.append(sonuc)
                        } else {
                            sonucMetni = "Hata: 0'a bölünemez."
                        }
                    } label: {
                        Text("Hesapla")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor.opacity(0.15))
                            .cornerRadius(12)
                    }
                    
                    Text(sonucMetni)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                    
                    Divider().padding(.vertical, 4)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Geçmiş")
                            .font(.title3).bold()
                        
                        HStack {
                            Picker("Filtre", selection: $filtre) {
                                ForEach(FiltreModu.allCases) { f in
                                    Text(f.rawValue).tag(f)
                                }
                            }
                            .pickerStyle(.menu)
                            
                            Picker("Sıralama", selection: $siralama) {
                                ForEach(SiralamaModu.allCases) { s in
                                    Text(s.rawValue).tag(s)
                                }
                            }
                            .pickerStyle(.menu)
                        }
                        
                        let filtreClosure: (Double) -> Bool = { deger in
                            switch filtre {
                            case .tumu: return true
                            case .cift: return deger.truncatingRemainder(dividingBy: 2) == 0
                            case .tek:  return abs(deger.truncatingRemainder(dividingBy: 2)) == 1
                            }
                        }
                        let siralaClosure: (Double, Double) -> Bool = { a, b in
                            switch siralama {
                            case .artan:  return a < b
                            case .azalan: return a > b
                            }
                        }
                        
                        let gosterilecek = gecmis
                            .filter(filtreClosure)
                            .sorted(by: siralaClosure)
                        
                        if gosterilecek.isEmpty {
                            Text("Henüz geçmiş yok ya da seçime uyan sonuç bulunamadı.")
                                .foregroundColor(.secondary)
                        } else {
                            VStack(alignment: .leading, spacing: 6) {
                                ForEach(Array(gosterilecek.enumerated()), id: \.offset) { _, val in
                                    Text("• \(val)")
                                }
                            }
                        }
                        
                        Button(role: .destructive) {
                            gecmis.removeAll()
                        } label: {
                            Text("Geçmişi Temizle")
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(Color.red.opacity(0.1))
                                .cornerRadius(10)
                        }
                        .padding(.top, 6)
                    }
                }
                .padding()
            }
            .navigationTitle("Hesap Makinesi")
        }
    }
}

@main
struct HesapMakinesiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
