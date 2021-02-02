//
//  PowerUpElementView.swift
//  PaintedMan
//
//  Created by ООО АКИП on 21.07.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import UIKit

class PowerUpElementView: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet var labelDescription: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    
    private var powerUp: PowerUps = .FastGun
    
    private var onMoneySpendListener: OnMoneySpendListener? = nil
    
    @IBAction func onUpdateClicked(_ sender: Any) {
        let _ = powerUp.update()
        setPowerUp(powerUp: powerUp)
        onMoneySpendListener?.onChange()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func setPowerUp(powerUp: PowerUps) {
        
        self.powerUp = powerUp
        
        imageView.image = powerUp.getIcon()
        labelDescription.text = powerUp.getDescription()
        
        if (powerUp.isMax()) {
            
            labelStatus.text = "MAX"
            
            labelPrice.isHidden = true
            btnUpdate.isHidden = true
            labelPrice.isHidden = true

            
        } else {
            
            let price = powerUp.getPrice()
            let currentMoney = Const.currentMoney
            
            if (currentMoney < price) {
                btnUpdate.isEnabled = false
            }
            
            labelPrice.text = String(price)
            
            let value = powerUp.getValue()
            
            if (powerUp.isMax()) {
                labelStatus.text = "MAX"
            } else if (value == 0) {
               labelStatus.text = "CLOSED"
            } else {
                labelStatus.text = " + \(powerUp.getValue())"
            }
        }
        
    }
    
    func initSubviews() {
        Bundle.main.loadNibNamed("PowerUpElementView", owner: self, options: nil)
        contentView.frame = self.bounds
        addSubview(contentView)
    }
    
    func addListener(_ listener: OnMoneySpendListener) {
        self.onMoneySpendListener = listener
    }
    
}

protocol OnMoneySpendListener {
    func onChange()
}
