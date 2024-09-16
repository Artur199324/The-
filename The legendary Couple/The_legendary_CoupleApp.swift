//
//  The_legendary_CoupleApp.swift
//  The legendary Couple
//
//  Created by Artur on 05.09.2024.
//

import SwiftUI
@main
struct The_legendary_CoupleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appDelegate.saveModel)
        }
    }
}
