//
//  SaveLevel.swift
//  The legendary Couple
//
//  Created by Artur on 05.09.2024.
//

import Foundation


class SaveLevel:ObservableObject{
    private let keys = [
        "l1", "l2", "l3", "l4", "l5", "l6", "l7","l8","l9","l10","l11","l12","l13","l14","l15","l16"
    ]
    
    // Опубликованные переменные для обновления UI при изменении значений
    @Published var booleans: [Bool]

    init() {
        // Инициализация значений из UserDefaults
        booleans = keys.map { UserDefaults.standard.bool(forKey: $0) }
    }

    // Сохранение значения булевой переменной
    func save(_ value: Bool, for index: Int) {
        guard index >= 0 && index < booleans.count else { return }
        booleans[index] = value
        UserDefaults.standard.set(value, forKey: keys[index])
    }

    // Извлечение значения булевой переменной
    func retrieve(for index: Int) -> Bool {
        guard index >= 0 && index < booleans.count else { return false }
        return booleans[index]
    }

    // Переключение значения булевой переменной (toggle)
    func toggle(for index: Int) {
        guard index >= 0 && index < booleans.count else { return }
        booleans[index].toggle()
        save(booleans[index], for: index)
    }
}
