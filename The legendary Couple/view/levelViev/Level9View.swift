import SwiftUI

struct Level9View: View {
    @StateObject private var saveBac = SaveBac()
    @EnvironmentObject var savePoints: SavePoints
    @Environment(\.dismiss) var dismiss

    @State private var buttonStates: [Bool] = Array(repeating: false, count: 26) // Изменено на 26 для 26 кнопок
    @State private var revealedIndices: [Int] = []
    @State private var matchedPairs: Set<Int> = []
    @State private var attempts: Int = 0
    @State private var showAllImages = true
    @State private var showWinOverlay = false
    @State private var showOwerOverlay = false

    private var images: [String] = ["el_01", "el_01", "el_02", "el_02", "el_03", "el_03", "el_04", "el_04", "el_05", "el_05", "el_06", "el_06", "el_07", "el_07", "el_08", "el_08", "el_09", "el_09", "el_10", "el_10", "el_11", "el_11", "el_12", "el_12", "el_13", "el_13"].shuffled() // Изменено на 26 элементов
    
    @State private var timeRemaining = 45
    @State private var timerRunning = false
    @State private var timer: Timer?
    
    var body: some View {
        ZStack {
            BackView(number: saveBac.value)
            VStack {
                // Верхняя панель
                HStack {
                    Button(action: {
                        self.dismiss()
                    }, label: {
                        Image("Frame 4")
                    })
                    ZStack {
                        // Тень (синий контур) текста
                        Text("Level 9")
                            .font(.system(size: 30, weight: .bold)) // Настройте размер шрифта
                            .foregroundColor(.blue)
                            .offset(x: 2, y: 2) // Настройка позиции для обводки

                        // Основной текст (белый)
                        Text("Level 9")
                            .font(.system(size: 30, weight: .bold)) // Тот же размер шрифта
                            .foregroundColor(.white)
                    }
                    .padding(.leading, 20)
                    Spacer()
                    ZStack {
                        Image("time")
                        Text("\(timeRemaining)")
                            .foregroundColor(.white)
                            .font(.title2.bold())
                            .padding(.leading, 15)
                    }
                    .padding(.trailing, 20)
                }
                .padding(.leading, 30)
                .padding(.top, 60)

                // Один ряд сверху с тремя кнопками
              

                // Размещение кнопок
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Spacer()
                        gameButton(at: 0)
                        Spacer()
                        gameButton(at: 1)
                        Spacer()
                        gameButton(at: 2)
                        Spacer()
                    }
                    // Первая строка с 5 кнопками
                    HStack(spacing: 10) {
                        gameButton(at: 3)
                        gameButton(at: 4)
                        gameButton(at: 5)
                        gameButton(at: 6)
                        gameButton(at: 7)
                    }

                    // Вторая строка с 5 кнопками
                    HStack(spacing: 10) {
                        gameButton(at: 8)
                        gameButton(at: 9)
                        gameButton(at: 10)
                        gameButton(at: 11)
                        gameButton(at: 12)
                    }

                    // Третья строка с 5 кнопками
                    HStack(spacing: 10) {
                        gameButton(at: 13)
                        gameButton(at: 14)
                        gameButton(at: 15)
                        gameButton(at: 16)
                        gameButton(at: 17)
                    }

                    // Четвертая строка с 5 кнопками
                    HStack(spacing: 10) {
                        gameButton(at: 18)
                        gameButton(at: 19)
                        gameButton(at: 20)
                        gameButton(at: 21)
                        gameButton(at: 22)
                    }
                }
                .padding(.top, 10)

                // Один ряд снизу с тремя кнопками
                HStack(spacing: 10) {
                    Spacer()
                    gameButton(at: 23)
                    Spacer()
                    gameButton(at: 24)
                    Spacer()
                    gameButton(at: 25)
                    Spacer()
                }

                Spacer()
            }
        }
        .overlay(
            VStack {
                if showWinOverlay {
                    ZStack {
                        Color.black.opacity(0.5).ignoresSafeArea()
                        Image("win").padding(.bottom, 400)
                        Button(action: {
                            stopTimer()
                            savePoints.saveValue(900)
                            self.dismiss()
                        }, label: {
                            Image("home").padding(.top, 300)
                        })
                    }
                    .transition(.opacity)
                }
                
                if showOwerOverlay {
                    ZStack {
                        Color.black.opacity(0.5).ignoresSafeArea()
                        Image("lol").padding(.bottom, 100)
                        Button(action: {
                            stopTimer()
                            self.dismiss()
                        }, label: {
                            Image("home").padding(.top, 300)
                        })
                    }
                    .transition(.opacity)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .zIndex(1) // На передний план
        )
        .onAppear {
            // Показываем все изображения на 3 секунды
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showAllImages = false
                startTimer()
            }
        }
    }

    // Обработка нажатия кнопки
    private func handleButtonTap(at index: Int) {
        // Открываем выбранную кнопку
        buttonStates[index] = true
        revealedIndices.append(index)

        // Проверка на совпадение
        if revealedIndices.count == 2 {
            let firstIndex = revealedIndices[0]
            let secondIndex = revealedIndices[1]

            if images[firstIndex] == images[secondIndex] {
                // Найдена пара
                matchedPairs.insert(firstIndex)
                matchedPairs.insert(secondIndex)
            } else {
                // Ошибка — закрываем обе кнопки после небольшой задержки
                attempts += 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    buttonStates[firstIndex] = false
                    buttonStates[secondIndex] = false
                }
            }
            // Очищаем массив с открытыми индексами
            revealedIndices.removeAll()
        }

        // Проверка на завершение игры
        if matchedPairs.count == images.count {
            showWinOverlay = true
        } else if attempts >= 4 {
            showOwerOverlay = true
        }
    }

    // Функция создания кнопки
    private func gameButton(at index: Int) -> some View {
        Button(action: {
            handleButtonTap(at: index)
        }, label: {
            Image(showAllImages || buttonStates[index] || matchedPairs.contains(index) ? images[index] : "cart")
                .resizable()
                .frame(width: 60, height: 60)
        })
        .disabled(showAllImages || buttonStates[index] || matchedPairs.contains(index))
    }
    
    // Функция для старта таймера
    func startTimer() {
        guard !timerRunning else { return } // Проверяем, что таймер не запущен
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1 // Уменьшаем время на 1 каждую секунду
            } else {
                timer.invalidate() // Останавливаем таймер
                showOwerOverlay.toggle()
                timerRunning = false
            }
        }
    }

    // Функция для остановки таймера
    func stopTimer() {
        timer?.invalidate() // Останавливаем таймер
        timer = nil // Обнуляем ссылку на таймер
        timerRunning = false
    }
}

#Preview {
    Level9View()
}
