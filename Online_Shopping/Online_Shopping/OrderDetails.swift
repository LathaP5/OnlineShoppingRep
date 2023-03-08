//
//  OrderDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 15/02/23.
//

import Foundation

class OrderDetails
{

    func orderProduct(productDetails: ProductTableDetails  , purchaseOrderDetails : inout [PurchaseOrderDetails])
    {
        
        repeat
        {
            
            let productId = UserInput.getProductId()
            var temp = 0
            var temp1 = 0
            let availablity = productDetails.getProductAvailablity(productId : productId)
    
            if productId == availablity.0
                {
                    temp = 1
                    if availablity.4 == "available"
                    {
                        let purchaseOrderDetail = PurchaseOrderDetails()
                        let numberOfQuantity = UserInput.getNumberOfQuantity()
                        
                        for productDetail in 0..<purchaseOrderDetails.count
                        {
                            if purchaseOrderDetails[productDetail].productId == productId
                            {
                                temp1 = 1
                                purchaseOrderDetails[productDetail].quantity = purchaseOrderDetails[productDetail].quantity + numberOfQuantity
                            }
                        
                        }
                        
                        if temp1 == 0
                        {
                            purchaseOrderDetail.productId = productId
                            purchaseOrderDetail.productName = availablity.1
                            purchaseOrderDetail.category = availablity.2
                            purchaseOrderDetail.price = availablity.3
                            
                            purchaseOrderDetail.quantity = numberOfQuantity
                            
                            purchaseOrderDetails.append(purchaseOrderDetail)
                        }
                        
                    }
                    else
                    {
                    print("Sry now your order product is non available")
                    }
                }
            
            if temp == 0
            {
                print("The entered product id was not found")
            }
      
        }while UserInput.getOrderProductContinueOption()
    }
     
    
    
   func orderProductCategoryWise(productDetails: ProductTableDetails , purchaseOrderDetails : inout [PurchaseOrderDetails] , productIds : [Int])
    {
       
        repeat
        {
            
            let productId = UserInput.getProductId()
            var temp = 0
            var temp1 = 0
            let availablity = productDetails.getProductAvailablity(productId : productId)
    
            if productId == availablity.0
                {
                    temp = 1
                    if availablity.4 == "available"
                    {
                        let purchaseOrderDetail = PurchaseOrderDetails()
                        let numberOfQuantity = UserInput.getNumberOfQuantity()
                        
                        for productDetail in 0..<purchaseOrderDetails.count
                        {
                            if purchaseOrderDetails[productDetail].productId == productId
                            {
                                temp1 = 1
                                purchaseOrderDetails[productDetail].quantity = purchaseOrderDetails[productDetail].quantity + numberOfQuantity
                            }
                        
                        }
                        
                        if temp1 == 0
                        {
                            purchaseOrderDetail.productId = productId
                            purchaseOrderDetail.productName = availablity.1
                            purchaseOrderDetail.category = availablity.2
                            purchaseOrderDetail.price = availablity.3
                            
                            purchaseOrderDetail.quantity = numberOfQuantity
                            
                            purchaseOrderDetails.append(purchaseOrderDetail)
                        }
                        
                    }
                    else
                    {
                    print("Sry now your order product is non available")
                    }
                }
            
            if temp == 0
            {
                print("The entered product id was not found")
            }
      
        }while UserInput.getOrderProductContinueOption()
                
    }
    
   
    
}
