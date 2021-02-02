//
//  Gun.swift
//  PaintedMan
//
//  Created by ООО АКИП on 13.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class Gun: SKSpriteNode {
    
    static let mName = "gun"
    let gunMain: SKTexture
    let gunShooted: SKTexture
    
    init () {
        
        gunMain = SKTexture(imageNamed: "gun")
        gunShooted = SKTexture(imageNamed: "gun_shoot")
        
        let texture = gunMain

        super.init(texture: texture, color: UIColor.clear, size: GameConst.gunSize)
        
        position = CGPoint(x: GameConst.screenWidth * 0.01, y: GameConst.screenHeight * 0.5 + 15)
        zPosition = 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shoot(touchLocation: CGPoint) {
        
        //Rotate hand
        var angle = atan2(touchLocation.y - position.y, touchLocation.x - position.x)
        if (angle < -0.6) {
            angle = -0.6
        }
        
        zRotation = angle
        
        let actionShoot = SKAction.setTexture(gunShooted)
        let actionReturn = SKAction.setTexture(gunMain)
        let waitAction = SKAction.wait(forDuration: 0.2)
        let scaleActionSequence = SKAction.sequence([actionShoot, waitAction, actionReturn])
        
        run(scaleActionSequence)
    }
    
}
