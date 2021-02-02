//
//  Enemy.swift
//  PaintedMan
//
//  Created by ООО АКИП on 02.02.2021.
//  Copyright © 2021 GuessWho. All rights reserved.
//

import Foundation

protocol Enemy {
    var score: Int { get }
    func run()
    func die(_ mode: GameConst.GameTypes)
    func removeFromParent()
}
