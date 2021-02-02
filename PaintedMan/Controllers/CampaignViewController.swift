//
//  CampaignViewController.swift
//  PaintedMan
//
//  Created by ООО АКИП on 10.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import UIKit
import GoogleMobileAds

class CampaignViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var level1: UIButton!
    @IBOutlet weak var level2: UIButton!
    @IBOutlet weak var level3: UIButton!
    @IBOutlet weak var level4: UIButton!
    @IBOutlet weak var level5: UIButton!
    @IBOutlet weak var level6: UIButton!
    @IBOutlet weak var level7: UIButton!
    @IBOutlet weak var level8: UIButton!
    @IBOutlet weak var level9: UIButton!
    @IBOutlet weak var level10: UIButton!
    @IBOutlet weak var level11: UIButton!
    @IBOutlet weak var level12: UIButton!
    @IBOutlet weak var level13: UIButton!
    @IBOutlet weak var level14: UIButton!
    @IBOutlet weak var level15: UIButton!
    
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    private var offset: Int = 0
    private var buttonsArray: [UIButton] = []
    
    @IBAction func onPreviuosPressed(_ sender: Any) {
        
        offset = 0
        
        initViews()
    }
    
    @IBAction func onNextPressed(_ sender: Any) {
        
        offset = 15
        
        initViews()
    }
    
    @IBAction func onStartLevelPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameController") as! GameController
        
        let level = getLevel(sender)
        vc.level = level
        vc.mode = LevelDelegate(level).getLevelMode()
        present(vc, animated: true, completion: {
            self.setImagesForButtons()
            self.setButtonsClickability()
        })
        
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonsArray = [level1, level2, level3, level4, level5, level6, level7, level8,
                        level9, level10, level11, level12, level13, level14, level15]
        
        if (Const.showADS) {
            bannerView.adUnitID = "ca-app-pub-9439314883134085/6545397989"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        } else {
            bannerView.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var i = 0
        buttonsArray.forEach { it in
            i += 1
            it.accessibilityHint = "\(i)"
        }
        
        initViews()
    }
    
    private func initViews() {
        
        setImagesForButtons()
        setButtonsClickability()
        
        //Const.generateSplits(view: self.view)
        imageView.layer.zPosition = -2
        
        if (offset == 15) {
            btnPrevious.isHidden = false
            btnNext.isHidden = true
        } else {
            btnPrevious.isHidden = true
            btnNext.isHidden = false
        }
    }
    
    private func setImagesForButtons() {
        
        buttonsArray.forEach { it in
            setButtonImage(it)
        }
        
        buttonsArray.forEach { it in
            it.setTitle(String(getButtonLevel(it)), for: [])
        }
        
    }
    
    private func getButtonLevel(_ button: UIButton) -> Int {
        return (Int(button.accessibilityHint ?? "1") ?? 0) + offset
    }
    
    private func setButtonImage(_ btn: UIButton) {
        
        let level = getLevel(btn)
//        let stars = Const.getLevelStars(level: level)
        let stars = LevelStars.getLevelStarsCount(level: level).first?.starsCount ?? 0
        
        var image: UIImage? = nil
        switch stars {
        case 1:
            image = UIImage(imageLiteralResourceName: "level1")
        case 2:
            image = UIImage(imageLiteralResourceName: "level2")
        case 3:
            image = UIImage(imageLiteralResourceName: "level3")
        default:
            image = UIImage(imageLiteralResourceName: "level")
        }
        
        btn.setBackgroundImage(image, for: .normal)
        
    }
    
    private func setButtonsClickability() {
        
        buttonsArray.forEach { it in
           setButtonClickability(it)
       }
        
    }
    
    private func setButtonClickability(_ btn: UIButton) {
        
        let level = getLevel(btn)
        let currentLevel = Const.currentLevel
        
        if (level <= currentLevel) {
            btn.isEnabled = true
        } else {
            btn.isEnabled = false
        }
        
    }
    
    private func getLevel(_ btn: UIButton) -> Int {
        return (Int(btn.accessibilityHint ?? "1") ?? 1) + offset
    }

}
