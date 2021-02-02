//
//  AppStoreReviewManager.swift
//  PaintedMan
//
//  Created by ООО АКИП on 23.07.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import StoreKit

class AppStoreReviewManager {
    
    static func requestReviewIfAppropriate() {
        
        if (Const.currentLevel < 5 || Const.starsRequestDone) {
            return
        }
        
        SKStoreReviewController.requestReview()
        
        Const.starsRequestDone = true
    }
    
}
