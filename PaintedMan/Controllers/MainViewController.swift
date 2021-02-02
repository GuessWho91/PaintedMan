//
//  ViewController.swift
//  PaintedMan
//
//  Created by ООО АКИП on 12.12.17.
//  Copyright © 2017 GuessWho. All rights reserved.
//

import UIKit
import AVFoundation
import GoogleMobileAds
import Kingfisher

class MainViewController: UIViewController {
    
    @IBAction func onCampaignClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CampaignViewController") as! CampaignViewController
        present(vc, animated: true, completion: nil)
        
        SoundDelegate.playSound(name: "paper_next")
    }
    
    @IBAction func onModeClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ModeViewController") as! ModeViewController
        present(vc, animated: true, completion: nil)
        
        SoundDelegate.playSound(name: "paper_next")
    }
    
    @IBAction func onBestClicked(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BestViewController") as! BestViewController
        present(vc, animated: true, completion: nil)
        
        SoundDelegate.playSound(name: "paper_next")
    }
    
    @IBAction func shopBtnClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PowerUpController") as! PowerUpController
        present(vc, animated: true, completion: nil)
        
        SoundDelegate.playSound(name: "paper_next")
    }
    
    @IBAction func onQuitClicked(_ sender: Any) {
        exit(0)
    }
    
    @IBOutlet weak var btnMusic: UIButton!
    @IBOutlet weak var btnSound: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnShop: UIButton!
    
    @IBOutlet weak var imageViewLogo: UIImageView!
    
    @IBAction func musicBtnClick(_ sender: AnyObject) {
        
        Const.isMusic = !Const.isMusic
        
        if (Const.isMusic) {
            sender.setImage(UIImage(named: "music"), for: [])
            SoundDelegate.startBackgroundMusic()
        } else {
            sender.setImage(UIImage(named: "music_off"), for: [])
            SoundDelegate.stopBackgroundMusic()
        }
        
    }

    @IBAction func soundBtnClick(_ sender: AnyObject) {
        
        Const.isSound = !Const.isSound
        
        if (Const.isSound) {
            sender.setImage(UIImage(named: "sound"), for: [])
        } else {
            sender.setImage(UIImage(named: "sound_off.png"), for: [])
        }
        
    }
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Const.isSound = false
        
        if (Const.isMusic) {
            
            SoundDelegate.startBackgroundMusic()
            
        } else {
            
            //Устанавливаем соответствующую икону
            btnMusic.setImage(UIImage(named: "music_off"), for: UIControl.State.normal)
            
        }
        
        if (!Const.isSound){
            //Устанавливаем соответствующую икону
            btnSound.setImage(UIImage(named: "sound_off"), for: [])
        }

        if (Const.showADS) {
            bannerView.adUnitID = "ca-app-pub-9439314883134085/6545397989"
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        } else {
            bannerView.isHidden = true
        }
        
        //InAppPurchase.default.initialize ()
        setLogo()
    }
    
    private func setLogo() {
        
        let urlString = "https://arcsinus.ru/images/img/logo@2x.png"
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        imageViewLogo.kf.setImage(with: url)
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (PowerUps.canBySomething()) {
            btnShop.setImage(UIImage(named: "shop_available"), for: [])
        }
    }
    
}

