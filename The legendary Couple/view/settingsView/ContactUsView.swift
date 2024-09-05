//
//  ContactUsView.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import SwiftUI

struct ContactUsView: View {
    @StateObject private var saveBac = SaveBac()
    @State private var showMessage = false
    @State private var name: String = ""
       @State private var email: String = ""
       @State private var message: String = ""
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
                   
                    Image("Contact Us").padding(.leading,20)
                    Spacer()
                }.padding(.leading,30)
                .padding(.top,60)
                
                
                ZStack{
                    Image("Frame 16")
                    VStack(alignment: .leading, spacing: 5) {
                                Group {
                                    // Поле для ввода имени
                                    Text("Your Name")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("Enter Your Name", text: $name)
                                        .padding()
                                        .background(Color.purple.opacity(0.3))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .bold))
                                    
                                    // Поле для ввода email
                                    Text("Email")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextField("Enter Your Email", text: $email)
                                        .padding()
                                        .background(Color.purple.opacity(0.3))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .bold))
                                        .keyboardType(.emailAddress)
                                    
                                    // Поле для ввода сообщения
                                    Text("Message")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    TextEditor(text: $message)
                                        .padding()
                                        .background(Color.purple.opacity(0.3))
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .bold))
                                        .frame(height: 150)
                                        .scrollContentBackground(.hidden) // Убирает стандартный фон
                                        .background(Color.purple.opacity(0.3))
                                }
                                
                            
                    }.padding(.horizontal,50)
                        .padding(.vertical,0)
                          
                           
                   
                }.padding(.top,100)
                Button(action: {
                    showMessage.toggle()
                }, label: {
                   Image("Frame 7")
                })
                Spacer()
                
            }
           
        }.overlay(
            VStack {
                if showMessage {
                    ZStack {
                        Color.black.opacity(0.9).ignoresSafeArea()
                        Image("Frame 15").padding(.bottom,300)
                        Button(action: {
                            self.dismiss()
                        }, label: {
                            Image("Frame 9").padding(.top,300)
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
    ContactUsView()
}
