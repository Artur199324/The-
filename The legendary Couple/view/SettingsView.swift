//
//  SettingsView.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import SwiftUI
import StoreKit
struct SettingsView: View {
    @StateObject private var saveBac = SaveBac()
    @Environment(\.dismiss) var dismiss
    @AppStorage("toggleState") private var isOn = false
    @State private var showPrivacyPolicy = false
    @State private var showTermsofUse = false
    @State private var showContact = false
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
                   
                    Image("Settings").padding(.leading,20)
                    Spacer()
                }.padding(.leading,30)
                .padding(.top,60)
                
                VStack{
                    ZStack{
                        Image("sau")
                        Toggle(isOn: $isOn) {

                                }
                                .toggleStyle(CustomToggleStyle())
                                .padding()
                                .onChange(of: isOn) {  newValue, oldValue  in
                                    print("Toggle is now \(newValue ? "ON" : "OFF")")
                                }
                    }
                    Button(action: {
                        requestAppReview()
                    }, label: {
                        Image("Frame 10")
                    })
                  
                    
                    Button(action: {
                        showContact.toggle()
                    }, label: {
                        Image("Frame 13")
                    })
                    Button(action: {
                        showTermsofUse.toggle()
                    }, label: {
                        Image("Frame 12")
                    })
                    
                    Button(action: {
                        showPrivacyPolicy = true
                    }, label: {
                        Image("Frame 14")
                    })
                }
                Spacer()
                
            }
           
        } .fullScreenCover(isPresented: $showPrivacyPolicy) {
            PrivacyPolicyView()
        }
        .fullScreenCover(isPresented: $showTermsofUse) {
            TermsofUseView()
        }
        .fullScreenCover(isPresented: $showContact) {
            ContactUsView()
        }
        
    }
    func requestAppReview() {
           if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
               SKStoreReviewController.requestReview(in: scene)
           }
       }
}

#Preview {
    SettingsView()
}
