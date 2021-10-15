//
//  Settings.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 15.10.2021.
//

import Foundation

enum keysUserDefaults {
    static let settingsGame = "settingsGame"
}

struct settingsGame: Codable {
    var timerState: Bool
    var timeForGame: Int
}

class Settings {
    //так как static, то экземпляр Settings не будет уничтожен пока программа работает, singleton
    static var shared = Settings()
    
    private let defaultSettings = settingsGame(timerState: true, timeForGame: 30)
    var currentSettings: settingsGame {
        get {
            if let data = UserDefaults.standard.object(forKey: keysUserDefaults.settingsGame) as? Data {
                return try! PropertyListDecoder().decode(settingsGame.self, from: data)
            }else {
                if let data = try? PropertyListEncoder().encode(defaultSettings) {
                    UserDefaults.standard.setValue(data, forKey: keysUserDefaults.settingsGame)
                }
                return defaultSettings
            }
        }
        set {
//            do {
//                let data = try PropertyListEncoder().encode(newValue)
//            }catch {
//                print(error)
//            }
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.setValue(data, forKey: keysUserDefaults.settingsGame)
            }
        }
    }
    
    func resetSettings() {
        currentSettings = defaultSettings
    }
    
}
