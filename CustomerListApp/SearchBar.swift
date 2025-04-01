//
//  SearchBar.swift
//  CustomerListApp
//
//  Created by Abhay Singh Siddhu on 01/04/25.
//


import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search by name or city", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)

            if !text.isEmpty {
                Button(action: { text = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}
