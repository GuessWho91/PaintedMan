//
//  Enemy.swift
//  PaintedMan
//
//  Created by ООО АКИП on 11.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class Enemy: SKSpriteNode {
    
    var score = 5
    var animationSpeed = 0.115
    
    var maxSpeed = CGFloat(7.0) //в секундах до цели
    var minSpeed = CGFloat(4.0)
    
    var runningFrames: [SKTexture] = []
    
    var atlasName = "enemy"
    
    
    init(size: CGSize = GameConst.enemySize, atlasName: String = "enemy", isSingleImage: Bool = false) {
        
        super.init(texture: nil, color: UIColor.clear, size: size)

        maxSpeed -= CGFloat(GameScene.worldSpeedBoost - PowerUps.EnemySlow.getValue())
        
        zPosition = 1.0
        self.atlasName = atlasName
        
        if (isSingleImage) {
            runningFrames = []
            runningFrames.append(SKTexture(imageNamed: atlasName))
        } else {
            runningFrames = Const.loadAtlas(name: atlasName)
        }
        
        setPosition()
        setPhysicBody()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setPosition() {
        let actualY = GameConst.random(min: GameConst.screenHeight/4, max: GameConst.screenHeight - size.height/2)
        position = CGPoint(x: GameConst.screenWidth + size.width/2, y: actualY)
        zPosition = 1.0
    }
    
    private func setPhysicBody() {
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.categoryBitMask = GameConst.PhysicsCategory.Enemy
        physicsBody?.contactTestBitMask = GameConst.PhysicsCategory.Bullet | GameConst.PhysicsCategory.Finish
        physicsBody?.collisionBitMask = GameConst.PhysicsCategory.None
        
    }
    
    func run() {
        
        let speed = GameConst.random(min: minSpeed, max: maxSpeed)
        let actionMove = SKAction.move(to: CGPoint(x: -size.width/2, y: position.y), duration: TimeInterval(speed))
        
        run(actionMove)
        
        run(SKAction.repeatForever(
            SKAction.animate(with: runningFrames,
                             timePerFrame: animationSpeed,
                             resize: false,
                             restore: true)),
                 withKey:"running")
    }
    
    func die(_ mode: GameConst.GameTypes = .SURVIVE) {
        
        let texture: SKTexture = getDieTexture(mode)
        parent?.addChild(Corpse(x: position.x, y: position.y, texture: texture))
        
        dropBonus(mode)
        
        removeFromParent()
    }
    
    func dropBonus(_ mode: GameConst.GameTypes) {
        
        let isDrop = Int.random(in: 0...13)
        if (isDrop == 1) { //Бонусу быть, выберем какой
            
            let bonuses = BonusDrop.getList(mode: mode)
            guard let randomBonus = bonuses.randomElement() else {
                return
            }
            
            parent?.addChild(BonusBubble(x: position.x, y: position.y, type: randomBonus))
        }
    }
    
    func getDieTexture(_ mode: GameConst.GameTypes = .SURVIVE) -> SKTexture {
        
        var texture = SKTexture(imageNamed: "spray1")
        
        switch mode {
        case .SURVIVE:
            texture = SKTexture(imageNamed: "spray1")
        case .CATCH:
            let images = ["spray1", "spray2", "spray3", "spray4"]
            texture = SKTexture(imageNamed: images.randomElement()!)
        case .PUNCH:
            texture = SKTexture(imageNamed: "split_black")
        }
        
        return texture
    }
    
}
