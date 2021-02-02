//
//  InAppPurchase.swift
//  PaintedMan
//
//  Created by ООО АКИП on 01.12.2020.
//  Copyright © 2020 GuessWho. All rights reserved.
//

import StoreKit

class InAppPurchase: NSObject, SKProductsRequestDelegate {
    
    static let `default` = InAppPurchase()

    private let productIdentifiers = Set<String>(
        arrayLiteral: "painted_man_no_ads"
    )

    private var productRequest: SKProductsRequest?

    func initialize() {
        requestProducts()
    }

    private func requestProducts() {
        productRequest?.cancel()

        let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productRequest.delegate = self
        productRequest.start()

        self.productRequest = productRequest
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard !response.products.isEmpty else {
            print("Found 0 products")
            return
        }

        for product in response.products {
            print("Found product: \(product.productIdentifier)")
        }
    }
}
