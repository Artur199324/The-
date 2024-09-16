//
//  SaveModel.swift
//  The legendary Couple
//
//  Created by Artur on 18.09.2024.
//

import Foundation

class SaveModel:ObservableObject{
    @Published var configString: String = ""
    @Published var configBool: Bool? = nil
}
