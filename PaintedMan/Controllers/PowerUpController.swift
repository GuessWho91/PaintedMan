//
//  PowerUpController.swift
//  PaintedMan
//
//  Created by ООО АКИП on 21.07.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import UIKit

class PowerUpController: UIViewController, OnMoneySpendListener {
    
    @IBAction func onBackClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var currentMoneyLabel: UILabel!
    
    @IBOutlet weak var powerUpView1: PowerUpElementView!
    @IBOutlet weak var powerUpView2: PowerUpElementView!
    @IBOutlet weak var powerUpView3: PowerUpElementView!
    @IBOutlet weak var powerUpView4: PowerUpElementView!
    @IBOutlet weak var powerUpView5: PowerUpElementView!
    @IBOutlet weak var powerUpView6: PowerUpElementView!
    @IBOutlet weak var powerUpView7: PowerUpElementView!
    @IBOutlet weak var powerUpView8: PowerUpElementView!
    
    override func viewDidLoad() {
        onChange()
    }
    
    func onChange() {
        
        setButtons()
        
        showMoneyValue()
    }
    
    private func setButtons() {
        
        powerUpView1.setPowerUp(powerUp: .FastGun)
        powerUpView1.addListener(self)
        
        powerUpView2.setPowerUp(powerUp: .PowerGun)
        powerUpView2.addListener(self)
        
        powerUpView3.setPowerUp(powerUp: .UltimateGun)
        powerUpView3.addListener(self)
        
        powerUpView4.setPowerUp(powerUp: .EnemySlow)
        powerUpView4.addListener(self)
        
        powerUpView5.setPowerUp(powerUp: .MagazinSize)
        powerUpView5.addListener(self)
        
        powerUpView6.setPowerUp(powerUp: .CatchSize)
        powerUpView6.addListener(self)
        
        powerUpView7.setPowerUp(powerUp: .MaximumLives)
        powerUpView7.addListener(self)
        
        powerUpView8.setPowerUp(powerUp: .StartLives)
        powerUpView8.addListener(self)
        
    }
    
    private func showMoneyValue() {
        currentMoneyLabel.text = String(Const.currentMoney)
    }
    
}
