//
//  HesapMakinesiIslemler.swift
//  HesapMakinesi
//

import Foundation

func topla(_ lhs: Double, _ rhs: Double) -> Double {
    lhs + rhs
}

func cikar(_ lhs: Double, _ rhs: Double) -> Double {
    lhs - rhs
}

func carp(_ lhs: Double, _ rhs: Double) -> Double {
    lhs * rhs
}

func bol(_ lhs: Double, _ rhs: Double) -> Double? {
    guard rhs != 0 else { return nil }
    return lhs / rhs
}


