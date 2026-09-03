//
//  ReceiptParcer.swift
//  notad
//
//  Created by yourbaemac on 02/09/26.
//

import Foundation

struct ReceiptParser: Sendable {
    private static let totalKeywords = ["grand total","total","jumlah","tunai"]
    
    func parse(lines: [String]) -> ParsedReceipt {
        let cleaned = lines
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
        
        return ParsedReceipt(
            merchant: findMerchant(in: cleaned),
            total: findTotal(in: cleaned),
            date: findDate(in: cleaned)
        )
    }
    
    //MARK: - Merchant
    
    private func findMerchant(in lines: [String]) -> String? {
        // Nama toko hampir selalu di baris paling atas struk.
        lines.first { line in
            line.count >= 3 && line.rangeOfCharacter(from: .letters) != nil
        }
    }
    
    //MARK: - Total
    
    private func findTotal(in lines: [String]) -> Int? {
        for line in lines{
            let lower = line.lowercased()
            
            // "SUBTOTAL" mengandung "total" tapi bukan yang kita mau.
            guard !lower.contains("sub") else {continue}
            guard Self.totalKeywords.contains(where: {lower.contains($0) }) else {continue}
        
            if let amount = amounts(in: line).max(){
                return amount
            }
        }
        // Fallback: kalau gak ada keyword sama sekali, ambil angka terbesar.
        return lines.flatMap {amounts(in: $0) }.max()
    }

    private func amounts(in line: String) -> [Int] {
        let pattern = /\d[\d..]*/
            return line.matches(of: pattern).compactMap{ match in
                normalize(String(match.output))
        }
    }

    /// "45.000" -> 45000, "45.000,00" -> 45000, "1,234,567" -> 1234567
    private func normalize(_ raw:String) -> Int? {
        var text = raw
    
        // Buang bagian desimal Indonesia: koma diikuti tepat 2 digit di akhir.
        if let range = text.firstRange(of: /.\d{2}$/) {
            text.removeSubrange(range)
        }
        
        let digits = text.filter(\.isNumber)
        guard !digits.isEmpty, let value = Int(digits) else { return nil }
        
        // Angka terlalu kecil biasanya nomor antrian atau kuantitas.
        return value >= 100 ? value : nil
    }
    
    //MARK: - DATE

    private func findDate(in lines: [String]) -> Date? {
        let pattern =  /(\d{1,2})[\/\-.](\d{1,2})[\/\-.](\d{2,4})/
        
        for line in lines {
            guard let match = line.firstMatch(of: pattern) else { continue }
            
            let day = Int(match.output.1) ?? 0
            let month = Int(match.output.2) ?? 0
            var year = Int(match.output.3) ?? 0
            if year < 100 {year += 2000}
            
            var components = DateComponents()
            components.day = day
            components.month = month
            components.year = year
            
            if let date = Calendar(identifier: .gregorian).date(from: components){
                return date
            }
        }
        return nil
    }
    
}
