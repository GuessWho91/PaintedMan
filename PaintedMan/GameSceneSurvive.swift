//
//  GameSceneSurvive.swift
//  PaintedMan
//
//  Created by ООО АКИП on 16/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation
import SpriteKit

class GameSceneSurvive: GameScene {
    
    private lazy var player = Gun()
    private var bulletType: GameConst.BulletTypes = .NORMAL
    
    private var magazinSize: Int = 100
    
    override func onDidMove() {
        
        addChild(player)
        
        setBulletType(type: .NORMAL)
        
        viewController?.btnGun.isHidden = false
        viewController?.btnSuperGun.isHidden = true
        
        enemyGenerator = EnemyGenerator(level: level, mode: .SURVIVE)
        
        allowMove = false
    }
    
    override func checkContact(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {
        
        //Попали во врага
        if ((firstBody.categoryBitMask == GameConst.PhysicsCategory.Enemy) &&
            (secondBody.categoryBitMask == GameConst.PhysicsCategory.Bullet)) {
            if let monster = firstBody.node as? Enemy, let
                projectile = secondBody.node as? Bullet {
                monsterShooted(bullet: projectile, enemy: monster)
            }
        }
        
        if ((firstBody.categoryBitMask == GameConst.PhysicsCategory.Bullet) &&
            (secondBody.categoryBitMask == GameConst.PhysicsCategory.Bonus)) {
            if let bullet = firstBody.node as? Bullet, let
                bonus = secondBody.node as? BonusBubble {
                bonusShooted(bullet: bullet, bonus: bonus)
            }
        }
        
    }
    
    override func onTouched(_ touchLocation: CGPoint) {
        
        magazinSize -= 1
        
        player.shoot(touchLocation: touchLocation)
        
        let bullet = Bullet(type: bulletType)
        addChild(bullet)
        bullet.run(touchLocation: touchLocation)
        
        if (magazinSize <= 0) {
            magazinSize = 100
            setBulletType(type: .NORMAL)
        }
        
    }
    
    //Попали во врага
    private func monsterShooted(bullet: Bullet, enemy: Enemy) {
        
        score += enemy.score
        viewController?.setScore(score: score)
        enemy.die(.SURVIVE)
        
        if (bullet.type != .SUPER && bullet.type != .STRONG) {
            bullet.removeFromParent()
        } else {
            enemy.die(.SURVIVE) // "Добьем сильных мобов"
        }
    }
    
    //Попали в бонус
    private func bonusShooted(bullet: Bullet, bonus: BonusBubble) {
        
        if (bullet.type != .SUPER && bullet.type != .STRONG) {
            bullet.removeFromParent()
        }
        
        let bonusType = bonus.getType()
        switch bonusType {
        case .Live:
            if (lives < (PowerUps.MaximumLives.getValue() + 5)) {
                lives += 1
            }
            viewController?.setLives()
        case .StrongBullet:
            magazinSize = 10 + 3 * PowerUps.MagazinSize.getValue()
            setBulletType(type: .STRONG)
        case .FastBullet:
            magazinSize = 30 + 10 * PowerUps.MagazinSize.getValue()
            setBulletType(type: .FAST)
        case .Ultimate:
            viewController?.btnSuperGun.isHidden = false
        }
        
        bonus.removeFromParent()
        showBonusGet(bonus: bonus)
    }
    
    func showBonusGet(bonus: BonusBubble) {
        viewController?.labelNotification.text = bonus.getCongratsString()
        viewController?.labelNotification.blink()
    }
    
    func setBulletType(type: GameConst.BulletTypes) {
        bulletType = type
        allowMove = (type == GameConst.BulletTypes.FAST)
        viewController?.btnGun.setImage(bulletType.getImage(), for: .normal)
    }
    
}
