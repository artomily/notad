//
//  ReceiptRow.swift
//  notad
//
//  Created by yourbaemac on 05/09/26.
//

import SwiftUI

struct ReceiptRow: View {
    let receipt: Receipt

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "receipt")
                .font(.title3)
                .foregroundStyle(Theme.accent)
                .frame(width: 44, height: 44)
                .background(Theme.accent.opacity(0.12), in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(receipt.merchant)
                    .font(.body.weight(.medium))
                    .lineLimit(1)

                Text(receipt.date, format: .dateTime.day().month(.abbreviated).year())
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Text(receipt.total, format: .currency(code: "IDR").precision(.fractionLength(0)))
                .font(.callout.weight(.semibold))
        }
        .padding(.vertical, 6)
    }
}

struct MonthlyTotalCard: View {
    let total : Int
    let count : Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            Text("Pengeluaran bulan ini")
                .font(.subheadline)
            
            Text(total, format: .currency(code: "IDR").precision(.fractionLength(0)))
                .font(.system(.largeTitle, design: .rounded, weight: .bold))
            
            Text("^[\(count) struk](inflect: true) tercatat")
                .font(.caption)
                .opacity(0.85)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(Theme.cardPadding)
        .background(Theme.heroGradient)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: Theme.cardRadius))
    }
}
