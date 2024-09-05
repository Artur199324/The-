//
//  DailyBonusView.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import SwiftUI

struct DailyBonusView: View {
    @StateObject private var saveBac = SaveBac()
    @StateObject private var savePoints = SavePoints()
    @State private var showBonys = false
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
                   
                    Image("Daily Bonus").padding(.leading,20)
                    Spacer()
                  
                }.padding(.leading,30)
                .padding(.top,60)
                
               
                Spacer()
                
            }
            
            ZStack{
                Image("bons")
                HStack{
                    Button(action: {
                        showBonys.toggle()
                    }, label: {
                        Image("Group 13")
                    })
                    
                    Button(action: {
                        showBonys.toggle()
                    }, label: {
                        Image("Group 13")
                    })
                    
                    Button(action: {
                        showBonys.toggle()
                    }, label: {
                        Image("Group 13")
                    })
                }.padding(.top,250)
            }
          
        }.overlay(
            VStack {
                if showBonys {
                    ZStack {
                        Color.black.opacity(0.9).ignoresSafeArea()
                        Image("Frame 8").padding(.bottom,300)
                        Button(action: {
                            savePoints.saveValue(100)
                            self.dismiss()
                        }, label: {
                            Image("home").padding(.top,300)
                        })
                    }
                    .transition(.opacity)
                }
                
    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .zIndex(1) 
        )
    }

}

#Preview {
    DailyBonusView()
}
