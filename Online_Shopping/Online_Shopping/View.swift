//
//  View.swift
//  Online_Shopping
//
//  Created by latha-16226 on 15/02/23.
//
import Foundation


class View
{
    
    func viewAllProducts(productDetails : [Any])
    {
        
          print("\(productDetails[0])         \(productDetails[1])         \(productDetails[2])         \(productDetails[3])         \(productDetails[4])")
    }
    
    func viewOrderedProducts(purchaseOrderDetails : [PurchaseOrderDetails])
    {
        print("Product Id       |       Product Name        |       Category        |       Price       |       Quantity")
        for product in purchaseOrderDetails
        {
            print("\(product.productId)         \(product.productName)         \(product.category)         \(product.price)         \(product.quantity)")
        }
    }
    
    
    func showBill(billNumber : Int , billDetails : [BillDetails] , userId : String , password : String , values :(String , String , Float) , userAddressDetail : UserAddressDetails , orderDateDetail : OrderDateDetails)
    {
        
                print("Your Bill Number : \(billNumber)")
                
                print("Your Name : \(values.0)")
                print("Your Email : \(values.1)")
                print("Your Mobile Number : \(values.2)")
                
                print("Your Address : \(userAddressDetail.address)")
                print("Your City : \(userAddressDetail.district)")
                
                print("Your Date Of Order : \(orderDateDetail.dateOfOrder!)")
                print("Your Date Of Delivery : \(orderDateDetail.dateOfDelivery!)")
                print("Order Status : \(orderDateDetail.status)")
                
                
                print("Product Id       |       Product Name        |       Category        |       Price       |       Quantity        |       Total Amount        ")
                for product in billDetails
                {
                    print("\(product.productId)         \(product.productName)         \(product.category)         \(product.price)         \(product.quantity)     \(product.totalAmount)")
                }
                print("---------------------------------------------------------------------------------------")
                print("               Grand total            :\(billDetails[billDetails.count - 1].grandTotal)")
                print("---------------------------------------------------------------------------------------")
                
         
    }
    
    
   
    func viewReceivedOrder(billDetails : [[Any]])
    {
        
        print(billDetails.count)
        
        for rowValue in 0..<billDetails.count
        {
            if rowValue == 0
            {
                print("Name : \(billDetails[rowValue][0])")
                print("Email : \(billDetails[rowValue][1])")
                print("Mobile Number : \(billDetails[rowValue][2])")
                print("Bill Number : \(billDetails[rowValue][3])")
                print("Date of Order : \(billDetails[rowValue][4])")
                print("Date of Delivery : \(billDetails[rowValue][5])")
                print("Status : \(billDetails[rowValue][6])")
                print("Address : \(billDetails[rowValue][7])")
                print("District : \(billDetails[rowValue][8])")
                print("State : \(billDetails[rowValue][9])")
                showHeading()
                
            }
            
            print("\(billDetails[rowValue][10])               \(billDetails[rowValue][11])                \(billDetails[rowValue][12])                 \(billDetails[rowValue][13])")
            
            if rowValue == billDetails.count - 1
            {
                print("---------------------------------------------------------------")
                print("              Grand total         :\(billDetails[rowValue][14])")
                print("---------------------------------------------------------------")
            }
            
        }
         
        
    }
    
   
  
    
    
   func viewDeliveryOrder(billDetails : [[Any]])
    {
        var temp = 0
        
        print(billDetails.count)
        
        for rowValue in 0..<billDetails.count
        {
            if rowValue == 0
            {
                
                let date = Date()
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd HH:mm"
                
                let dateOfDelivery = billDetails[rowValue][5]
                
                let deliveryDate = formatter.date(from: dateOfDelivery as! String)
                
                if date.timeIntervalSinceReferenceDate > deliveryDate!.timeIntervalSinceReferenceDate
                {
                    temp = 1
                    print("Name : \(billDetails[rowValue][0])")
                    print("Email : \(billDetails[rowValue][1])")
                    print("Mobile Number : \(billDetails[rowValue][2])")
                    print("Bill Number : \(billDetails[rowValue][3])")
                    print("Date of Order : \(billDetails[rowValue][4])")
                    print("Date of Delivery : \(billDetails[rowValue][5])")
                    print("Status : \(billDetails[rowValue][6])")
                    print("Address : \(billDetails[rowValue][7])")
                    print("District : \(billDetails[rowValue][8])")
                    print("State : \(billDetails[rowValue][9])")
                    showHeading()
                    
                }
                else
                {
                    print("all the received orders are ongoing processed")
                }
            }
            
            
            if temp == 1
            {
                print("\(billDetails[rowValue][10])               \(billDetails[rowValue][11])                \(billDetails[rowValue][12])                 \(billDetails[rowValue][13])")
                
                if rowValue == billDetails.count - 1
                {
                    print("---------------------------------------------------------------")
                    print("              Grand total         :\(billDetails[rowValue][14])")
                    print("---------------------------------------------------------------")
                }
            }
            
            
        }
          
    }
        
    
    
    static func showWelcomeMessage()
    {
        print("-----------------------------------------------------------------------")
        print("                  Welcome to Online Shopping Management                ")
        print("-----------------------------------------------------------------------")
        
    }
    
    static func showHomePageOptions()
    {
        print("1. User")
        print("2. Admin")
        print("3. Distributor")
    }

    static func showOptions()
    {
        print("1.SignUp")
        print("2.Login")
        print("3.Forgot password")
    }
    
    
    static func showSecurityQuestions()
    {
        print("Security questions are")
        print("1. What is favourite color?")
        print("2. What was your first car?")
        print("3. What is the name of the town where you were born?")
        print("4. What is your memorable day in your life?")
    }
    
    static func showUserLoginOperations()
    {
        print("1. View all the product")
        print("2. View the product in category wise")
        print("3. View the product in cost wise")
        print("4. Order the product")
        print("5. View the ordered product")
        print("6. Change the ordered product")
        print("7. Cancel the ordered product")
        print("8. Generate the bill")
        print("9. Cancel the order")
        print("10. Edit the profile details")
        print("11. View the old orders")
        print("12. Logout")
    }
    
    static func showAdminLoginOperations()
    {
        
        print("1. Add the product")
        print("2. Update the product")
        print("3. View the all products")
        print("4. Logout")
        
    }
    
    static func showDistributorLoginOperations()
    {
        print("1. View the received order")
        print("2. View the cancel order")
        print("3. Delivery order")
        print("4. Logout")
    }
    
    static func showUserLoginSuccessMessage()
    {
        print("User login successfully")
        print("welcome to user home page")
    }
    
    static func showAdminLoginSuccessMessage()
    {
        print("Admin login successfully")
        print("welcome to admin home page")
    }
    
    static func showDistributorLoginSuccessMessage()
    {
        print("Distributor login successfully")
        print("welcome to distributor home page")
    }
    
    
    static func showErrorMessage()
    {
        print("your userId and password not found")
    }
 
    
    static func showNotFoundBillNumberMessage()
    {
        print("your bill number was not found")
    }
 
    
    static func showProfileChangeSuccessMessage()
    {
        print("your profile data was changed successfully")
    }
    
    static func showMessage()
    {
        print("your date of delivery date is expired")
    }
    
    func showHeading()
    {
        print("Product Id  |   Quantity    |    Price   |   Total Amount    ")
    }
    
    static func showProductDetailsHeading()
    {
        print("Product Id       |       Product Name        |       Category        |       Price       |       Active")
    }
    static func showOrderId(orderId : Int)
    {
        print("Your order id is : \(orderId)")
    }
    
    
}
