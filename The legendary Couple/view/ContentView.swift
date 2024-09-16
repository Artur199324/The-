import SwiftUI
import WebKit
import AVFoundation

struct ContentView: View {
    @EnvironmentObject var saveModel: SaveModel
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var isWebViewHidden = true
    @State private var showButtons: Bool? = nil
    @State private var isLoading = true
    @State private var progress: Double = 0.0
    @State private var webView: WKWebView? = nil
    
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
        ZStack {
            // WebView на весь экран
            if !isWebViewHidden {
                if let url = URL(string: saveModel.configString) {
                    Wevb(
                        url: url,
                        onPageStarted: { url in
                           
                        },
                        onPageFinished: { url in
                           
                            if let urlString = url?.absoluteString, urlString.contains("celestialcirdscuit") {
                                showButtons = true
                                isWebViewHidden = true
                            } else {
                                showButtons = false
                                isWebViewHidden = false
                            }
                            isLoading = false
                        },
                        onProgressChanged: { progress in
                            self.progress = progress
                            if progress == 1.0 {
                                isLoading = false
                            }
                        },
                        webView: $webView
                    )
                    .ignoresSafeArea() // WebView перекрывает весь экран
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width > 100 && (webView?.canGoBack ?? false) {
                                    webView?.goBack()
                                }
                            }
                    )
                } else {
                    Text("Некорректный URL")
                        .foregroundColor(.red)
                }
            }
            
            // Прогресс-бар поверх WebView
            if isLoading {
                ZStack {
                    Color.black.opacity(0.5)
                        .ignoresSafeArea()
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(10)
                }
            }
            
            if showButtons == true {
                buttonContent // Контент с кнопками
            }
        }
        .onAppear {
            handleNewUser()
        }
        .onReceive(saveModel.$configBool) { _ in
            handleNewUser()
        }
        .onReceive(saveModel.$configString) { newValue in
            if saveModel.configBool == true {
                if !newValue.isEmpty {
                    if let url = URL(string: newValue) {
                        if let webView = webView {
                            webView.load(URLRequest(url: url))
                        } else {
                            webView = WKWebView()
                            webView?.load(URLRequest(url: url))
                        }
                        isWebViewHidden = false
                        isLoading = true
                    } else {
                        print("Некорректный URL: \(newValue)")
                    }
                } else {
                    isWebViewHidden = true
                    isLoading = true
                }
            } else if saveModel.configBool == false {
                isWebViewHidden = true
                isLoading = false
                showButtons = true
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Image("launch").ignoresSafeArea())
        .fullScreenCover(isPresented: $isRule, content: {
            RulesView()
        })
        .fullScreenCover(isPresented: $isGame, content: {
            LevelsView().environmentObject(savePoints)
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
            handleMusicPlayback()
        }
        .onChange(of: isOn) { _, newValue in
            handleMusicPlayback()
        }
    }
    
    private func handleNewUser() {
        if let newUser = saveModel.configBool {
            if newUser {
                isWebViewHidden = false
                isLoading = true
                showButtons = false

                if !saveModel.configString.isEmpty {
                    if let url = URL(string: saveModel.configString) {
                        if let webView = webView {
                            webView.load(URLRequest(url: url))
                        } else {
                            webView = WKWebView()
                            webView?.load(URLRequest(url: url))
                        }
                    }
                }
            } else {
                isWebViewHidden = true
                isLoading = false
                showButtons = true
            }
        } else {
            isWebViewHidden = true
            isLoading = true
            showButtons = false
        }
    }
    
    private func handleMusicPlayback() {
        if isOn {
            playMusic()
        } else {
            stopMusic()
        }
    }
    
    private var buttonContent: some View {
        VStack {
            HStack {
                ZStack {
                    Image("Frame 3")
                    Text("\(point)")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.leading, 20)
                }
                .padding(.leading, 30)
                .padding(.top, 300)
                
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    showShope.toggle()
                }) {
                    Image("Frame 2")
                }
                .padding(.trailing, 30)
                
                Button(action: {
                    checkButtonTap()
                }) {
                    Image("Group 5")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Notification"), message: Text("This feature is available once a day."), dismissButton: .default(Text("OK")))
                }
                
                Button(action: {
                    isSettings.toggle()
                }) {
                    Image("Frame 1")
                }
                .padding(.leading, 30)
            }
            .padding()
            
            Button(action: {
                isGame.toggle()
            }) {
                Image("Frame 22")
            }
            
            Button(action: {
                isRule.toggle()
            }) {
                Image("Frame 11")
            }
            .padding(20)
        }
    }
    
    private func checkButtonTap() {
        let currentDate = Date()
        let calendar = Calendar.current
        
        if let lastTapDate = lastButtonTapDate {
            if let difference = calendar.dateComponents([.day], from: lastTapDate, to: currentDate).day, difference >= 1 {
                proceedToFullScreen()
            } else {
                showAlert.toggle()
            }
        } else {
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
                audioPlayer?.numberOfLoops = -1
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
    ContentView().environmentObject(SaveModel())
}
