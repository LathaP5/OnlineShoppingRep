//
//  CancelDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 15/02/23.
//

import Foundation

class ChangeOrCancelDetails
{
    func changeProduct(purchaseOrderDetails : [PurchaseOrderDetails])
    {

            repeat
            {
                var temp = 0
                
                
                let productId = UserInput.getProductId()
                
                for product in purchaseOrderDetails
                {
                    if product.productId == productId
                    {
                        temp = 1
                        
                        print("Enter the quantity?")
                        let quantity = Int(readLine()!)!
                        
                        product.quantity = quantity
                        print("Your product id is changed")
                    }
                }
                if temp == 0
                {
                    print("You product id was not found , so please try again")
                }
                let view = View()
                view.viewOrderedProducts(purchaseOrderDetails : purchaseOrderDetails)
            }while UserInput.getChangeProductContinueOption()
        }
        
    
    func cancelProduct(purchaseOrderDetails : inout [PurchaseOrderDetails])
    {
            repeat
            {
                var temp = 0
                let productId = UserInput.getProductId()
                
                for index in 0..<purchaseOrderDetails.count
                {
                if purchaseOrderDetails[index].productId == productId
                {
                    temp = 1
                    
                    purchaseOrderDetails.remove(at : index)
                    print("Your product id is removed")
                    break
                }
                }
                if temp == 0
                {
                    print("You product id was not found , so please try again")
                }
                
                let view = View()
                view.viewOrderedProducts(purchaseOrderDetails : purchaseOrderDetails)
            }while UserInput.getCancelProductContinueOption()
        }

    
     
}
