//
//  GameScene.swift
//  PaintedMan
//
//  Created by ООО АКИП on 10.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation
import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

#if !(arch(x86_64) || arch(arm64))
    func sqrt(a: CGFloat) -> CGFloat {
        return CGFloat(sqrtf(Float(a)))
    }
#endif



extension CGPoint {
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        return self / length()
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewController: GameController?
    var gameConst: GameConst?
    var enemyGenerator: EnemyGenerator?
    
    static var worldSpeedBoost = 0
    
    var level = 0
    var score = 0
    var lives = (PowerUps.StartLives.getValue() + 3)
    
    var allowMove: Bool = false
    
    override func didMove(to view: SKView) {
        
        GameScene.worldSpeedBoost = 0
        gameConst = GameConst(screen: size)
        
        addFinishLine()
        setBackground()
        
        physicsWorld.gravity = CGVector.zero
        physicsWorld.contactDelegate = self
        
        onDidMove()
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonsters),
                SKAction.wait(forDuration: 0.5)
                ])
        ))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

        if !(allowMove) {
            return
        }
        
        //To stop the long press if we slide a finger of the button
        if let touch = touches.first {

            let location = touch.location(in: self)

            onTouched(location)

        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if (!isPaused) {

            guard let touch = touches.first else {
                return
            }
            
            let touchLocation = touch.location(in: self)
            onTouched(touchLocation)
        }
    
    }
    
    
    
    private func addFinishLine() {
        
        let finishLine = SKSpriteNode()
        
        finishLine.size = CGSize(width: 10, height: size.height * 2)
        finishLine.position = CGPoint(x: 0, y: 0)
        finishLine.physicsBody = SKPhysicsBody(rectangleOf: finishLine.size)
        finishLine.physicsBody?.isDynamic = true
        finishLine.physicsBody?.categoryBitMask = GameConst.PhysicsCategory.Finish
        finishLine.physicsBody?.contactTestBitMask = GameConst.PhysicsCategory.Enemy
        finishLine.physicsBody?.collisionBitMask = GameConst.PhysicsCategory.None
        
        addChild(finishLine)
        
        let fieldLine = SKSpriteNode()
        fieldLine.position = CGPoint(x: 0, y: size.height)
        fieldLine.size = CGSize(width: size.width * 2, height: 5)
        fieldLine.color = UIColor.brown
        fieldLine.physicsBody = SKPhysicsBody(rectangleOf: fieldLine.size)
        fieldLine.physicsBody?.isDynamic = true
        fieldLine.physicsBody?.categoryBitMask = GameConst.PhysicsCategory.FieldLine
        fieldLine.physicsBody?.contactTestBitMask = GameConst.PhysicsCategory.Enemy
        fieldLine.physicsBody?.collisionBitMask = GameConst.PhysicsCategory.None
        
        addChild(fieldLine)
        
        let fieldLine2 = SKSpriteNode()
        fieldLine2.position = CGPoint(x: 5, y: 45)
        fieldLine2.size = CGSize(width: size.width * 2, height: 5)
        fieldLine2.physicsBody = SKPhysicsBody(rectangleOf: fieldLine2.size)
        fieldLine2.physicsBody?.isDynamic = true
        fieldLine2.color = UIColor.clear
        fieldLine2.physicsBody?.categoryBitMask = GameConst.PhysicsCategory.FieldLine
        fieldLine2.physicsBody?.contactTestBitMask = GameConst.PhysicsCategory.Enemy
        fieldLine2.physicsBody?.collisionBitMask = GameConst.PhysicsCategory.None
        
        addChild(fieldLine2)
    }
    
    private func setBackground() {
        
        let background = SKSpriteNode(imageNamed: "SquareBackground.jpg")
        
        background.size = CGSize(width: size.width, height: size.height)
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.zPosition = -1.0
        addChild(background)
        
    }
    
    private func addMonsters() {
        
        let enemies = enemyGenerator?.generateEnemy()
        
        enemies?.forEach() { it in
            addChild(it)
            it.run()
        }
        
        checkForWin()
    }
    
    private func checkForWin() {
        
        let cTime = viewController?.currentTimeInSecods ?? 0
        let levelTime = LevelDelegate(level).getLevelTime()
        
        if (cTime < levelTime) {
            return
        }
        
        let enemiesCount = scene?.children.filter{$0 is Enemy}.count
        if (enemiesCount == 0) {
            viewController?.win()
        }
        
    }
    
    //Обработка столкновений
    func didBegin(_ contact: SKPhysicsContact) {
        
        //Отсортируем объекты столкновения
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        //Враг прошел
        if ((firstBody.categoryBitMask & GameConst.PhysicsCategory.Finish != 0) &&
            (secondBody.categoryBitMask & GameConst.PhysicsCategory.Enemy != 0)) {
            if let monster = secondBody.node as? Enemy {
                monsterPassed(enemy: monster)
            }
        }
        
        //Враг врезался в стену
        if ((firstBody.categoryBitMask & GameConst.PhysicsCategory.Enemy != 0) &&
            (secondBody.categoryBitMask & GameConst.PhysicsCategory.FieldLine != 0)) {
            if let monster = firstBody.node as? EnemyFast {
                monster.changeDirection()
            }
        }
        
        checkContact(firstBody: firstBody, secondBody: secondBody)
        
    }
    
    //Враг прошел
    private func monsterPassed(enemy: Enemy) {
        enemy.removeFromParent()
        lives -= 1
        viewController?.setLives()
        
        SoundDelegate.playSound(name: "pen_click")
    }
    
    open func onDidMove() {}
    open func checkContact(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {}
    open func onTouched(_ location: CGPoint) {}
    
}
