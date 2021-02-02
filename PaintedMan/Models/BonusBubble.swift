//
//  BonusBubble.swift
//  PaintedMan
//
//  Created by ООО АКИП on 23.07.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import SpriteKit

class BonusBubble: SKSpriteNode {

    private let waveInterval: CGFloat = 25
    private var type: BonusDrop
    
    init(x: CGFloat, y: CGFloat, type: BonusDrop) {
        
        self.type = type
        let texture = type.getIcon()
        
        super.init(texture: texture, color: UIColor.clear, size: GameConst.bonusSize)
        
        position = CGPoint(x: x, y: y)
        
        zPosition = 1
        
        setWaveAnimation()
        setPhysicsBody ()
    }
    
    public func getType() -> BonusDrop {
        return type
    }
    
    public func getCongratsString() -> String {
        
        SoundDelegate.playSound(name: "bonus", ext: "mp3")
        
        switch (self.type) {
        case BonusDrop.Live:
            return "+ 1 life"
        case BonusDrop.FastBullet:
            return "Fast bullets. Swipe!"
        case BonusDrop.StrongBullet:
            return "Strong bullets"
        case BonusDrop.Ultimate:
            return "+ Ultimate bullet"
        }
    }
    
    private func setWaveAnimation() {
        
        let upAnimate = SKAction.move(to: CGPoint(x: position.x, y: position.y + waveInterval),
                                       duration: TimeInterval(1))
        let downAnimate = SKAction.move(to: CGPoint(x: position.x, y: position.y - waveInterval),
                                      duration: TimeInterval(1))
        let scaleActionSequence = SKAction.sequence([upAnimate, downAnimate,upAnimate, downAnimate,upAnimate, downAnimate, SKAction.removeFromParent()])
        
        run(scaleActionSequence)
    }
    
    private func setPhysicsBody () {
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = GameConst.PhysicsCategory.Bonus
        physicsBody?.contactTestBitMask = GameConst.PhysicsCategory.Bullet
        physicsBody?.collisionBitMask = GameConst.PhysicsCategory.None
        physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = .Live
        super.init(coder: aDecoder)
    }

}
