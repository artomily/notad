//
//  ContentView.swift
//  notad
//
//  Created by yourbaemac on 02/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Receipt.date, order: .reverse) private var receipts: [Receipt]
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(receipts){ receipt in
                    HStack{
                        VStack(alignment: .leading){
                            Text(receipt.merchant)
                            Text(receipt.date, format: .dateTime.day().month().year())
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(receipt.total, format: .currency(code: "IDR").precision(.fractionLength(0)))
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(Text("Notad"))
            .toolbar{
                Button("Tambah", systemImage: "plus", action: addDummy)
            }
        }
    }
    private func addDummy(){
        let receipt = Receipt(merchant: "INDOMARET", total: 39_500, date: .now)
               context.insert(receipt)
    }
    private func delete(at offsets: IndexSet) {
            for index in offsets {
                context.delete(receipts[index])
            }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Receipt.self, inMemory: true)
}
