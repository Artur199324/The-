import Foundation
import SwiftUI
import UIKit
import OneSignalFramework
import AppsFlyerLib
import AppTrackingTransparency
import UserNotifications
import AdSupport
import Firebase // Импорт Firebase
import FirebaseRemoteConfig // Импорт RemoteConfig для получения данных

class AppDelegate: UIResponder, UIApplicationDelegate, AppsFlyerLibDelegate {
    
    var idfa: String = "null"
    var gclid: String = "null"
    var campaign: String = "null"
    var appsFlyerID: String = "null"
    let key = "configBool"
    var count = 0
    // Remote Config значения
    var remoteConfigStringValue: String = "null"
    var remoteConfigBoolValue: Bool = false
    let saveModel = SaveModel()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Инициализация Firebase
        
      
        FirebaseApp.configure()
        initializeRemoteConfig()
        // Инициализация OneSignal
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        OneSignal.initialize("dcf134e0-1928-4947-8bf9-9ebcd1faddfe", withLaunchOptions: launchOptions)

        // Подписка на уведомление, когда приложение становится активным
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActiveNotification),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        
        // Проверяем разрешения на уведомления
        requestNotificationPermission()
        
       

        return true
    }

    // Метод, который будет вызван, когда приложение становится активным
    @objc func didBecomeActiveNotification() {
        // Проверка текущего статуса разрешения на отслеживание
        checkTrackingAuthorizationStatusAndHandleFacebookAndIDFA()
    }
    
    // Проверка статуса разрешения на отслеживание и обработка IDFA
    private func checkTrackingAuthorizationStatusAndHandleFacebookAndIDFA() {
        if #available(iOS 14, *) {
            let status = ATTrackingManager.trackingAuthorizationStatus
            switch status {
            case .authorized:
                idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                initializeAppsFlyer()
            case .denied, .restricted:
                print("ATT статус: запрещено или ограничено")
             count += 1
            
                if count == 2{
                    saveBoolToUserDefaults(value: true, key: key)
                    ggoo()
                }
            case .notDetermined:
                print("ATT статус: не определён")
                requestTrackingAuthorization()
            @unknown default:
                fatalError("Неверный статус авторизации.")
            }
        } else {
            idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
            initializeAppsFlyer()
        }
    }
    
    // Запрос разрешения на отслеживание для iOS 14 и выше
    private func requestTrackingAuthorization() {
        ATTrackingManager.requestTrackingAuthorization { [self] status in
            switch status {
            case .authorized:
                print("ATT статус после запроса: авторизовано")
                idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                initializeAppsFlyer()
            case .denied, .restricted:
                print("ATT статус после запроса: запрещено или ограничено")
                count += 1
            
            case .notDetermined:
                print("ATT статус после запроса: не определён")
                count += 1
                 
            @unknown default:
                fatalError("Неверный статус авторизации.")
                
            }
        }
    }
    
    // Запрос разрешения на уведомления
    private func requestNotificationPermission() {
        if !UserDefaults.standard.bool(forKey: "notificationPermissionRequested") {
            OneSignal.Notifications.requestPermission({ accepted in
                print("User accepted notifications: \(accepted)")
                UserDefaults.standard.set(true, forKey: "notificationPermissionRequested")
            }, fallbackToSettings: true)
        }
    }
    
    // Инициализация AppsFlyer
    private func initializeAppsFlyer() {
        print("🔵 Initializing AppsFlyer")
        AppsFlyerLib.shared().appsFlyerDevKey = "6XEatpnKUg4Z8YbqH2LFsE"
        AppsFlyerLib.shared().appleAppID = "6670786489"
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = true
    
        AppsFlyerLib.shared().start()
        appsFlyerID = AppsFlyerLib.shared().getAppsFlyerUID()
    }
    
    // MARK: - Firebase Remote Config
    
    private func initializeRemoteConfig() {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { status, error in
            if error != nil {
              
                self.saveModel.configBool = false
                return
            }
            
            self.remoteConfigStringValue = remoteConfig["ReklAD"].stringValue
 
            self.remoteConfigBoolValue = remoteConfig["PlayerNew"].boolValue
           
            self.saveModel.configBool = self.remoteConfigBoolValue
            
            if self.getBoolFromUserDefaults(key: self.key) {
                self.ggoo()
            }
        
        }
    }
    
    // MARK: - AppsFlyerLibDelegate
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
       
        
        // Получаем статус атрибуции
        if let status = conversionInfo["af_status"] as? String {
            print("Статус атрибуции: \(status)")
        } else {
            print("Статус атрибуции отсутствует")
        }
        
        // Извлечение gclid (Google Click ID)
        if let gclidValue = conversionInfo["gclid"] as? String {
            gclid = gclidValue
      
        } else {
            gclid = "null"
        }

        // Извлечение информации о кампании
        if let campaignValue = conversionInfo["campaign"] as? String {
            campaign = campaignValue
         
        } else {
            campaign = "null"
        }
        ggoo()
    }
    
    func onConversionDataFail(_ error: Error) {
        print("🔴 AppsFlyer Conversion Data Fail: \(error.localizedDescription)")
        ggoo()
    }
    
    
    func ggoo(){
        print("goo")
        let ss = "\(remoteConfigStringValue)?gclid=\(gclid)&appsflyer_id=\(appsFlyerID)&gadid=\(idfa)&campaign=\(campaign)"
        self.saveModel.configString = ss
     
    }
    
    func saveBoolToUserDefaults(value: Bool, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getBoolFromUserDefaults(key: String) -> Bool {
        // Проверяем, есть ли значение в UserDefaults, если нет, возвращаем false
        if UserDefaults.standard.object(forKey: key) == nil {
            return false
        } else {
            return UserDefaults.standard.bool(forKey: key)
        }
    }
}

