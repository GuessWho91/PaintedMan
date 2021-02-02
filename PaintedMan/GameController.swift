//
//  GameController.swift
//  PaintedMan
//
//  Created by ООО АКИП on 06.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import UIKit
import SpriteKit

class GameController: UIViewController {
    
    @IBOutlet weak var imageLive_1: UIImageView!
    @IBOutlet weak var imageLive_2: UIImageView!
    @IBOutlet weak var imageLive_3: UIImageView!
    @IBOutlet weak var imageLive_4: UIImageView!
    @IBOutlet weak var imageLive_5: UIImageView!
    @IBOutlet weak var imageLive_6: UIImageView!
    @IBOutlet weak var imageLive_7: UIImageView!
    @IBOutlet weak var imageLive_8: UIImageView!
    
    @IBOutlet weak var labelNotification: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelMode: UILabel!
    
    @IBOutlet weak var btnPause: UIButton!
    @IBOutlet weak var btnGun: UIButton!
    @IBOutlet weak var btnSuperGun: UIButton!
    
    @IBAction func pause(_ sender: UIButton) {
        pause(isPaused: !isPaused)
    }
    
    @IBAction func onSuperButtonClicked(_ sender: Any) {
        
        let bullet = BulletSuper()
        scene?.addChild(bullet)
        bullet.run()
        
        btnSuperGun.isHidden = true
    }
    
    @IBAction func onGunButtonClicked(_ sender: Any) {
    }
    
    var level: Int = 0
    var mode: GameConst.GameTypes = .SURVIVE
    var currentTimeInSecods = 0
    var score: Int = 0
    
    private var scene: GameScene? = nil
    private var skView: SKView? = nil
    
    private var timer = Timer()
    
    private var isPaused: Bool = false
    private var moneyEarn: Int = 0
    
    func runTimer() {
        currentTimeInSecods = 0
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        currentTimeInSecods += 1
        labelTime.text = "Time: " + timeString(time: TimeInterval(currentTimeInSecods))
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i", minutes, seconds)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setScene()
        SoundDelegate.playSound(name: "paper_next")
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setScene() {
        
        switch mode {
        case .CATCH:
            scene = GameSceneCatch(size: view.bounds.size)
            labelMode.text = "Mode: CATCH"
            labelNotification.text = "Catch them!"
        case .PUNCH:
            scene = GameScenePunch(size: view.bounds.size)
            labelMode.text = "Mode: PUNCH"
            labelNotification.text = "Smash them!"
        case .SURVIVE:
            scene = GameSceneSurvive(size: view.bounds.size)
            labelMode.text = "Mode: SURVIVE"
            labelNotification.text = "Shoot them!"
        }
        
        SoundDelegate.playSound(name: "pencil_write")
        
        scene?.level = level
        scene?.viewController = self
        scene?.scaleMode = .resizeFill
        
        skView = view as? SKView
//        skView!.showsFPS = true
//        skView!.showsNodeCount = true
        skView!.ignoresSiblingOrder = true
        skView!.presentScene(scene)
        
        moneyEarn = 0
        currentTimeInSecods = 0
        
        setLives()
        runTimer()
        
        setScore(score: 0)
        
        labelNotification.blink()
    }
    
    func setScore(score: Int) {
        self.score = score
        labelScore.text = "Score: " + String(score)
    }
    
    func setLives() {
        
        imageLive_1.isHidden = (scene?.lives)! < 1
        imageLive_2.isHidden = (scene?.lives)! < 2
        imageLive_3.isHidden = (scene?.lives)! < 3
        imageLive_4.isHidden = (scene?.lives)! < 4
        imageLive_5.isHidden = (scene?.lives)! < 5
        imageLive_6.isHidden = (scene?.lives)! < 6
        imageLive_7.isHidden = (scene?.lives)! < 7
        imageLive_8.isHidden = (scene?.lives)! < 8
        
        if (scene?.lives ?? 0 <= 0) {
    
            if (level == 0) { // Это не компания, посчитаем заработанные очки
                moneyEarn = self.score/100
                Const.currentMoney += moneyEarn
            }
            
            pause(.loose)
        }
        
    }
    
    func pause(isPaused: Bool = true, _ type: GamePauseViewController.ControllerState = .pause) {
        
        self.isPaused = isPaused
        skView?.scene?.isPaused = isPaused
        
        timer.invalidate()
        
        if (isPaused) {
            showPauseDialog(type)
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
        }
        
    }

    func win() {
        pause(.win)
        
        //Save score
        if (level > 0) {
            
            if (level + 1 > Const.currentLevel) {
                Const.currentLevel += 1
                moneyEarn = LevelDelegate(Const.currentLevel).getLevelMoney()
                Const.currentMoney += moneyEarn
            }
            
            var stars = scene?.lives ?? 1
            if (stars > 3) {
                stars = 3
            }
            
            if (stars > Const.getLevelStars(level: level)) {
                Const.setLevelStars(level: level, stars: stars)
            }
            
        }
        
    }
    
    private func showPauseDialog(_ type: GamePauseViewController.ControllerState = .pause) {
        
        let customAlert = self.storyboard?.instantiateViewController(withIdentifier: "GamePauseViewController") as! GamePauseViewController
        
        customAlert.providesPresentationContextTransitionStyle = true
        customAlert.definesPresentationContext = true
        customAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        customAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        customAlert.gameController = self
        customAlert.state = type
        customAlert.moneyEarn = moneyEarn
        customAlert.score = score
        
        self.present(customAlert, animated: true, completion: nil)
        
    }
    
    func restartLevel() {
        
        currentTimeInSecods = 0
        isPaused = false
        
        setScene()
        setScore(score: scene?.score ?? 0)
    }
    
    func nextLevel() {
        
        level += 1
        mode = LevelDelegate(level).getLevelMode()
        
        setScene()
        setScore(score: scene?.score ?? 0)
    }
    
}

extension UILabel{
     func blink() {
        self.alpha = 1
        UIView.animate(withDuration: 0.7,
                        delay: 0.0,
                        options: [.curveLinear, .repeat, .autoreverse],
                        animations: {
                            UIView.setAnimationRepeatCount(2)
                            self.alpha = 0.2
                        },
                        completion: {_ in self.alpha = 0})
        
     }
}
