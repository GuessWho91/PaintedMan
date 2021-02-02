//
//  EnemyFast.swift
//  PaintedMan
//
//  Created by ООО АКИП on 21/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class EnemyFast: Enemy {
    
    var lives = 2
    var direction = 0
    
    init() {
        super.init(size: GameConst.enemySize, atlasName: "enemyblue")
        score = 7
        direction = Int.random(in: -500...500)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func changeDirection() {
        
        direction = -(direction)
        maxSpeed -= 1
        minSpeed -= 0.5
        run()
    }
    
    override func getDieTexture(_ mode: GameConst.GameTypes = .SURVIVE) -> SKTexture {
        
        var texture = SKTexture(imageNamed: "spray_blue")
        
        switch mode {
        case .SURVIVE:
            texture = SKTexture(imageNamed: "spray_blue")
        case .CATCH:
            let images = ["spray_blue"]
            texture = SKTexture(imageNamed: images.randomElement()!)
        case .PUNCH:
            texture = SKTexture(imageNamed: "split_blue")
        }
        
        return texture
    }
    
    override func run() {
        
        let speed = GameConst.random(min: minSpeed, max: maxSpeed)
        let actionMove = SKAction.move(to: CGPoint(x: -size.width/2, y: position.y - CGFloat(direction)), duration: TimeInterval(speed))
        
        run(actionMove)
        
        run(SKAction.repeatForever(
            SKAction.animate(with: runningFrames,
                             timePerFrame: animationSpeed,
                             resize: false,
                             restore: true)),
            withKey:"running")
    }
    
}
