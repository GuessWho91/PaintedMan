//
//  LevelDelegate.swift
//  PaintedMan
//
//  Created by ООО АКИП on 17/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation

class LevelDelegate {
    
    private let level: Int
    
    init(_ level: Int) {
        self.level = level
    }
    
    func getLevelMode() -> GameConst.GameTypes {
        
        switch level {
        case 3,7,11,14,17,21,24,28:
            return .CATCH
        case 2,4,6,9,13,16,19,22,26,29:
            return .PUNCH
        default:
            return .SURVIVE
        }
    }
    
    func getLevelTime() -> Int {
        
        if (level > 25) {
            return 150
        } else if (level > 20) {
            return 120
        } else if (level > 10) {
            return 90
        } else if (level > 5) {
            return 60
        } else if (level == 0) {
            return 666666
        } else {
            return 30
        }
        
    }
    
    func getLevelMoney() -> Int {
        
        if (level < 5) {
            return 0
        } else if (level == 5) {
            return 50
        } else if (level == 10) {
            return 75
        } else if (level == 15) {
            return 100
        } else if (level == 20) {
            return 150
        } else if (level == 25) {
            return 200
        } else if (level == 30) {
            return 500
        } else if (level > 20) {
            return 30
        } else if (level > 10) {
            return 20
        } else if (level > 5) {
            return 10
        } else {
            return 10
        }
        
    }
    
}
