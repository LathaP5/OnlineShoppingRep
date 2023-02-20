//
//  main.swift
//  Online_Shopping_Application
//
//  Created by latha-16226 on 14/02/23.
//

import Foundation


class OnlineShopping
{
    var userDetails : [UserDetails]
    var productDetails : [ProductDetails]
    var receivedOrder :  [[BillDetails]] = [[]]
    var billConformedUser : [UserDetails] = []
    
    
    var billNumbers : [Int] = []
    
    var canceledBillNumbers : [Int] = []
    var billCanceledBydUser : [UserDetails] = []
    var cancelOrderByUser :  [[BillDetails]] = [[]]
    
    
    var billNumber : Int
    init()
    {
        print("-----------------------------------------------------------------------")
        print("                  Welcome to Online Shopping Management                ")
        print("-----------------------------------------------------------------------")
        
        userDetails = []
        productDetails = []
        billNumber = 1000
        
    }
    func menus()throws
    {
        repeat
        {
            
            print("select 1 for user and 2 for admin")
            var choice = Int(readLine()!)!
            
            
            if choice == 1
                
            {
                print("1.SignUp")
                print("2.Login")
                print("3.Forgot password")
                
                print("Choose the Anyone , if you want signup press 1 and 2 for login , 3 for forgot password")
                var userLoginChoice = Int(readLine()!)!
                
                if userLoginChoice == 1
                {
                    var user = UserDetails()
                    print("Enter name , email , mobile number")
                    user.name = readLine()!
                    user.email = readLine()!
                    user.mobileNumber = Int(readLine()!)!
                    
                    print("Security questions are")
                    print("1. What is favourite color?")
                    print("2. What was your first car?")
                    print("3. What is the name of the town where you were born?")
                    print("4. What is your memorable day in your life?")
                    
                    print("Choose the security question number")
                    var questuionNumber = Int(readLine()!)!
                    
                    if questuionNumber == 1
                    {
                        user.securityQuestion = "What is favourite color?"
                    }
                    else if questuionNumber == 2
                    {
                        user.securityQuestion = "What was your first car?"
                    }
                    else if questuionNumber == 3
                    {
                        user.securityQuestion = "What is the name of the town where you were born?"
                    }
                    else if questuionNumber == 4
                    {
                        user.securityQuestion = "What is your memorable day in your life?"
                    }
                    
                    print("After selecting the question number say the answer for that")
                    user.answer = readLine()!
                    
                    print("Enter user name , password with the length of 5")
                    user.userName = readLine()!
                    user.password = readLine()!
                    
                    print("Enter address , city , state , country")
                    user.address = readLine()!
                    user.city = readLine()!
                    user.state = readLine()!
                    user.country = readLine()!
                    
                    userDetails.append(user)
                }
                else if userLoginChoice == 2
                {
                    
                    func userLogin()throws
                    {
                        
                        var purchaseOrderDetails : [PurchaseOrderDetails] = []
                        
                        print("Enter user name and password")
                        var userName = readLine()!
                        var password = readLine()!
                        var loginForm = LoginForm()
                        var billDetails : [BillDetails] = []
                        
                        do
                        {
                            try loginForm.checkUserDetails(userDetails : userDetails , userName : userName , password : password)
                            
                            
                            print("1. view all the product")
                            print("2. order the product")
                            print("3. view the ordered product")
                            print("4. change the ordered product")
                            print("5. cancel the ordered product")
                            print("6. generate the bill")
                            print("7. cancel the order")
                            print("8. edit the profile details")
                            
                            repeat
                            {
                                
                                print("Enter the which operartion you want to perform?")
                                var operation = Int(readLine()!)!
                                
                                if operation == 1
                                {
                                    var view = View()
                                    view.viewAllProducts(productDetails: productDetails)
                                }
                                else if operation == 2
                                {
                                    var order = OrderDetails()
                                    order.orderProduct(productDetails: productDetails , purchaseOrderDetails : &purchaseOrderDetails)
                                }
                                else if operation == 3
                                {
                                    var view = View()
                                    view.viewOrderedProducts(purchaseOrderDetails : purchaseOrderDetails)
                                }
                                else if operation == 4
                                {
                                    var changeOrCancelDetails = ChangeOrCancelDetails()
                                    changeOrCancelDetails.changeProduct(purchaseOrderDetails : purchaseOrderDetails)
                                }
                                else if operation == 5
                                {
                                  var changeOrCancelDetails = ChangeOrCancelDetails()
                                    changeOrCancelDetails.cancelProduct(purchaseOrderDetails : &purchaseOrderDetails)
                              
                                }
                                else if operation == 6
                                {
                                    var generateBill = GenerateBill()
                                    billDetails = generateBill.calculateTotal(purchaseOrderDetails : purchaseOrderDetails)
                                    
                                    receivedOrder.append(billDetails)
                                    
                                    purchaseOrderDetails = []
                                    var view = View()
                                    billNumbers.append(billNumber)
                                    view.showBill(billNumber: &billNumber, billDetails: billDetails , userName : userName , password : password , userDetails : userDetails)
                        
                                    
                                    for user in userDetails
                                    {
                                        if user.userName == userName && user.password == password
                                        {
                                            billConformedUser.append(user)
                                        }
                                    }

                                    
                                    billNumber = billNumber + 1
                                    
                                   
                                }
                                else if operation == 7
                                {
                                    var cancelOrder = CancelOrder()
                                    cancelOrder.orderCancel(receivedOrder : &receivedOrder , billNumbers : &billNumbers , billConformedUser : &billConformedUser , canceledBillNumbers : &canceledBillNumbers , billCanceledBydUser : &billCanceledBydUser , cancelOrderByUser : &cancelOrderByUser)
                                    
                                }
                                else if operation == 8
                                {
                                    
                                }
                                print("Do you perform another one operation?")
                            }while readLine()! == "Yes"
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            print("Do you try again?")
                            if readLine()! == "Yes"
                            {
                                try userLogin()
                            }
                        }
                    }
                    try userLogin()
                }
                else if userLoginChoice == 3
                {
                    func loginForChangePassword()throws
                    {
                        print("Enter the user name and email")
                        var userName = readLine()!
                        var email = readLine()!
                        
                        var loginForm = LoginForm()
                        do
                        {
                            try loginForm.checkForgotDetails(userDetails : userDetails , userName: userName , email : email)
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            print("Do you try again?")
                            if readLine()! == "Yes"
                            {
                                try loginForChangePassword()
                            }
                        }
                    }
                    try loginForChangePassword()
                    
                }
                
            }
            else if choice == 2
            {
                
                func adminLogin()throws
                {
                    print("Enter admin user name and password")
                    var userName = readLine()!
                    var password = readLine()!
                    
                    var loginForm = LoginForm()
                    do
                    {
                        try loginForm.checkAdminDetails(userName: userName, password: password)
                        
                        
                        print("1. Add the product")
                        print("2. Update the product")
                        print("3. View the all products")
                        print("4. View the received order")
                        print("5. View the cancel order")
                       
                        
                        repeat
                        {
                            
                            print("Enter the which operation you want to perform?")
                            var operation = Int(readLine()!)!
                            
                            if operation == 1
                            {
                                repeat
                                {
                                    
                                    var product = ProductDetails()
                                    
                                    var temp = 0
                                    
                                    print("Enter the product id")
                                    var productIdNumber = Int(readLine()!)!
                                    
                                    
                                    for detail in productDetails
                                    {
                                        if detail.productId == productIdNumber
                                        {
                                            temp = 1
                                        }
                                        
                                    }
                                    
                                    if temp == 0
                                    {
                                        
                                        product.productId = productIdNumber
                                        
                                        print("Enter product name , category , price , active")
                                        product.productName = readLine()!
                                        product.category = readLine()!
                                        product.price = Int(readLine()!)!
                                        product.active = readLine()!
                                        
                                        
                                        productDetails.append(product)
                                        
                                    }
                                    else
                                    {
                                        print("Your product Id was already exist")
                                    }
                                    print("Do you want to add another one product?")
                                }while readLine()! == "Yes"
                                        
                            }
                            else if operation == 2
                            {
                                repeat
                                {
                                    print("Enter which product id and product name you want to update?")
                                    var oldProductId = Int(readLine()!)!
                                    var oldProductName = readLine()!
                                    
                                    
                                    print("Enter the new price , active state")
                                    var newPrice = Int(readLine()!)!
                                    var newActive = readLine()!
                                    
                                    var updateDetails = UpdateDetails()
                                    updateDetails.updateProduct(oldProductId : oldProductId , oldProductName : oldProductName , newPrice : newPrice , newActive : newActive , productDetails : productDetails)
                                    
                                    print("Do you want to update a product again?")
                                }while readLine()! == "Yes"
                                        
                            }
                            else if operation == 3
                            {
                                var view = View()
                                view.viewAllProducts(productDetails : productDetails)
                            }
                            else if operation == 4
                            {
                                var view = View()
                                view.viewReceivedOrder(receivedOrder : receivedOrder , billNumbers : billNumbers , billConformedUser : billConformedUser)
                            }
                            else if operation == 5
                            {
                               var view = View()
                                view.viewCancelOrder(canceledBillNumbers : canceledBillNumbers , billCanceledBydUser : billCanceledBydUser , cancelOrderByUser : cancelOrderByUser)
                            
                            }
                            
                            print("Do you want to do another one operation again?")
                        }while readLine()! == "Yes"
                                
                                
                    }
                    catch let error as LoginFormValidationError
                    {
                        print(error.errorMessage)
                        print("Do you try again?")
                        if readLine()! == "Yes"
                        {
                            try adminLogin()
                        }
                    }
                    
                }
                try adminLogin()
                
                
            }
            
            print("Do you want continue again?")
        }while readLine()! == "Yes"
    }
}


var onlineShopping = OnlineShopping()
try onlineShopping.menus()
