//
//  Bullet.swift
//  PaintedMan
//
//  Created by ООО АКИП on 13.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class Bullet: SKSpriteNode {
    
    var type: GameConst.BulletTypes = .NORMAL
    
    init (size: CGSize = GameConst.bulletSize, type: GameConst.BulletTypes = .NORMAL) {
        
        self.type = type
        
        let texture = type.getSKTexture()
        super.init(texture: texture, color: UIColor.clear, size: size)
        
        position = CGPoint(x: 0, y: GameConst.screenHeight/2)
        zPosition = 1.0
        
        setPhysicsBody()
    }
    
    private func setPhysicsBody () {
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = GameConst.PhysicsCategory.Bullet
        physicsBody?.contactTestBitMask = GameConst.PhysicsCategory.Enemy
        physicsBody?.collisionBitMask = GameConst.PhysicsCategory.None
        physicsBody?.usesPreciseCollisionDetection = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func run (touchLocation: CGPoint) {
        
        let offset = touchLocation - position
        if (offset.x < 0) { return }

        let direction = offset.normalized()

        let shootAmount = direction * 1000
        let realDest = shootAmount + position
        
        let actionMove = SKAction.move(to: realDest, duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        run(SKAction.sequence([actionMove, actionMoveDone]))
    }
}
