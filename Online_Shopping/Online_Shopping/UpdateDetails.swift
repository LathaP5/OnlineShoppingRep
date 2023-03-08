//
//  UpdateDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 15/02/23.
//

import Foundation

class UpdateDetails
{
    
    
    
    func updateProduct(oldProductId : Int , productDetails : ProductTableDetails , productIds : [Int])
    {
        var temp = 0
        for productId in 0..<productIds.count
        {
            if productIds[productId] == oldProductId
            {
                temp = 1
            }
        }
        
        if temp == 1
        {
            var newPrice = UserInput.getPrice()
            var newActive = UserInput.getActive()
            productDetails.UpdateProductIdDetails(oldProductId : oldProductId , newPrice: newPrice, newActive: newActive)
        }
        else
        {
            print("Your productId was not found for update")
        }
    }
        
}



