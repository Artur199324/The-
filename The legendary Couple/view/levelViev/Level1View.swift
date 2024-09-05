import SwiftUI

struct Level1View: View {
    @StateObject private var saveBac = SaveBac()
    @EnvironmentObject var savePoints: SavePoints
    @Environment(\.dismiss) var dismiss

    @State private var buttonStates: [Bool] = Array(repeating: false, count: 8)
    @State private var revealedIndices: [Int] = []
    @State private var matchedPairs: Set<Int> = []
    @State private var attempts: Int = 0
    @State private var showAllImages = true
    @State private var showWinOverlay = false
    @State private var showOwerOverlay = false 
    @State private var timeRemaining = 45
    @State private var timerRunning = false
    @State private var timer: Timer?
    private var images: [String] = ["el_01", "el_01", "el_02", "el_02", "el_03", "el_03", "el_04", "el_04"].shuffled()

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
                                         Text("Level 1")
                                             .font(.system(size: 30, weight: .bold)) // Настройте размер шрифта
                                             .foregroundColor(.blue)
                                             .offset(x: 2, y: 2) // Настройка позиции для обводки

                                         // Основной текст (белый)
                                         Text("Level 1")
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

                // Первая кнопка сверху
                Button(action: {
                    handleButtonTap(at: 0)
                }, label: {
                    Image(showAllImages || buttonStates[0] || matchedPairs.contains(0) ? images[0] : "cart")
                })
                .padding(.top, 100)
                .disabled(showAllImages || buttonStates[0] || matchedPairs.contains(0))

                // Первая строка кнопок
                HStack {
                    ForEach(1..<4) { index in
                        Button(action: {
                            handleButtonTap(at: index)
                        }, label: {
                            Image(showAllImages || buttonStates[index] || matchedPairs.contains(index) ? images[index] : "cart")
                        })
                        .disabled(showAllImages || buttonStates[index] || matchedPairs.contains(index))
                    }
                }

                // Вторая строка кнопок
                HStack {
                    ForEach(4..<7) { index in
                        Button(action: {
                            handleButtonTap(at: index)
                        }, label: {
                            Image(showAllImages || buttonStates[index] || matchedPairs.contains(index) ? images[index] : "cart")
                        })
                        .disabled(showAllImages || buttonStates[index] || matchedPairs.contains(index))
                    }
                }

                // Нижняя кнопка
                Button(action: {
                    handleButtonTap(at: 7)
                }, label: {
                    Image(showAllImages || buttonStates[7] || matchedPairs.contains(7) ? images[7] : "cart")
                })
                .disabled(showAllImages || buttonStates[7] || matchedPairs.contains(7))

                Spacer()
            }
        }
        .overlay(
            VStack {
                if showWinOverlay {
                    ZStack {
                        Color.black.opacity(0.5).ignoresSafeArea()
                        Image("win").padding(.bottom,400)
                        Button(action: {
                            stopTimer()
                            savePoints.saveValue(200)
                            self.dismiss()
                        }, label: {
                            Image("home").padding(.top,300)
                        })
                    }
                    .transition(.opacity)
                }
                
                if showOwerOverlay{
                    ZStack {
                        Color.black.opacity(0.5).ignoresSafeArea()
                        Image("lol").padding(.bottom,100)
                        Button(action: {
                            stopTimer()
                            self.dismiss()
                        }, label: {
                            Image("home").padding(.top,300)
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
            showWinOverlay.toggle() // Показываем оверлей при выигрыше
        } else if attempts >= 3 {
            showOwerOverlay.toggle()
        }
    }
    
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
    Level1View()
}
