//
//  Const.swift
//  PaintedMan
//
//  Created by ООО АКИП on 16/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation

class Const {
    
    private static let preferences = UserDefaults.standard
    
    static var currentLevel: Int {
        get {
            return preferences.object(forKey: "currentLevel") as? Int ?? 1
        }
        set {
            preferences.set(newValue, forKey: "currentLevel")
            preferences.synchronize()
        }
    }
    
//    static func getLevelStars(level: Int) -> Int {
//
//        let stars = preferences.object(forKey: "level\(level)") as? Int ?? 0
//
//        return stars > 3 ? 3 : stars
//
//    }
//
//    static func setLevelStars(level: Int, stars: Int) {
//
//        preferences.set(stars, forKey: "level\(level)")
//        preferences.synchronize()
//
//    }
    
    static var isMusic: Bool {
        get {
//            return false
            return preferences.object(forKey: "isMusic") as? Bool ?? false
        }
        set {
            preferences.set(newValue, forKey: "isMusic")
            preferences.synchronize()
        }
    }
    
    static var isSound: Bool {
        get {
//            return false
            return preferences.object(forKey: "isSound") as? Bool ?? false
        }
        set {
            preferences.set(newValue, forKey: "isSound")
            preferences.synchronize()
        }
    }
    
    static var showADS: Bool {
        get {
            return preferences.object(forKey: "showADS") as? Bool ?? true
        }
        set {
            preferences.set(newValue, forKey: "showADS")
            preferences.synchronize()
        }
    }
    
    static var currentMoney: Int {
        get {
            return preferences.object(forKey: "currentMoney") as? Int ?? 0
        }
        set {
            preferences.set(newValue, forKey: "currentMoney")
            preferences.synchronize()
        }
    }
    
    static var countToAd: Int {
        get {
            return preferences.object(forKey: "countToAd") as? Int ?? 0
        }
        set {
            preferences.set(newValue, forKey: "countToAd")
            preferences.synchronize()
        }
    }
    
    static var starsRequestDone: Bool {
        get {
            return preferences.object(forKey: "starsRequestDone") as? Bool ?? false
        }
        set {
            preferences.set(newValue, forKey: "starsRequestDone")
            preferences.synchronize()
        }
    }
    
    static var userName: String? {
        get {
            return preferences.object(forKey: "userName") as? String
        }
        set {
            preferences.set(newValue, forKey: "userName")
            preferences.synchronize()
        }
    }
    
    static var bestSurvive: Int {
        get {
            return preferences.object(forKey: "bestSurvive") as? Int ?? 0
        }
        set {
            preferences.set(newValue, forKey: "bestSurvive")
            preferences.synchronize()
        }
    }
    
    static var bestCatch: Int {
        get {
            return preferences.object(forKey: "bestCatch") as? Int ?? 0
        }
        set {
            preferences.set(newValue, forKey: "bestCatch")
            preferences.synchronize()
        }
    }
    
    static var bestPunch: Int {
        get {
            return preferences.object(forKey: "bestPunch") as? Int ?? 0
        }
        set {
            preferences.set(newValue, forKey: "bestPunch")
            preferences.synchronize()
        }
    }
    
    static func generateSplits(view: UIView) {
        
        let images = ["split_black", "split_blue", "split_red"]
        
        let count = Int.random(in: 6..<10)
        for _ in 0...count {
            
            let size = view.frame.height/CGFloat(Int.random(in: 2..<4))
            
            let actualY = GameConst.random(min: 0, max: view.frame.height - size/2)
            let actualX = GameConst.random(min: 0, max: view.frame.width - size/2)
            
            let image = UIImage(imageLiteralResourceName: images.randomElement()!)
            let imageView = UIImageView(image: image)
            
            imageView.frame = CGRect(x: actualX, y: actualY, width: size, height: size)
            imageView.alpha = 0.2
            imageView.layer.zPosition = -1
            view.addSubview(imageView)
            
        }
        
    }
    
    static func loadAtlas(name: String) -> [SKTexture]  {
        
        var runningFrames: [SKTexture] = []
        
        let runningAnimatedAtlas = SKTextureAtlas(named: name)
        var walkFrames: [SKTexture] = []
        
        let numImages = runningAnimatedAtlas.textureNames.count
        for i in 0...numImages-1 {
            let textureName = "tile00\(i)"
            walkFrames.append(runningAnimatedAtlas.textureNamed(textureName))
        }
        
        runningFrames = walkFrames
        
        return runningFrames
    }
    
}
