import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var isRule = false
    @State private var isGame = false
    @State private var isSettings = false
    @State private var lastButtonTapDate: Date? = UserDefaults.standard.object(forKey: "lastButtonTapDate") as? Date
    @State private var showBonys = false
    @State private var showAlert = false
    @State private var showShope = false
    @StateObject private var savePoints = SavePoints()
    @State private var point = SavePoints().value
    @AppStorage("toggleState") private var isOn = false
    
    var body: some View {
        VStack {
            HStack{
                ZStack{
                    Image("Frame 3")
                    Text("\(point)")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.leading,20)
                
                }.padding(.leading,30)
                 .padding(.top,300)
                Spacer()
            }
            
            Spacer()
            HStack{
                Button(action: {
                    showShope.toggle()
                }, label: {
                    Image("Frame 2")
                }).padding(.trailing,30)
                
                Button(action: {
                    checkButtonTap()
                }, label: {
                    Image("Group 5")
                }).alert(isPresented: $showAlert) {
                    Alert(title: Text("Notification"), message: Text("You can only access this once per day."), dismissButton: .default(Text("OK")))}
                
                Button(action: {
                    isSettings.toggle()
                }, label: {
                    Image("Frame 1")
                }).padding(.leading,30)
            }.padding()
            
            Button(action: {
                isGame.toggle()
            }, label: {
                Image("Frame 22")
            })
            
            Button(action: {
                isRule.toggle()
            }, label: {
                Image("Frame 11")
            }).padding(20)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("launch")
            .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $isRule, content: {
            RulesView()
        })
        
        .fullScreenCover(isPresented: $isGame, content: {
            LevelsView()
                .environmentObject(savePoints)
        })
        
        .fullScreenCover(isPresented: $showBonys, content: {

            DailyBonusView()
        })
        .fullScreenCover(isPresented: $showShope, content: {
            ShopView()
        })
        .fullScreenCover(isPresented: $isSettings, content: {
            SettingsView()
        })
        .onAppear {
            if isOn {
                playMusic()
            } else {
                stopMusic()
            }
        }
        .onChange(of: isOn) { _,newValue in
            if newValue {
                playMusic()
            } else {
                stopMusic()
            }
        }
    }
    
    private func checkButtonTap() {
          let currentDate = Date()
          let calendar = Calendar.current

          if let lastTapDate = lastButtonTapDate {
              // Check if more than 24 hours have passed since the last tap
              if let difference = calendar.dateComponents([.day], from: lastTapDate, to: currentDate).day, difference >= 1 {
                  proceedToFullScreen()
              } else {
                  // Less than a day has passed
                  showAlert.toggle()
              }
          } else {
              // First time tap
              proceedToFullScreen()
          }
      }
      
      private func proceedToFullScreen() {
          lastButtonTapDate = Date()
          UserDefaults.standard.set(lastButtonTapDate, forKey: "lastButtonTapDate")
          showBonys.toggle()
      }
    
    func playMusic() {
        if let path = Bundle.main.path(forResource: "music", ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1 // Зацикливание музыки
                audioPlayer?.play()
            } catch {
                print("Ошибка воспроизведения музыки: \(error.localizedDescription)")
            }
        } else {
            print("Файл музыки не найден")
        }
    }
      
    func stopMusic() {
        audioPlayer?.stop()
    }
}

#Preview {
    ContentView()
}
