//
//  AppSettings.swift
//  The legendary Couple
//
//  Created by Artur on 06.09.2024.
//

import Foundation

class AppSettings: ObservableObject {
    @Published var isOn: Bool {
        didSet {
            UserDefaults.standard.set(isOn, forKey: "toggleState")
        }
    }
    
    init() {
        self.isOn = UserDefaults.standard.bool(forKey: "toggleState")
        
    }
}
