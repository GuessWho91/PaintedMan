//
//  GamePauseViewController.swift
//  PaintedMan
//
//  Created by ООО АКИП on 16/10/2018.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GamePauseViewController: UIViewController, GADInterstitialDelegate {

    enum ControllerState{
        case pause
        case win
        case loose
    }
    
    private var interstitial: GADInterstitial!
    
    var state: ControllerState = .pause
    var moneyEarn: Int = 0
    var score: Int = 0
    var gameController: GameController? = nil
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var imgMain: UIImageView!
    @IBOutlet weak var imgLeft: UIImageView!
    @IBOutlet weak var imgRight: UIImageView!
    @IBOutlet weak var labelEarnMoney: UILabel!
    
    @IBOutlet weak var ScoreView: UIView!
    @IBOutlet weak var labelScore: UILabel!
    @IBAction func btnShareScoreClicked(_ sender: Any) {
        showShareDialog()
    }
    
    @IBOutlet weak var shopBtn: UIButton!
    @IBAction func onShopClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PowerUpController") as! PowerUpController
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: false, completion: {
            self.gameController?.dismiss(animated: false, completion: nil)
        })
    }
    
    @IBAction func onAgainPressed(_ sender: Any) {
        
        self.dismiss(animated: false, completion: {
            self.gameController?.restartLevel()
        })
        
    }
    
    @IBAction func onNextPressed(_ sender: Any) {
        
        self.dismiss(animated: false, completion: {
            if (self.state == .pause) {
                self.gameController?.pause(isPaused: false)
            } else {
                self.gameController?.nextLevel()
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ScoreView.isHidden = true
        
        switch state {
        case .pause:
            labelTitle.text = "PAUSE"
            btnNext.setTitle("Continue", for: .normal)
            self.setImages(name: "stop")
        case .win:
            labelTitle.text = "VICTORY!"
            btnNext.setTitle("Next", for: .normal)
            
            setHappyFace()
            
            SoundDelegate.playSound(name: "success")
        case .loose:
            labelTitle.text = "LOOSE"
            btnNext.isHidden = true
            self.setImages(name: "sad")
            
            SoundDelegate.playSound(name: "pencil_drop")
        }
        
        if (moneyEarn == 0) {
            labelEarnMoney.isHidden = true
        } else {

            if (state == .loose) {
                labelTitle.text = "WELL DONE!"
                ScoreView.isHidden = false
                labelScore.text = "Score: \(score)"
            }
            
            labelEarnMoney.isHidden = false
            labelEarnMoney.text = "+ \(moneyEarn) COINS"
            setHappyFace()
        }
                
        Const.countToAd = Const.countToAd - 1
        interstitial = createAndLoadInterstitial()
        showADS()
        
        AppStoreReviewManager.requestReviewIfAppropriate()
        
        if (PowerUps.canBySomething()) {
            shopBtn.setImage(UIImage(named: "shop_available"), for: [])
        }
    }
    
    private func setHappyFace() {
        
        imgMain.image = UIImage(named: "happy_face")
        imgLeft.image = UIImage(named: "fireworks_left")
        imgRight.image = UIImage(named: "fireworks_right")
        
        switch self.gameController?.mode {
        case .CATCH:
            let prBest = Const.bestCatch
            if (score > prBest) {
                Const.bestCatch = score
            }
        case .PUNCH:
            let prBest = Const.bestPunch
            if (score > prBest) {
                Const.bestPunch = score
            }
        case .SURVIVE:
            let prBest = Const.bestSurvive
            if (score > prBest) {
                Const.bestSurvive = score
            }
        case .none:
            ()
        }
        
    }
    
    private func setImages(name: String) {
        
        imgMain.image = UIImage(named: name)
        imgLeft.image = UIImage(named: name)
        imgRight.image = UIImage(named: name)
        
    }
    
    private func createAndLoadInterstitial() -> GADInterstitial {
        let interstitial = GADInterstitial(adUnitID: "ca-app-pub-9439314883134085/5275428780")
        interstitial.delegate = self
        interstitial.load(GADRequest())
        return interstitial
    }
    
    private func showADS() {
        
        if (!Const.showADS || moneyEarn <= 0) {
            return
        }
        
        if (Const.countToAd <= 0 && interstitial.isReady) {
            interstitial.present(fromRootViewController: self)
            Const.countToAd = 3
        }
    }
    
    private func showShareDialog() {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let textToShare = "My score is \(score). Can you beat me?"
        
        if let myWebsite = URL(string: "http://apps.apple.com/ru/app/id1542806234") {//Enter link to your app here
            let objectsToShare = [textToShare, myWebsite, image ?? #imageLiteral(resourceName: "app-logo")] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //Excluded Activities
            activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
            //
            
            //                    activityVC.popoverPresentationController?.sourceView = sender
            self.present(activityVC, animated: true, completion: nil)
        }
        
    }
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        showADS()
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        interstitial = createAndLoadInterstitial()
    }

}
