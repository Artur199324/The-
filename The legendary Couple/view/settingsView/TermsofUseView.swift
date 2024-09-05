//
//  TermsofUseView.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import SwiftUI

struct TermsofUseView: View {
    @Environment(\.dismiss) var dismiss

       var body: some View {
           NavigationView {
               WebView(url: URL(string: "https://www.termsfeed.com/live/641f5ce8-1654-44c3-998d-d3a418021c10")!)
                   .navigationTitle("Terms of Use")
                   .navigationBarTitleDisplayMode(.inline)
                   .navigationBarItems(trailing: Button(action: {
                       dismiss() // Закрытие представления при нажатии кнопки "Close"
                   }) {
                       Text("Close")
                           .foregroundColor(.blue)
                   })
           }
       }
}

#Preview {
    TermsofUseView()
}
