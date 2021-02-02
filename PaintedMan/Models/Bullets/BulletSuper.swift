//
//  Bullet.swift
//  PaintedMan
//
//  Created by ООО АКИП on 13.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class BulletSuper: Bullet {
    
    init () {
        super.init(size: GameConst.superBulletSize, type: .SUPER)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func run() {
        
        let offset = CGPoint(x: GameConst.screenWidth + 500, y: position.y)
        
        let actionMove = SKAction.move(to: offset, duration: 3.0)
        let actionMoveDone = SKAction.removeFromParent()
        run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
