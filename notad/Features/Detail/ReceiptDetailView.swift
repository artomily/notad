//
//  ReceiptDetailView.swift
//  notad
//
//  Created by yourbaemac on 03/09/26.
//

import SwiftUI
import SwiftData

struct ReceiptDetailView: View {
    @Bindable var receipt: Receipt
    
    var body: some View {
        Form {
            Section("Toko"){
                TextField("Nama Toko", text: $receipt.merchant)
            }
            Section("Total"){
                TextField("Total", value: $receipt.total, format: .number)
                    .keyboardType(.numberPad)
            }
            Section("Tanggal"){
                DatePicker("Tanggal", selection: $receipt.date, displayedComponents: .date)
            }
            .navigationTitle(receipt.merchant)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
