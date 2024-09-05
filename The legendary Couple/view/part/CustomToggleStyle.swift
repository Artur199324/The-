//
//  CustomToggleStyle.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(
                    gradient: Gradient(colors: [Color.purple, Color.pink]),
                    startPoint: .leading,
                    endPoint: .trailing))
                .frame(width: 50, height: 30)
                .overlay(
                    Circle()
                        .fill(Color.white)
                        .frame(width: 24, height: 24)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
                )
                .onTapGesture {
                    configuration.isOn.toggle()
                }
                .padding(2)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.pink, lineWidth: 2)
                )
        }
        .padding()
    }
}

