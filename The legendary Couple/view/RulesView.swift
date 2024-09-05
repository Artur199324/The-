//
//  RulesView.swift
//  The legendary Couple
//
//  Created by Artur on 05.09.2024.
//

import SwiftUI

struct RulesView: View {
    @StateObject private var saveBac = SaveBac()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack{
            BackView(number: saveBac.value)
            VStack{
                HStack{
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("Frame 4")
                    })
                   
                    Image("Rules").padding(.leading,20)
                    Spacer()
                }.padding(.leading,30)
                .padding(.top,60)
                
                Spacer()
                
            }
            Image("Frame 5")
                .padding(.top,40)
        }
    }
}

#Preview {
    RulesView()
}
