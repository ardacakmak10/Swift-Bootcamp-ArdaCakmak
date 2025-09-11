//
//  HesapMakinesiTests.swift
//  HesapMakinesiTests
//
//  Created by Arda Çakmak on 10.09.2025.
//

import Testing
@testable import HesapMakinesi

struct HesapMakinesiTests {

    @Test func testCalculatorOperations() async throws {
        #expect(topla(2, 3) == 5)
        #expect(cikar(10, 4) == 6)
        #expect(carp(6, 7) == 42)
        #expect(bol(10, 2) == 5)
        #expect(bol(1, 0) == nil)
    }

    @Test func testFilterAndSortClosures() async throws {
        let numbers = [1, 8, 3, 5, 2]
        let evens = filtrele(numbers) { $0 % 2 == 0 }
        #expect(evens == [8, 2])

        let asc = sirala(numbers) { $0 < $1 }
        #expect(asc == [1, 2, 3, 5, 8])

        let desc = sirala(numbers) { $0 > $1 }
        #expect(desc == [8, 5, 3, 2, 1])
    }

}
