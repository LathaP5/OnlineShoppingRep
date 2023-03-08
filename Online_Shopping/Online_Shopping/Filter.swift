//
//  Filter.swift
//  Online_Shopping
//
//  Created by latha-16226 on 28/02/23.
//

import Foundation

class Filter
{
   func filterProductInCategoryWise(productDetails : ProductTableDetails , category : String) -> [Int]
    {
        let productIds = productDetails.getDetailsCategoryWise(category : category)
        return productIds
        
    }
    
    
    func filterProductInPriceWise(productDetails: ProductTableDetails, fromRange:  Int , toRange:  Int , category : String) ->[Int]
    {
        let productIds = productDetails.getDetailsPriceWise(fromrRange : fromRange , toRange : toRange , category : category)
        return productIds
     }
    
    
    func filterProductInPriceWise(productDetails : [ProductDetails] , fromRange : Int , toRange : Int , category : String) ->[ProductDetails]
    {
        var productDetailsInPriceWise : [ProductDetails] = []
        for product in productDetails
        {
            if (product.price >= fromRange && product.price <= toRange)  && product.category == category
            {
                productDetailsInPriceWise.append(product)
            }
        }
        return productDetailsInPriceWise
        
    }
    
    func findOldUserOrderDetails(billConformedUser: [UserDetails] , userId : String , password : String) -> [Int]
    {
        
        var oldUserOrderDetails : [Int] = []
        
        for user in 0..<billConformedUser.count
        {
            if billConformedUser[user].userId == userId && billConformedUser[user].password == password
            {
                oldUserOrderDetails.append(user)
            }
        }
        return oldUserOrderDetails
    }
    
}
