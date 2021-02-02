//
//  GameScenePunch.swift
//  PaintedMan
//
//  Created by ООО АКИП on 16/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation
import SpriteKit

class GameScenePunch: GameScene {
    
    override func onDidMove() {
        
        enemyGenerator = EnemyGenerator(level: level, mode: .PUNCH)
        viewController?.btnGun.isHidden = true
        viewController?.btnSuperGun.isHidden = true
        
        allowMove = false
    }

    override func onTouched(_ touchLocation: CGPoint) {
        let touchedEnemies = self.nodes(at: touchLocation)
        touchedEnemies.forEach { it in
            if (it is Enemy) {
                monsterPunched(enemy: it as! Enemy)
            } else if (it is BonusBubble) {
                bubblePunched(bonus: it as! BonusBubble)
            }
        }
        
    }
    
    override func checkContact(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {
        //Попали во врага суперпулей ;)
        if ((firstBody.categoryBitMask == GameConst.PhysicsCategory.Enemy) &&
            (secondBody.categoryBitMask == GameConst.PhysicsCategory.Bullet)) {
            if let monster = firstBody.node as? Enemy,
                let _ = secondBody.node as? Bullet {
                
                score += monster.score
                viewController?.setScore(score: score)
                monster.die(.SURVIVE)
                
            }
        }
    }
    
    //Попали во врага
    private func monsterPunched(enemy: Enemy) {
        score += enemy.score
        viewController?.setScore(score: score)
        enemy.die(.PUNCH)
    }
    
    private func bubblePunched(bonus: BonusBubble) {
        
        let bonusType = bonus.getType()
        
        switch bonusType {
        case .Live:
            if (lives < (PowerUps.MaximumLives.getValue() + 5)) {
                lives += 1
            }
            viewController?.setLives()
        case .Ultimate:
            viewController?.btnSuperGun.isHidden = false
        default:
            ()
        }
        
        bonus.removeFromParent()
        showBonusGet(bonus: bonus)
    }
    
    func showBonusGet(bonus: BonusBubble) {
        viewController?.labelNotification.text = bonus.getCongratsString()
        viewController?.labelNotification.blink()
    }
    
}
