//
//  GameSceneCatch.swift
//  PaintedMan
//
//  Created by ООО АКИП on 16/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation
import SpriteKit

class GameSceneCatch: GameScene {
    
    private lazy var player = GunCatch()
    
    override func onDidMove() {
        
        addChild(player)
        viewController?.btnGun.isHidden = true
        viewController?.btnSuperGun.isHidden = true
        
        enemyGenerator = EnemyGenerator(level: level, mode: .CATCH)
        
        allowMove = true
    }
    
    override func checkContact(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {
        
        //Попали во врага
        if ((firstBody.categoryBitMask == GameConst.PhysicsCategory.Enemy) &&
            (secondBody.categoryBitMask == GameConst.PhysicsCategory.Bullet)) {
            if let monster = firstBody.node as? Enemy {
                monsterCatched(enemy: monster)
            }
        }
        
    }
    
    override func onTouched(_ touchLocation: CGPoint) {
        player.move(touchLocation: touchLocation)
    }
    
    //Попали во врага
    private func monsterCatched(enemy: Enemy) {
        score += enemy.score
        viewController?.setScore(score: score)
        enemy.die(.CATCH)
        
        if (enemy is EnemyFast) {
            player.setBlue()
        } else {
            player.setBlack()
        }
    }
    
}
