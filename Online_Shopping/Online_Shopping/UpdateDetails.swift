//
//  UpdateDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 15/02/23.
//

import Foundation

class UpdateDetails
{
    func updateProduct(oldProductId : Int , oldProductName : String , newPrice : Int , newActive : String , productDetails : [ProductDetails])
    {
        var temp = 0
     
        for product in productDetails
        {
            if product.productId == oldProductId && product.productName == oldProductName
            {
                temp = 1
                product.price = newPrice
                product.active = newActive
                
                print("The given product id and product name was updated")
            }
        }
        if temp == 0
        {
            print("The given product id and product name does not exists so please try again")
        }
    }
}
