//
//  OrderDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 15/02/23.
//

import Foundation

class OrderDetails
{

    func orderProduct(productDetails: [ProductDetails] , purchaseOrderDetails : inout [PurchaseOrderDetails])
    {
        repeat
        {
            print("Choose the product id")
            var id = Int(readLine()!)!
            var temp = 0
            
            for product in productDetails
            {
                if product.productId == id
                {
                    temp = 1
                    if product.active == "available"
                    {
                        var purchaseOrderDetail = PurchaseOrderDetails()
                        purchaseOrderDetail.productId = product.productId
                        purchaseOrderDetail.productName = product.productName
                        purchaseOrderDetail.category = product.category
                        purchaseOrderDetail.price = product.price
                        
                        print("Enter the number of quantity?")
                        var numberOfQuantity = Int(readLine()!)!
                        
                        purchaseOrderDetail.quantity = numberOfQuantity
                        
                        purchaseOrderDetails.append(purchaseOrderDetail)
                    }
                    else
                    {
                    print("Sry now your order product is non available")
                    }
                }
                
            }
            if temp == 0
            {
                print("The entered product id was not found")
            }
            print("Do you want to order another one product?")
        }while readLine()! == "Yes"
    }
    

}
