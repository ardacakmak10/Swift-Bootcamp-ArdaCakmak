//
//  ContentView.swift
//  HesapMakinesi
//
//  Created by Arda Çakmak on 10.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var numberA: String = ""
    @State private var numberB: String = ""
    @State private var secilenIslem: Islem = .carpma
    @State private var sonucMetni: String = ""
    @State private var gecmis: [Kayit] = []

    // Geçmiş filtre/sıralama kontrolleri
    @State private var filtreIslem: IslemFiltre = .tum
    @State private var sadeceGecerli: Bool = false
    @State private var siralamaOlcutu: Siralama = .tarihAzalan

    // Sonuç listesi filtre/sıralama
    @State private var sonucParite: PariteFiltre = .tum
    @State private var sonucSiralama: SonucSiralama = .artan

    // Yardımcı: sayıya çevir
    private var a: Double { Double(numberA) ?? 0 }
    private var b: Double { Double(numberB) ?? 0 }

    // Filtrelenmiş ve sıralanmış geçmiş
    private var gosterilecekGecmis: [Kayit] {
        let filtrelenmis = filtrele(gecmis) { kayit in
            let islemUygun: Bool = {
                switch filtreIslem {
                case .tum: return true
                case .toplama: return kayit.islem == .toplama
                case .cikarma: return kayit.islem == .cikarma
                case .carpma: return kayit.islem == .carpma
                case .bolme: return kayit.islem == .bolme
                }
            }()
            let gecerliUygun = !sadeceGecerli || kayit.sonuc != nil
            return islemUygun && gecerliUygun
        }

        switch siralamaOlcutu {
        case .tarihArtan:
            return sirala(filtrelenmis) { $0.tarih < $1.tarih }
        case .tarihAzalan:
            return sirala(filtrelenmis) { $0.tarih > $1.tarih }
        case .sonucaGoreArtan:
            return sirala(filtrelenmis) { ($0.sonuc ?? .infinity) < ($1.sonuc ?? .infinity) }
        case .sonucaGoreAzalan:
            return sirala(filtrelenmis) { ($0.sonuc ?? -.infinity) > ($1.sonuc ?? -.infinity) }
        }
    }

    private func hesaplaVeKaydet() {
        let sonuc: Double?
        switch secilenIslem {
        case .toplama: sonuc = topla(a, b)
        case .cikarma: sonuc = cikar(a, b)
        case .carpma: sonuc = carp(a, b)
        case .bolme: sonuc = bol(a, b)
        }

        if let s = sonuc {
            sonucMetni = String(s)
        } else {
            sonucMetni = "Tanımsız (0'a bölünemez)"
        }

        let kayit = Kayit(
            sayiA: a,
            sayiB: b,
            islem: secilenIslem,
            sonuc: sonuc,
            tarih: Date()
        )
        gecmis.append(kayit)
    }

    var body: some View {
        NavigationView {
            Form {
                // Giriş ve işlem seçimi
                Section(header: Text("Hesap Makinesi")) {
                    HStack {
                        TextField("1. sayıyı girin", text: $numberA)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                        TextField("2. sayıyı girin", text: $numberB)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.roundedBorder)
                    }

                    HStack(spacing: 12) {
                        islemButonu(title: "+", islem: .toplama)
                        islemButonu(title: "-", islem: .cikarma)
                        islemButonu(title: "×", islem: .carpma)
                        islemButonu(title: "÷", islem: .bolme)
                    }

                    Button("Hesapla") {
                        hesaplaVeKaydet()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accentColor)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, alignment: .center)

                    if !sonucMetni.isEmpty {
                        Text("Sonuç: \(sonucMetni)")
                            .font(.title3.weight(.semibold))
                            .monospacedDigit()
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.secondary.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }

                // (Geçmiş bölümü kaldırıldı) Sadece sonuçlar aşağıda gösteriliyor

                // Sadece sonuçların listesi (closure ile filtre/sıralama)
                Section(header: Text("Sonuçlar")) {
                    HStack {
                        Picker("", selection: $sonucParite) {
                            ForEach(PariteFiltre.allCases, id: \.self) { p in
                                Text(p.gorunenAd).tag(p)
                            }
                        }
                        .pickerStyle(.segmented)

                        Picker("", selection: $sonucSiralama) {
                            ForEach(SonucSiralama.allCases, id: \.self) { s in
                                Text(s.gorunenAd).tag(s)
                            }
                        }
                        .pickerStyle(.segmented)
                    }

                    let tumGecerliSonuclar = filtrele(gecmis.compactMap { $0.sonuc }) { _ in true }
                    let pariteFiltreli: [Double] = filtrele(tumGecerliSonuclar) { deger in
                        switch sonucParite {
                        case .tum: return true
                        case .tek: return Int(deger) % 2 != 0
                        case .cift: return Int(deger) % 2 == 0
                        }
                    }
                    let sirali: [Double] = sirala(pariteFiltreli) { lhs, rhs in
                        switch sonucSiralama {
                        case .artan: return lhs < rhs
                        case .azalan: return lhs > rhs
                        }
                    }

                    if sirali.isEmpty {
                        Text("Sonuç yok")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(Array(sirali.enumerated()), id: \.offset) { _, deger in
                            Text(String(deger))
                                .monospacedDigit()
                                .padding(10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.secondary.opacity(0.08))
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

// MARK: - Modeller ve yardımcılar

private enum Islem: CaseIterable, Equatable {
    case toplama, cikarma, carpma, bolme

    var gorunenAd: String {
        switch self {
        case .toplama: return "Toplama"
        case .cikarma: return "Çıkarma"
        case .carpma: return "Çarpma"
        case .bolme: return "Bölme"
        }
    }
}

private enum IslemFiltre: CaseIterable {
    case tum, toplama, cikarma, carpma, bolme

    var gorunenAd: String {
        switch self {
        case .tum: return "Tümü"
        case .toplama: return "Toplama"
        case .cikarma: return "Çıkarma"
        case .carpma: return "Çarpma"
        case .bolme: return "Bölme"
        }
    }
}

private enum Siralama: CaseIterable {
    case tarihArtan, tarihAzalan, sonucaGoreArtan, sonucaGoreAzalan

    var gorunenAd: String {
        switch self {
        case .tarihArtan: return "Tarih ↑"
        case .tarihAzalan: return "Tarih ↓"
        case .sonucaGoreArtan: return "Sonuç ↑"
        case .sonucaGoreAzalan: return "Sonuç ↓"
        }
    }
}

private struct Kayit: Identifiable, Equatable {
    let id = UUID()
    let sayiA: Double
    let sayiB: Double
    let islem: Islem
    let sonuc: Double?
    let tarih: Date

    var aciklama: String {
        let sol = String(sayiA)
        let sag = String(sayiB)
        let op: String
        switch islem {
        case .toplama: op = "+"
        case .cikarma: op = "-"
        case .carpma: op = "×"
        case .bolme: op = "÷"
        }
        let sonucStr = sonuc.map { String($0) } ?? "Tanımsız"
        return "\(sol) \(op) \(sag) = \(sonucStr)"
    }
}

private enum PariteFiltre: CaseIterable { // sonuçlara özel filtre
    case tum, tek, cift
    var gorunenAd: String {
        switch self {
        case .tum: return "Tümü"
        case .tek: return "Tek"
        case .cift: return "Çift"
        }
    }
}

private enum SonucSiralama: CaseIterable {
    case artan, azalan
    var gorunenAd: String {
        switch self {
        case .artan: return "Artan"
        case .azalan: return "Azalan"
        }
    }
}

// Yardımcı View: İşlem Butonu
private extension ContentView {
    func islemButonu(title: String, islem: Islem) -> some View {
        Button(action: { secilenIslem = islem }) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(
                    (secilenIslem == islem ? Color.accentColor.opacity(0.20) : Color.secondary.opacity(0.10))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(secilenIslem == islem ? Color.accentColor : Color.secondary.opacity(0.35), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .buttonStyle(.plain)
    }
}
