//
//  ReceiptParserTests.swift
//  notad
//
//  Created by yourbaemac on 03/09/26.
//

import Testing
@testable import notad

struct ReceiptParserTests {

    let parser = ReceiptParser()

    @Test func parsesIndomaretReceipt() {
        let lines = [
            "INDOMARET",
            "Jl. Kaliurang KM 5",
            "02/09/26  14:32",
            "Indomilk 1L      x2    24.000",
            "Roti Tawar       x1     15.500",
            "SUBTOTAL              39.500",
            "TOTAL                 39.500"
        ]

        let result = parser.parse(lines: lines)

        #expect(result.merchant == "INDOMARET")
        #expect(result.total == 39_500)
    }

    @Test func ignoresSubtotalWhenTotalExists() {
        let result = parser.parse(lines: ["SUBTOTAL 10.000", "TOTAL 12.000"])
        #expect(result.total == 12_000)
    }

    @Test func handlesDecimalComma() {
        let result = parser.parse(lines: ["TOTAL 45.000,00"])
        #expect(result.total == 45_000)
    }

    @Test func fallsBackToLargestAmountWithoutKeyword() {
        let result = parser.parse(lines: ["WARUNG BU TINI", "Nasi 15.000", "Es Teh 5.000"])
        #expect(result.total == 15_000)
    }

    @Test func returnsNilTotalWhenNoAmounts() {
        let result = parser.parse(lines: ["TOKO KOSONG", "terima kasih"])
        #expect(result.total == nil)
    }
}
