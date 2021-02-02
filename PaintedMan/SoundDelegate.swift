//
//  SoundDelegate.swift
//  PaintedMan
//
//  Created by ООО АКИП on 22.07.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import Foundation
import AVFoundation

class SoundDelegate {
    
    static var bgMusicPlayer: AVAudioPlayer? = nil
    static var soundsArray: [AVAudioPlayer] = []
    
    static func startBackgroundMusic() {
        
        if (!Const.isMusic) {
            return
        }
        
        //Запускаем музыку
        do {
            let bgMusic: URL = Bundle.main.url(forResource: "bg_music", withExtension: "wav")!
            bgMusicPlayer = try AVAudioPlayer(contentsOf: bgMusic)
            bgMusicPlayer?.numberOfLoops = -1
            bgMusicPlayer?.prepareToPlay()
            bgMusicPlayer?.play()
            
        } catch {}
    }
    
    static func pauseBackgroundMusic() {
        bgMusicPlayer?.pause()
        soundsArray = []
    }
    
    static func resumeBackgroundMusic() {
        
        if (!Const.isMusic) {
            return
        }
        
        bgMusicPlayer?.play()
        soundsArray = []
    }
    
    static func stopBackgroundMusic() {
        bgMusicPlayer?.stop()
        soundsArray.forEach { it in
            it.stop()
        }
    }
    
    static func playSound(name: String, ext: String = "wav") {
        
        if (!Const.isSound) {
            return
        }
        
        soundsArray = []
        
        //Запускаем музыку
        do {
            let bgMusic: URL = Bundle.main.url(forResource: name, withExtension: ext)!
            let soundPlayer = try AVAudioPlayer(contentsOf: bgMusic)
            soundPlayer.volume = 1
            soundPlayer.prepareToPlay()
            soundPlayer.play()
            
            soundsArray.append(soundPlayer)
        } catch {
            print(error)
        }
        
    }
    
}
