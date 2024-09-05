//
//  PrivacyPolicyView.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss

       var body: some View {
           NavigationView {
               WebView(url: URL(string: "https://www.termsfeed.com/live/794b3546-8477-4ac9-86f5-22ae517dfb85")!)
                   .navigationTitle("Privacy Policy")
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
    PrivacyPolicyView()
}
