//
//  EnemyStrong.swift
//  PaintedMan
//
//  Created by ООО АКИП on 21/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import SpriteKit

class EnemyStrong: Enemy {
    
    var lives = 2
    
    init() {
        super.init(size: GameConst.enemySize, atlasName: "enemyred")
        score = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func die(_ mode: GameConst.GameTypes = .SURVIVE) {
        lives -= 1
        
        if (lives <= 0) {
            super.die(mode)
        } else {
            
            runningFrames = Const.loadAtlas(name: "enemyreddamaged")
            
        }
    }
    
}
