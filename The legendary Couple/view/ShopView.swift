//
//  ShopView.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import SwiftUI

struct ShopView: View {
    @StateObject private var saveBac = SaveBac()
    @StateObject private var savePoints = SavePoints()
    @StateObject private var bacAplua = BacAplua()
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
                   
                    Image("Shop").padding(.leading,20)
                    Spacer()
                    ZStack{
                        Image("Frame 3")
                        Text("\(savePoints.value)")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.leading,20)
                    
                    }.padding(.trailing,20)
                }.padding(.leading,30)
                .padding(.top,60)
                
                Button(action: {
                    saveBac.saveValue(1)
                    self.dismiss()
                }, label: {
                    Image("o1")
                })
                    
                Button(action: {
                    if !bacAplua.retrieve(for: 0){
                        if savePoints.value > 250{
                            bacAplua.save(true, for: 0)
                            savePoints.saveValue(-250)
                        }
                    }else{
                        saveBac.saveValue(2)
                        self.dismiss()
                    }
                    
                }, label: {
                    Image(bacAplua.retrieve(for: 0) ? "o2" : "oo2")
                })
                Button(action: {
                    if !bacAplua.retrieve(for: 1){
                        if savePoints.value > 350{
                            bacAplua.save(true, for: 1)
                            savePoints.saveValue(-350)
                        }
                    }else{
                        saveBac.saveValue(3)
                        self.dismiss()
                    }
                }, label: {
                    Image(bacAplua.retrieve(for: 1) ? "o3" : "oo3")
                })
                Button(action: {
                    if !bacAplua.retrieve(for: 2){
                        if savePoints.value > 450{
                            bacAplua.save(true, for: 2)
                            savePoints.saveValue(-450)
                        }
                    }else{
                        saveBac.saveValue(4)
                        self.dismiss()
                    }
                }, label: {
                    Image(bacAplua.retrieve(for: 2) ? "o4" : "oo4")
                })
                Spacer()
                
            }
          
        }
    }
}

#Preview {
    ShopView()
}
