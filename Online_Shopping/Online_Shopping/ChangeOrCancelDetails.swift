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
                
                print("Enter product id for change quantity?")
                var productId = Int(readLine()!)!
                
                for product in purchaseOrderDetails
                {
                    if product.productId == productId
                    {
                        temp = 1
                        
                        print("Enter the quantity?")
                        var quantity = Int(readLine()!)!
                        
                        product.quantity = quantity
                        
                    }
                }
                if temp == 0
                {
                    print("You product id was not found , so please try again")
                }
                print("Do you want to change another one product quantity?")
            }while readLine()! == "Yes"
        }
        
    
    /*
    
    func cancelProduct(purchaseOrderDetails : inout [PurchaseOrderDetails])
    {

            repeat
            {
                var temp = 0
                
                var deleteItem : [Int] = []
                print("Enter product id to delete?")
                var productId = Int(readLine()!)!
                for index in 0..<purchaseOrderDetails.count
                {
                    if purchaseOrderDetails[index].productId == productId
                    {
                        temp = 1
                        deleteItem.append(index)
                    }
                }
                if temp == 0
                {
                    print("You product id was not found , so please try again")
                }
                
                
                for index in 0..<deleteItem.count
                {
                   
                    if index != 0
                    {
                        for change in index..<deleteItem.count
                        {
                            deleteItem[change] = deleteItem[change] - 1
                        }
                    }
                 
                    purchaseOrderDetails.remove(at : deleteItem[index])
                    
                
                    
                }
                
                
                print("Do you want to delete another one product?")
            }while readLine()! == "Yes"
        }
    
    */
    
    
    
    
    
    func cancelProduct(purchaseOrderDetails : inout [PurchaseOrderDetails])
    {

            repeat
            {
                var temp = 0
                
                var deleteItem : [Int] = []
                print("Enter product id to delete?")
                var productId = Int(readLine()!)!
                for index in 0..<purchaseOrderDetails.count
                {
                    if purchaseOrderDetails[index].productId == productId
                    {
                        temp = 1
                        deleteItem.append(index)
                    }
                }
                if temp == 0
                {
                    print("You product id was not found , so please try again")
                }
                
                
                for index in 0..<deleteItem.count
                {
                   
                    if index != 0
                    {
                        for change in index..<deleteItem.count
                        {
                            deleteItem[change] = deleteItem[change] - 1
                        }
                    }
                 
                    purchaseOrderDetails.remove(at : deleteItem[index])
                    
                
                    
                }
                
                
                print("Do you want to delete another one product?")
            }while readLine()! == "Yes"
        }
    
    
   
    
     
}
