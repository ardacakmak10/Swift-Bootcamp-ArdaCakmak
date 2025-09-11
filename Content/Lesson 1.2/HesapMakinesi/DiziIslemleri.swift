//
//  DiziIslemleri.swift
//  HesapMakinesi
//

import Foundation

func filtrele<T>(_ dizi: [T], kosul: (T) -> Bool) -> [T] {
    dizi.filter(kosul)
}

func sirala<T>(_ dizi: [T], karsilastir: (T, T) -> Bool) -> [T] {
    dizi.sorted(by: karsilastir)
}


