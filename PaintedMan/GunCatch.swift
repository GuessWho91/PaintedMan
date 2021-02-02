//
//  GunCatch.swift
//  PaintedMan
//
//  Created by ООО АКИП on 16/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class GunCatch: SKSpriteNode {
    
    var animationSpeed = 0.080
    var runningFrames: [SKTexture] = []
    
    private var isBlack = false
    private var isBlue = false
    
    init () {
        
        var cgSize = GameConst.screenHeight * 0.1
        let multiplierValue = cgSize/5
        cgSize += (multiplierValue * CGFloat(PowerUps.CatchSize.getValue())) //activate power ups
        
        let size = CGSize(width: cgSize, height: cgSize)
        super.init(texture: nil, color: UIColor.clear, size: size)
        
        position = CGPoint(x: GameConst.screenWidth * 0.03, y: GameConst.screenHeight * 0.5)
        zPosition = 2.0
        
        setPhysicalBody()
        
        runningFrames = Const.loadAtlas(name: "guncatch")
        
        run(SKAction.repeatForever(
            SKAction.animate(with: runningFrames,
                             timePerFrame: animationSpeed,
                             resize: false,
                             restore: true)),
            withKey:"running")
    }
    
    private func setPhysicalBody() {
        
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
    
    func move(touchLocation: CGPoint) {
        position = CGPoint(x: GameConst.screenWidth * 0.03, y: touchLocation.y)
    }

    func setBlack() {
        
        if (isBlack || isBlue) {
            return
        }
        
        isBlack = true
        
        runningFrames = Const.loadAtlas(name: "guncatchblack")
        run(SKAction.repeatForever(
        SKAction.animate(with: runningFrames,
                         timePerFrame: animationSpeed,
                         resize: false,
                         restore: true)),
        withKey:"running")
    }
    
    func setBlue() {
        
        if (isBlue) {
            return
        }
        
        isBlue = true
        
        runningFrames = Const.loadAtlas(name: "guncatchblue")
        run(SKAction.repeatForever(
        SKAction.animate(with: runningFrames,
                         timePerFrame: animationSpeed,
                         resize: false,
                         restore: true)),
        withKey:"running")
    }
    
}
