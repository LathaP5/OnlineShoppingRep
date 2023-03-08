//
//  OnllineShopping.swift
//  Online_Shopping
//
//  Created by latha-16226 on 23/02/23.
//

import Foundation

class OnlineShopping
{
    var userDetails : UserTableDetails
    var adminDetails : AdminTableDetails
    var productDetails : ProductTableDetails
    var billTableDetails : BillTableDetails
    var distributorDetails : DistributorTableDetails
    
    
    var userAddressDetail = UserAddressDetails()
   
    var billNumbers : [Int] = []
    var storeZuId : Int = 0
    var storeBillNumber : Int = 0
   
    
    
    var continueOptionValue : Bool?
    var billNumber : Int = 0
    var zuId : Int
    var billNumberAndZuIdAndOrderId : (Int , Int , Int)
    var orderId : Int = 0
    
    init()
    {
        userDetails = UserTableDetails()
        adminDetails = AdminTableDetails()
        productDetails = ProductTableDetails()
        billTableDetails = BillTableDetails()
        distributorDetails = DistributorTableDetails()
        
        View.showWelcomeMessage()
        billNumberAndZuIdAndOrderId = billTableDetails.getBillNumberAndZuIdAndOrderId()
        storeBillNumber = billNumberAndZuIdAndOrderId.0
        zuId = billNumberAndZuIdAndOrderId.1
        storeZuId = zuId
        orderId = billNumberAndZuIdAndOrderId.2
        
    }
    func menus()throws
    {
        repeat
        {
            let choice = UserInput.getChoice()
            
            
            if choice == 1
                
            {
                View.showOptions()
                
                let userChoice = UserInput.getUserChoice()
                
                if userChoice == 1
                {
                    let user = UserDetails()
                    
                    user.name = UserInput.getName()
                    user.email = UserInput.getEmail()
                    user.mobileNumber = UserInput.getMobileNumber()
                    
                    
                    let questuionNumber = UserInput.getSecurityQuestionNumber()
                    
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
                    
                    
                    user.answer = UserInput.getAnswer()
                    user.userId = UserInput.getUserId()
                    user.password = UserInput.getPassword()
                     
                  
                    userDetails.insertValueDetails(user : user)
                    
                }
                else if userChoice == 2
                {
                    
                    func userLogin()throws
                    {
                        
                        var purchaseOrderDetails : [PurchaseOrderDetails] = []
                        
                        
                        let userId = UserInput.getUserId()
                        let password = UserInput.getPassword()
                        let loginForm = LoginForm()
                        var billDetails : [BillDetails] = []
                        
                        do
                        {
                            try loginForm.checkUserDetail(userDetails : userDetails , userId : userId , password : password)
                            
                            
                            repeat
                            {
                                
                                View.showUserLoginOperations()
                                
                                let operation = UserInput.getUserOptionValue()
                                
                                if operation == 1
                                {
                                    
                                    productDetails.viewAllProducts()
                                }
                                else if operation == 2
                                {
                                   
                                    
                                    let category = UserInput.getCategory()
                                    let filter = Filter()
                                    let productIds = filter.filterProductInCategoryWise(productDetails: productDetails, category: category)
                                    
                                
                                    
                                    if UserInput.getOrderChoice()
                                    {
                                        let order = OrderDetails()
                                        order.orderProductCategoryWise(productDetails: productDetails , purchaseOrderDetails : &purchaseOrderDetails , productIds : productIds)
                                    }
                                }
                                else if operation == 3
                                {
                                  
                                    
                                    let fromRange = UserInput.getStartingPrice()
                                    let toRange = UserInput.getEndingPrice()
                                    
                                    let category = UserInput.getCategory()
                                    
                                    let filter = Filter()
                                    
                                    let productIds = filter.filterProductInPriceWise(productDetails: productDetails, fromRange:  fromRange , toRange:  toRange , category:  category)
                                  
                                    if UserInput.getOrderChoice()
                                    {
                                        let order = OrderDetails()
                                        order.orderProductCategoryWise(productDetails: productDetails , purchaseOrderDetails : &purchaseOrderDetails , productIds : productIds)
                                    }
                                }
                                else if operation == 4
                                {
                                    let order = OrderDetails()
                                    order.orderProduct(productDetails: productDetails , purchaseOrderDetails : &purchaseOrderDetails)
            
                                }
                                else if operation == 5
                                {
                                    let view = View()
                                    view.viewOrderedProducts(purchaseOrderDetails : purchaseOrderDetails)
                                }
                                else if operation == 6
                                {
                                    let view = View()
                                    let changeOrCancelDetails = ChangeOrCancelDetails()
                                    view.viewOrderedProducts(purchaseOrderDetails : purchaseOrderDetails)
                                    changeOrCancelDetails.changeProduct(purchaseOrderDetails : purchaseOrderDetails)
                                }
                                else if operation == 7
                                {
                                    let view = View()
                                    let changeOrCancelDetails = ChangeOrCancelDetails()
                                    view.viewOrderedProducts(purchaseOrderDetails : purchaseOrderDetails)
                                    changeOrCancelDetails.cancelProduct(purchaseOrderDetails : &purchaseOrderDetails)
                              
                                }
                                else if operation == 8
                                {
                                    let generateBill = GenerateBill()
                                    let orderDeliveryDate = OrderDeliveryDate()
                                    userAddressDetail = UserAddressDetails()
                                    let orderDateDetail = OrderDateDetails()
                                    
                                    billDetails = generateBill.calculateTotal(purchaseOrderDetails : purchaseOrderDetails)
                                    
                                    Thread.sleep(forTimeInterval: 2)
                                    View.showOrderId(orderId : orderId)
                                    
                                    if !billDetails.isEmpty
                                    {
                                        var id : Int = 1
                                        let user = billTableDetails.checkUser(userId: userId)
                                        
                                        if user.isEmpty
                                        {
                                            zuId = zuId + 1
                                            storeZuId = zuId
                                            userAddressDetail.address = UserInput.getAddress()
                                            userAddressDetail.district = UserInput.getDistrict()
                                            userAddressDetail.state = UserInput.getState()
                                            billTableDetails.addAddress(userId : userId , userAddressDetail : userAddressDetail , zuId : zuId)
                                       }
                                       else
                                        {
                                           if UserInput.getAddressConfirmation()
                                           {
                                               userAddressDetail.address = user[1]
                                               userAddressDetail.district = user[2]
                                               userAddressDetail.state = user[3]
                                               zuId = Int(user[4])!
                                            }
                                           else
                                           {
                                               
                                               userAddressDetail.address = UserInput.getAddress()
                                               userAddressDetail.district = UserInput.getDistrict()
                                               userAddressDetail.state = UserInput.getState()
                                               id = 0
                                           }
                                        }
                                        
                                        orderDateDetail.dateOfOrder = Date()
                    
                                        let dateOfDelivery = orderDeliveryDate.generateDeliveryDate(district : userAddressDetail.district)
                                                                                                    
                                        orderDateDetail.dateOfDelivery = dateOfDelivery
                                        orderDateDetail.status = "order processed"
                                       
                                        purchaseOrderDetails = []
                                        let view = View()
                                       
                                        
                                        billTableDetails.insertBillNumberAndUserIdAndOrderId(billNumber: storeBillNumber, userId: userId , orderId: orderId)
                                        
                                        
                                        let values = userDetails.getUserRecord(userId : userId , password : password)
                                        
                                        print("Your bill was generated successfullly")
                                        view.showBill(billNumber: storeBillNumber, billDetails: billDetails , userId : userId , password : password , values : values , userAddressDetail : userAddressDetail , orderDateDetail : orderDateDetail)
                                        
                                       if id != 0
                                        {
                                           billTableDetails.insertValueDetails(billNumber: storeBillNumber, billDetails : billDetails , userId : userId , password : password , userAddressDetail : userAddressDetail , orderDateDetail : orderDateDetail , addressId : zuId)
                                       }
                                      else
                                        {
                                          billTableDetails.insertValueDetails(billNumber: storeBillNumber, billDetails : billDetails , userId : userId , password : password , userAddressDetail : userAddressDetail , orderDateDetail : orderDateDetail , addressId : id)
                                        }
           
                                       
                                        
                                        billTableDetails.insertBillNumberAndUserIdAndOrderId(billNumber: storeBillNumber, userId : userId , orderId:  orderId)
                                        
                                        storeBillNumber = storeBillNumber + 1
                                        orderId = orderId + 1
                                        
                                        billTableDetails.updateBillNumber(billNumber : storeBillNumber, zuId : storeZuId , orderId:  orderId)
                                    }
                                    
                                    
                                    
                                   
                                }
                                
                                else if operation == 9
                                {
                                    let cancelOrder = CancelOrder()
                                    billTableDetails.viewOrderHistory(userId : userId)
                                    cancelOrder.orderCancel(billTableDetails : billTableDetails , userId : userId)
                                    
                                }
                                
                                 
                                
                                
                                else if operation == 10
                                {
                                    
                                    userDetails.editMobileNumber(userId : userId , password:  password)
                                    
                                    
                                    if billTableDetails.checkUserId(userId: userId)
                                    
                                    {
                                        userAddressDetail = UserAddressDetails()
                                        if UserInput.getEditChoice()
                                        {
                                            userAddressDetail.address = UserInput.getAddress()
                                            userAddressDetail.district = UserInput.getDistrict()
                                            userAddressDetail.state = UserInput.getState()
                                            
                                            billTableDetails.editPermanentAddress(userId : userId , userAddressDetail:  userAddressDetail)
                                        }
                                    }
                                    else
                                    {
                                        View.showErrorMessage()
                                    }
                                    
                                }
                                else if operation == 11
                                {
                                    billTableDetails.viewOrderHistory(userId : userId)
                                    billTableDetails.viewCancelOrderHistory(userId : userId)
                                    
                                }
                                else if operation == 12
                                {
                                    var conformationValue = UserInput.getLogoutConformationMessage()
                                    if conformationValue == true
                                    {
                                        break
                                    }
                                }
                               
                                continueOptionValue = UserInput.getUserContinueOptionValue()
                                if continueOptionValue == false
                                {
                                    var conformationValue = UserInput.getLogoutConformationMessage()
                                    if conformationValue == true
                                    {
                                        break
                                    }
                                }
                            }while continueOptionValue!
                                    
                                
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            
                            if UserInput.getUserLoginTryOption()
                            {
                                try userLogin()
                            }
                        }
                    }
                    try userLogin()
                }
                else if userChoice == 3
                {
                    
                    func loginForChangePassword()throws
                    {
                        let userId = UserInput.getUserId()
                        
                        let loginForm = LoginForm()
                        do
                        {
                            try loginForm.checkForgotDetails(userDetails: userDetails, userId: userId)
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            if UserInput.getUserLoginTryOption()
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
                View.showOptions()
                
                let adminChoice = UserInput.getAdminChoice()
                
                if adminChoice == 1
                {
                    let admin = AdminDetails()
                    
                    admin.name = UserInput.getName()
                    admin.email = UserInput.getEmail()
                    
                    
                    
                    let questuionNumber = UserInput.getSecurityQuestionNumber()
                    
                    if questuionNumber == 1
                    {
                        admin.securityQuestion = "What is favourite color?"
                    }
                    else if questuionNumber == 2
                    {
                        admin.securityQuestion = "What was your first car?"
                    }
                    else if questuionNumber == 3
                    {
                        admin.securityQuestion = "What is the name of the town where you were born?"
                    }
                    else if questuionNumber == 4
                    {
                        admin.securityQuestion = "What is your memorable day in your life?"
                    }
                    
                    
                    admin.answer = UserInput.getAnswer()
                   
                    admin.userId = UserInput.getUserId()
                    
                    admin.password = UserInput.getPassword()
                    
                    adminDetails.insertValueDetails(admin: admin)
                   
                }
                
                else if adminChoice == 2
                {
                    
                    func adminLogin()throws
                    {
                        
                        let userId = UserInput.getUserId()
                        let password = UserInput.getPassword()
                        
                        let loginForm = LoginForm()
                        do
                        {
                            try loginForm.checkAdminDetail(adminDetails : adminDetails , userId : userId , password : password)
                           
                           
                            
                            repeat
                            {
                                View.showAdminLoginOperations()
                                
                                let operation = UserInput.getAdminOptionValue()
                                
                                if operation == 1
                                {
                                    repeat
                                    {
                                        
                                        let product = ProductDetails()
                                        var productId = UserInput.getProductId()
                                        product.productId = productId
                                        product.productName = UserInput.getProductName()
                                        product.category = UserInput.getCategory()
                                        product.price = UserInput.getPrice()
                                        product.active = UserInput.getActive()
                                        
                                        productDetails.insertValueDetails(product : product)
                                        
                                        
                                        let adminProductDetail = AdminProductDetails()
                                        
                                        adminProductDetail.userId = userId
                                        adminProductDetail.productId = productId
                                        
                                       
                      
                                        productDetails.insertAdminWithProductDetail(adminProductDetail : adminProductDetail)
                                        
                                        
                                        
                                    }while UserInput.getAdminAddProductOption()
                                            
                                }
                               
                                else if operation == 2
                                {
                                    repeat
                                    {
                                       
                                        var productIds = productDetails.getAdminWiseProductId(userId : userId)
                                        
                                        
                                        let updateDetails = UpdateDetails()
                                        productDetails.getAdminWiseProductDetails(productIds : productIds)
                                        let oldProductId = UserInput.getProductId()
                                        
                                        updateDetails.updateProduct(oldProductId : oldProductId , productDetails : productDetails , productIds : productIds)
                                        
                                        productDetails.getAdminWiseProductDetails(productIds : productIds)
                                        
                                    }while UserInput.getAdminUpdateProductOption()
                                            
                                }
                                
                                
                                else if operation == 3
                                {
                                   
                                    productDetails.viewAllProducts()
                                }
                                
                                else if operation == 4
                                {
                                    var conformationValue = UserInput.getLogoutConformationMessage()
                                    if conformationValue == true
                                    {
                                        break
                                    }
                                }
                                
                                continueOptionValue = UserInput.getUserContinueOptionValue()
                                if continueOptionValue == false
                                {
                                    var conformationValue = UserInput.getLogoutConformationMessage()
                                    if conformationValue == true
                                    {
                                        break
                                    }
                                }
                            }while continueOptionValue!
                                    
                                    
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            
                            if UserInput.getAdminLoginTryOption()
                            {
                                try adminLogin()
                            }
                        }
                        
                    }
                    try adminLogin()
                    
                }
                
                else if adminChoice == 3
                            
                {
                   
                    func loginForChangePassword()throws
                    {
                        let userId = UserInput.getUserId()
                        
                        let loginForm = LoginForm()
                        do
                        {
                            try loginForm.checkForgotDetails(adminDetails: adminDetails, userId: userId)
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            if UserInput.getUserLoginTryOption()
                            {
                                try loginForChangePassword()
                            }
                        }
                    }
                    try loginForChangePassword()
             
                }
                
            }
            else if choice == 3
            {
                
                View.showOptions()
                
                let distributorChoice = UserInput.getDistributorChoice()
                
                if distributorChoice == 1
                {
                    let distributor = DistributorDetails()
                    
                    distributor.name = UserInput.getName()
                    distributor.email = UserInput.getEmail()
                    distributor.mobileNumber = UserInput.getMobileNumber()
                    
                    let questuionNumber = UserInput.getSecurityQuestionNumber()
                    
                    if questuionNumber == 1
                    {
                        distributor.securityQuestion = "What is favourite color?"
                    }
                    else if questuionNumber == 2
                    {
                        distributor.securityQuestion = "What was your first car?"
                    }
                    else if questuionNumber == 3
                    {
                        distributor.securityQuestion = "What is the name of the town where you were born?"
                    }
                    else if questuionNumber == 4
                    {
                        distributor.securityQuestion = "What is your memorable day in your life?"
                    }
                    
                    
                    distributor.answer = UserInput.getAnswer()
                   
                    distributor.userId = UserInput.getUserId()
                    
                    distributor.password = UserInput.getPassword()
                    
                    distributorDetails.insertValueDetails(distributor: distributor)
                   
                }
                
                else if distributorChoice == 2
                {
                    
                    func distributorLogin()throws
                    {
                        
                        let userId = UserInput.getUserId()
                        let password = UserInput.getPassword()
                        
                        let loginForm = LoginForm()
                        do
                        {
                            try loginForm.checkDestributorDetail(distributorDetails : distributorDetails , userId : userId , password : password)
                           
                           
                            
                            repeat
                            {
                                View.showDistributorLoginOperations()
                                
                                let operation = UserInput.getDistributorOptionValue()
                                
                                if operation == 1
                                {
                                    billTableDetails.getOrderedDetails()
                                            
                                }
                               
                                else if operation == 2
                                {
                                    billTableDetails.getCancelOrderedDetails()
                                            
                                }
                                
                                else if operation == 3
                                {
                                    billTableDetails.getDeliveryOrderedDetails()
                                }
                                
                                else if operation == 4
                                {
                                    var conformationValue = UserInput.getLogoutConformationMessage()
                                    if conformationValue == true
                                    {
                                        break
                                    }
                                }
                                
                                
                                continueOptionValue = UserInput.getUserContinueOptionValue()
                                if continueOptionValue == false
                                {
                                    var conformationValue = UserInput.getLogoutConformationMessage()
                                    if conformationValue == true
                                    {
                                        break
                                    }
                                }
                                
                            }while continueOptionValue!
                                    
                                    
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            
                            if UserInput.getDistributorLoginTryOption()
                            {
                                try distributorLogin()
                            }
                        }
                        
                    }
                    try distributorLogin()
                    
                }
                
                else if distributorChoice == 3
                            
                {
                   
                    func loginForChangePassword()throws
                    {
                        let userId = UserInput.getUserId()
                        
                        let loginForm = LoginForm()
                        do
                        {
                            try loginForm.checkForgotDetails(distributorDetails: distributorDetails, userId: userId)
                        }
                        catch let error as LoginFormValidationError
                        {
                            print(error.errorMessage)
                            if UserInput.getUserLoginTryOption()
                            {
                                try loginForChangePassword()
                            }
                        }
                    }
                    try loginForChangePassword()
             
                }
               
            }
            
        }while UserInput.getHomeOptionValue()
        
    
    }
   
}

