//
//  GameConst.swift
//  PaintedMan
//
//  Created by ООО АКИП on 13.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation
import SpriteKit

class GameConst {
    
    struct PhysicsCategory {
        static let None      : UInt32 = 0
        static let All       : UInt32 = UInt32.max
        static let Finish    : UInt32 = 0b1
        static let Enemy     : UInt32 = 0b10
        static let Bullet    : UInt32 = 0b11
        static let FieldLine : UInt32 = 0b100
        static let Bonus     : UInt32 = 0b101
    }
    
    enum GameTypes {
        case SURVIVE
        case CATCH
        case PUNCH
        
        func toString() -> String {
            switch self {
            case .SURVIVE:
                return "survive"
            case .CATCH:
                return "catch"
            case .PUNCH:
                return "punch"
            }
        }
    }
    
    enum BulletTypes {
        case NORMAL
        case STRONG
        case SUPER
        case FAST
        
        func getImage() -> UIImage? {
            return UIImage(named: getTextureName())
        }
        
        func getSKTexture() -> SKTexture {
            return SKTexture(imageNamed: getTextureName())
        }
        
        private func getTextureName() -> String {
            switch self {
            case .NORMAL:
                return "bullet"
            case .STRONG:
                return "bullet2"
            case .FAST:
                return "bullet1"
            case .SUPER:
                return "bullet3"
            }
        }
    }
    
    public static var screenWidth: CGFloat = 0
    public static var screenHeight: CGFloat = 0
    
    public static var enemySize: CGSize = CGSize(width: 0, height: 0)
    public static var bossSize: CGSize = CGSize(width: 0, height: 0)
    public static var bulletSize: CGSize = CGSize(width: 0, height: 0)
    public static var superBulletSize: CGSize = CGSize(width: 0, height: 0)
    public static var bonusSize: CGSize = CGSize(width: 0, height: 0)
    public static var gunSize: CGSize = CGSize(width: 0, height: 0)
    
    init(screen: CGSize) {
        GameConst.screenWidth = screen.width
        GameConst.screenHeight = screen.height
        GameConst.enemySize = CGSize(width: GameConst.screenHeight/5, height: GameConst.screenHeight/5)
        GameConst.bulletSize = CGSize(width: GameConst.screenHeight/20, height: GameConst.screenHeight/20)
        GameConst.bossSize = CGSize(width: GameConst.screenHeight/3, height: GameConst.screenHeight/3)
        GameConst.superBulletSize = CGSize(width: GameConst.screenHeight/4, height: GameConst.screenHeight)
        GameConst.bonusSize = CGSize(width: GameConst.screenHeight/15, height: GameConst.screenHeight/15)
        GameConst.gunSize = CGSize(width: ((GameConst.screenHeight * 0.2) * 2.3), height: GameConst.screenHeight * 0.2)
    }
    
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
}
