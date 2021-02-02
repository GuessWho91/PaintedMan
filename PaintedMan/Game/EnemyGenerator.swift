//
//  EnemyGenerator.swift
//  PaintedMan
//
//  Created by ООО АКИП on 16/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation
import SpriteKit

class EnemyGenerator {
    
    private var callerCount = 0
    private let level: Int
    private let mode: GameConst.GameTypes
    
    private var enemies = Array<Enemy>()
    
    init(level: Int, mode: GameConst.GameTypes) {
        self.level = level
        self.mode = mode
    }
    
    func generateEnemy() -> [Enemy] {
        
        callerCount += 1
        
        enemies = Array<Enemy>()
        
        if (level == 0) {
            modeGeneration()
        } else {
            levelGeneration()
        }
        
        return enemies
    }
    
    private func levelGeneration() { // called every 0.5 seconds, so times gonna be callerCount/2
        
        let maxCallerTime = LevelDelegate(level).getLevelTime() * 2
        if (callerCount > maxCallerTime) {
            return
        }
        
        simpleEnemy()

        if (level > 5) {
            generateFast()
        }
        
        if (level > 9) {
            bossGenerationLevel()
            simpleEnemy()
        }
        
        if (level > 13) {
            if (mode == .CATCH) {
                return
            }
            generateRandom()
        }
        
        if (level > 15) {
            generateStrong()
        }
        
        if (level > 17) {
            generateRandom()
        }
        
        if (level > 20) {
            simpleEnemy()
            generateStrong()
        }
        
        if (level > 22) {
            generateRandom()
        }
        
        if (level > 25) {
            generateFast()
        }
        
        if (level > 27) {
            generateRandom()
        }
    }
    
    private func modeGeneration() {
        
        simpleEnemy()
        
        bossGenerationMode()
        
        if (callerCount > 10) {
            generateFast()
        }
        
        if (callerCount > 30) {
            bossGenerationLevel()
            simpleEnemy()
        }
        
        if (callerCount > 40) {
            generateRandom()
        }
        
        if (callerCount > 60) {
            generateStrong()
        }
        
        if (callerCount > 80) {
            generateRandom()
        }
        
        if (callerCount > 120) {
            simpleEnemy()
            generateStrong()
        }
        
        if (callerCount > 160) {
            generateRandom()
        }
        
        if (callerCount > 240) {
            generateFast()
        }
        
        if (callerCount > 300) {
            generateRandom()
        }
    }
    
    private func simpleEnemy() {
        if (callerCount % 3 == 0) {
            let monster = Enemy()
            enemies.append(monster)
        }
    }
    
    private func generateFast() {
        if (callerCount % 5 == 0) {
            let monster = EnemyFast()
            enemies.append(monster)
        }
    }
    
    private func generateStrong() {
        
        if (mode == .CATCH) {
            return
        }
        
        if (callerCount % 7 == 0) {
            let monster = EnemyStrong()
            enemies.append(monster)
        }
    }
    
    private func generateRandom() {
        
        let rand = Int.random(in: 0...4)
        
        switch rand {
        case 0:
            let monster = Enemy()
            enemies.append(monster)
        case 1:
            let monster = EnemyFast()
            enemies.append(monster)
        case 2:
            if (mode != .CATCH) {
                let monster = EnemyStrong()
                enemies.append(monster)
            } else {
                let monster = Enemy()
                enemies.append(monster)
            }
        default:
            ()
        }
        
    }
    
    private func bossGenerationLevel() {
        
        if (mode == .CATCH) {
            return
        }
        
        if ((level == 10 || level == 5) && callerCount == 100) {
            let monster = Boss(lives: level * 2)
            enemies.append(monster)
        } else if ((level == 20 || level == 15) && callerCount == 160) {
            let monster = Boss(atlasName: "boss2", lives: level * 2)
            enemies.append(monster)
        } else if ((level == 30 || level == 25) && callerCount == 190) {
           let monster = Boss(atlasName: "boss3", lives: level * 2)
           enemies.append(monster)
        }
        
    }
    
    private func bossGenerationMode() {
    
        if (mode == .CATCH) {
            return
        }
        
        if (callerCount == 120) {
            let monster = Boss()
            enemies.append(monster)
        } else if (callerCount == 240) {
            let monster = Boss(atlasName: "boss2", lives: 30)
            enemies.append(monster)
        } else if (callerCount == 360) {
            let monster = Boss(atlasName: "boss3", lives: 40)
            enemies.append(monster)
        } else if (callerCount == 420) {
            let monster = Boss()
            enemies.append(monster)
            let monster2 = Boss(atlasName: "boss2", lives: 30)
            enemies.append(monster2)
        } else if (callerCount == 480) {
            let monster = Boss()
            enemies.append(monster)
            let monster2 = Boss(atlasName: "boss3", lives: 40)
            enemies.append(monster2)
        } else if (callerCount == 540) {
            let monster = Boss(atlasName: "boss2", lives: 30)
            enemies.append(monster)
            let monster2 = Boss(atlasName: "boss3", lives: 40)
            enemies.append(monster2)
        }
        
    }
}
