//
//  Boss.swift
//  PaintedMan
//
//  Created by ООО АКИП on 17/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class Boss: EnemySimple {
    
    var lives = 5
    
    let bossMain: SKTexture
    let bossShooted: SKTexture
    
    init(atlasName: String = "boss1", lives: Int = 20) {
        
        bossMain = SKTexture(imageNamed: atlasName)
        bossShooted = SKTexture(imageNamed: "\(atlasName)d")
        
        super.init(size: GameConst.bossSize, atlasName: atlasName, isSingleImage: true)
        
        self.lives = lives
        
        score = lives * 2
        
        maxSpeed = 30
        minSpeed = 27
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        let atlasName = "boss1"
        
        bossMain = SKTexture(imageNamed: atlasName)
        bossShooted = SKTexture(imageNamed: "\(atlasName)d")
        
        super.init(coder: aDecoder)
    }
    
    override func die(_ mode: GameConst.GameTypes = .SURVIVE) {
        
        lives -= 1
        
        let actionShooted = SKAction.setTexture(bossMain)
        let actionReturn = SKAction.setTexture(bossShooted)
        let waitAction = SKAction.wait(forDuration: 0.1)
        let scaleActionSequence = SKAction.sequence([actionShooted, waitAction, actionReturn])
        
        run(scaleActionSequence)
        
        if (lives <= 0) {
            removeFromParent()
        }
    }
    
}
