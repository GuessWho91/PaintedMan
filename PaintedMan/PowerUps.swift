//
//  PowerUpDelegate.swift
//  PaintedMan
//
//  Created by ООО АКИП on 21.07.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import Foundation
import UIKit

enum PowerUps: CaseIterable {
    
    case FastGun
    case PowerGun
    case UltimateGun
    case EnemySlow
    case CatchSize
    case MagazinSize
    case StartLives
    case MaximumLives
    
    func getPrice() -> Int {
        
        if (isMax()) {
            return 0
        }
        
        let currentValue = getValue()
        
        switch self {
            
        case .FastGun:
            return 50
        case .PowerGun:
            return 125
        case .UltimateGun:
            return 200
            
        case .EnemySlow:
            switch currentValue {
            case 0:
                return 55
            case 1:
                return 100
            case 2:
                return 140
            case 3:
                return 210
            case 4:
                return 275
            default:
                return 666
            }
        case .CatchSize:
            switch currentValue {
            case 0:
                return 55
            case 1:
                return 100
            case 2:
                return 140
            case 3:
                return 210
            case 4:
                return 275
            default:
                return 666
            }
        case .MagazinSize:
            switch currentValue {
            case 0:
                return 55
            case 1:
                return 100
            case 2:
                return 140
            case 3:
                return 210
            case 4:
                return 275
            default:
                return 666
            }
            
        case .StartLives:
            switch currentValue {
            case 0:
                return 80
            case 1:
                return 160
            case 2:
                return 320
            default:
                return 666
            }
        case .MaximumLives:
            switch currentValue {
            case 0:
                return 60
            case 1:
                return 120
            case 2:
                return 240
            default:
                return 666
            }
        }
    }
    
    func update() -> Bool {
        
        let price = getPrice()
        let currentMoney = Const.currentMoney
        
        if (price > currentMoney) {
            return false
        }
        
        if (isMax()) {
            return false
        }
        
        var currentValue = getValue()
        currentValue += 1
        saveValue(newValue: currentValue)
        
        Const.currentMoney = currentMoney - price
        
        return true
    }
    
    func getValue() -> Int {
        
        let preferences = UserDefaults.standard
        
        return preferences.object(forKey: self.getPreferenceKey()) as? Int ?? 0
    }
    
    func isMax() -> Bool {
        
        let currentStep = getValue()
        
        switch self {
        case .FastGun:
            return currentStep == 1
        case .PowerGun:
            return currentStep == 1
        case .UltimateGun:
            return currentStep == 1
        case .EnemySlow:
            return currentStep == 5
        case .CatchSize:
            return currentStep == 5
        case .MagazinSize:
            return currentStep == 5
        case .StartLives:
            return currentStep == 3
        case .MaximumLives:
            return currentStep == 3
        }
    }
    
    func getIcon() -> UIImage? {
        
        switch self {
        case .FastGun:
            return UIImage(named: "bullet1")
        case .PowerGun:
            return UIImage(named: "bullet2")
        case .UltimateGun:
            return UIImage(named: "bullet3")
        case .EnemySlow:
            return UIImage(named: "stop")
        case .CatchSize:
            return UIImage(named: "g_catch")
        case .MagazinSize:
            return UIImage(named: "gun")
        case .StartLives:
            return UIImage(named: "live")
        case .MaximumLives:
            return UIImage(named: "bonus_live")
        }
        
    }
    
    func getDescription() -> String {
        
        switch self {
        case .FastGun:
            return "Fast gun type (drop chance)"
        case .PowerGun:
            return "Strong gun type (drop chance)"
        case .UltimateGun:
            return "Ultimate gun type (drop chance)"
        case .MagazinSize:
            return "Bonus bullets count"
        case .EnemySlow:
            return "Slowing the enemy speed"
        case .CatchSize:
            return "Catch weapon size"
        case .StartLives:
            return "Start lives value"
        case .MaximumLives:
            return "Maximum lives value"
        }
        
    }
    
    private func saveValue(newValue: Int) {
        
        let preferences = UserDefaults.standard
        
        preferences.set(newValue, forKey: self.getPreferenceKey())
        preferences.synchronize()
    }
    
    private func getPreferenceKey() -> String {
        
        switch self {
        case .FastGun:
            return "fastgun"
        case .PowerGun:
            return "powergun"
        case .UltimateGun:
            return "ultimategun"
        case .EnemySlow:
            return "enemyslow"
        case .CatchSize:
            return "catchsize"
        case .MagazinSize:
            return "magazinsize"
        case .StartLives:
            return "startlives"
        case .MaximumLives:
            return "maximumlives"
        }
        
    }
    
    static func canBySomething() -> Bool {
        
        for type in PowerUps.allCases {
            let price = type.getPrice()
            if (price != 0 && price < Const.currentMoney) {
                return true
            }
        }
        
        return false
    }
}
