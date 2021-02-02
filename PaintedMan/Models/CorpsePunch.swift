//
//  CorpsePunch.swift
//  PaintedMan
//
//  Created by ООО АКИП on 21/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class CorpsePunch: SKSpriteNode {
    
    static let mName = "corpse"
    
    init(x: CGFloat, y: CGFloat, texture: SKTexture?) {
        
        let size = CGSize(width: GameConst.screenHeight/7, height: GameConst.screenHeight/7)
        
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        position = CGPoint(x: x, y: y)
        
        self.setScale(0.1)
        zPosition = 0.0
        
        //Animate and remove
        let scaleUpAction = SKAction.scale(to: 1.5, duration: 0.1)
        let waitAction = SKAction.wait(forDuration: 4)
        let scaleActionSequence = SKAction.sequence([scaleUpAction, waitAction, SKAction.removeFromParent()])
        
        run(scaleActionSequence)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
