//
//  ModeViewController.swift
//  PaintedMan
//
//  Created by ООО АКИП on 10.01.18.
//  Copyright © 2018 GuessWho. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ModeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func startGame(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Game", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GameController") as! GameController
        
        switch sender.titleLabel?.text {
        case "CATCH":
            vc.mode = .CATCH
        case "PUNCH":
            vc.mode = .PUNCH
        default:
            vc.mode = .SURVIVE
        }

        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func onBackPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
//        Const.generateSplits(view: self.view)
        imageView.layer.zPosition = -2
        
        if (Const.showADS) {
            bannerView.adUnitID = "ca-app-pub-9439314883134085/6545397989"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        } else {
            bannerView.isHidden = true
        }
    }

}
