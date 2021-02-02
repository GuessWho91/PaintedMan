//
//  BonusDrop.swift
//  PaintedMan
//
//  Created by ООО АКИП on 22.07.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import SpriteKit

enum BonusDrop {
    
    case Live
    case FastBullet
    case StrongBullet
    case Ultimate
    
    func getIcon() -> SKTexture {
        
        switch self {
        case .Live:
            return SKTexture(imageNamed: "bonus_live")
        case .FastBullet:
            return SKTexture(imageNamed: "bonus_fast")
        case .StrongBullet:
            return SKTexture(imageNamed: "bonus_strong")
        case .Ultimate:
            return SKTexture(imageNamed: "bonus_ultimate")
        }
        
    }
    
    
    static func getList(mode: GameConst.GameTypes) -> [BonusDrop] {
        
        var array: [BonusDrop] = []
        
        array.append(.Live)
        
        switch mode {
        case .CATCH:
            return []
        case .SURVIVE:
            if (PowerUps.UltimateGun.getValue() == 1) {
                array.append(.Ultimate)
            }
            if (PowerUps.FastGun.getValue() == 1) {
                array.append(.FastBullet)
            }
            if (PowerUps.PowerGun.getValue() == 1) {
                array.append(.StrongBullet)
            }
        case .PUNCH:
            if (PowerUps.UltimateGun.getValue() == 1) {
                array.append(.Ultimate)
            }
        }
        
        return array
    }
    
}
