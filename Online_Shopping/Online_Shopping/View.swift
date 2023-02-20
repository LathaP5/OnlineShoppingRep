//
//  View.swift
//  Online_Shopping
//
//  Created by latha-16226 on 15/02/23.
//

import Foundation


class View
{
    
    func viewAllProducts(productDetails : [ProductDetails])
    {
        print("Product Id       |       Product Name        |       Category        |       Price       |       Active")
        for product in productDetails
        {
            print("\(product.productId)         \(product.productName)         \(product.category)         \(product.price)         \(product.active)")
        }
    }
    
    func viewOrderedProducts(purchaseOrderDetails : [PurchaseOrderDetails])
    {
        print("Product Id       |       Product Name        |       Category        |       Price       |       Quantity")
        for product in purchaseOrderDetails
        {
            print("\(product.productId)         \(product.productName)         \(product.category)         \(product.price)         \(product.quantity)")
        }
    }
    
    
    func showBill(billNumber : inout Int , billDetails : [BillDetails] , userName : String , password : String , userDetails : [UserDetails])
    {
        
        for user in userDetails
        {
            
            if user.userName == userName && user.password == password
            {
                print("Your Bill Number : \(billNumber)")
                
                print("Your Name : \(user.name)")
                print("Your Email : \(user.email)")
                print("Your Mobile Number : \(user.mobileNumber)")
                print("Your Address : \(user.address)")
                print("Your City : \(user.city)")
                
                
                print("Product Id       |       Product Name        |       Category        |       Price       |       Quantity        |       Total Amount        ")
                for product in billDetails
                {
                    print("\(product.productId)         \(product.productName)         \(product.category)         \(product.price)         \(product.quantity)     \(product.totalAmount)")
                }
                print("---------------------------------------------------------------------------------------")
                print("               Grand total            :\(billDetails[billDetails.count - 1].grandTotal)")
                print("---------------------------------------------------------------------------------------")
                
            }
        }
    }
    
    
    func viewReceivedOrder(receivedOrder : [[BillDetails]] , billNumbers : [Int] , billConformedUser : [UserDetails])
    {
       

       
       
        for rowValue in 0..<receivedOrder.count
        {
            
            
            if rowValue != 0
            {
                
                print("Bill Number : \(billNumbers[rowValue - 1])")
                print("Name : \(billConformedUser[rowValue - 1].name)")
                print("Email : \(billConformedUser[rowValue - 1].email)")
                print("Mobile Number : \(billConformedUser[rowValue - 1].mobileNumber)")
                print("Address : \(billConformedUser[rowValue - 1].address)")
                print("City : \(billConformedUser[rowValue - 1].city)")
                
            }
            
            print("Date Of Order    |       Date Of Delivery        |   Product Id  |   Product Name    |   Category    |   Price   |   Quantity    |   Total Amount    ")
            
            
            for columnValue in 0..<receivedOrder[rowValue].count
            {
                print("\(receivedOrder[rowValue][columnValue].dateOfOrder!)     \(receivedOrder[rowValue][columnValue].dateOfDelivery!)            \(receivedOrder[rowValue][columnValue].productId)       \(receivedOrder[rowValue][columnValue].productName)     \(receivedOrder[rowValue][columnValue].category)        \(receivedOrder[rowValue][columnValue].price)       \(receivedOrder[rowValue][columnValue].quantity)        \(receivedOrder[rowValue][columnValue].totalAmount)")
                                

                      
                
                if columnValue == receivedOrder[rowValue].count - 1
                {
                    print("             Grand Total                 : \(receivedOrder[rowValue][columnValue].grandTotal)")
                }
                
            }
            
            print()
            print()
        }
    
    }
    
    func viewCancelOrder(canceledBillNumbers : [Int] , billCanceledBydUser : [UserDetails] , cancelOrderByUser : [[BillDetails]])
    {
        
        
      
            for rowValue in 0..<cancelOrderByUser.count
        {
                
                
                if rowValue != 0
                {
                    
                    print("Bill Number : \(canceledBillNumbers[rowValue - 1])")
                    print("Name : \(billCanceledBydUser[rowValue - 1].name)")
                    print("Email : \(billCanceledBydUser[rowValue - 1].email)")
                    print("Mobile Number : \(billCanceledBydUser[rowValue - 1].mobileNumber)")
                    print("Address : \(billCanceledBydUser[rowValue - 1].address)")
                    print("City : \(billCanceledBydUser[rowValue - 1].city)")
                    
                }
                
                
                print("Date Of Order    |       Date Of Delivery        |   Product Id  |   Product Name    |   Category    |   Price   |   Quantity    |   Total Amount    ")
                
                for columnValue in 0..<cancelOrderByUser[rowValue].count
                {
                    print("\(cancelOrderByUser[rowValue][columnValue].dateOfOrder!)     \(cancelOrderByUser[rowValue][columnValue].dateOfDelivery!)            \(cancelOrderByUser[rowValue][columnValue].productId)       \(cancelOrderByUser[rowValue][columnValue].productName)     \(cancelOrderByUser[rowValue][columnValue].category)        \(cancelOrderByUser[rowValue][columnValue].price)       \(cancelOrderByUser[rowValue][columnValue].quantity)        \(cancelOrderByUser[rowValue][columnValue].totalAmount)")
                    
                    if columnValue == cancelOrderByUser[rowValue].count - 1
                    {
                        print("             Grand Total                 : \(cancelOrderByUser[rowValue][columnValue].grandTotal)")
                    }
            
                }
                
                print()
                print()
            }
        
           
        
    }
    
    
    
}
