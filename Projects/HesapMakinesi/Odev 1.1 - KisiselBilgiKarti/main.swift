import Foundation


let ad: String = "Arda"
let soyad: String = "Çakmak"
let yas: Int = 21
let ogrenciNo: Int = 3577
let boy: Double = 1.88
let kilo: Double = 65.5
let ogrenciMi: Bool = true


var telefonNumarasi: String? = nil
var eposta: String? = "ardacakmak2003@gmail.com"
var ikinciAd: String? = nil


var telefonYazdir: String
if let telefon = telefonNumarasi {
    telefonYazdir = telefon
} else {
    telefonYazdir = "Telefon numarası girilmemiş."
}


func epostayiGoster() -> String {
    guard let mail = eposta else {
        return "E-posta girilmemiş."
    }
    return mail
}


let ikinciAdYazdir = ikinciAd ?? "Yok"


print("📇 Kişisel Bilgi Kartı")
print("Ad Soyad: \(ad) \(soyad)")
print("İkinci Ad: \(ikinciAdYazdir)")
print("Yaş: \(yas)")
print("Öğrenci Numarası: \(ogrenciNo)")
print("Boy: \(boy) m")
print("Kilo: \(kilo) kg")
print("Öğrenci mi?: \(ogrenciMi ? "Evet" : "Hayır")")
print("Telefon: \(telefonYazdir)")
print("E-posta: \(epostayiGoster())")

