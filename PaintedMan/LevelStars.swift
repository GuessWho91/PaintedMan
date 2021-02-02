//
//  PlayerStats.swift
//  PaintedMan
//
//  Created by ООО АКИП on 02.02.2021.
//  Copyright © 2021 GuessWho. All rights reserved.
//

import Foundation
import RealmSwift

/*
 Added for stack match
 */
class LevelStars: Object {
    
    @objc dynamic var level = 0
    @objc dynamic var starsCount = 0
    
    convenience init(level: Int, starsCount: Int) {
        self.init()
        self.level = level;
        self.starsCount = starsCount;
    }
    
    static func getLevelStarsCount(level: Int) -> Results<LevelStars> {
        return try! Realm().objects(LevelStars.self).filter("level = %@", level)
    }
    
    static func upsert(level: Int, starsCount: Int) {
        
        let stars = getLevelStarsCount(level: level)
        
        let realm = try! Realm()
        if (stars.count > 0) {
        
            if (stars.first!.starsCount < starsCount) {
                try! realm.write {
                    stars.first!.starsCount = starsCount
                }
            }
            
        } else {

            try! realm.write() {
                realm.add(LevelStars(level: level, starsCount: starsCount))
            }
            
        }
        
    }
}
