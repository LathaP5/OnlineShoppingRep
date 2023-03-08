//
//  Validation.swift
//  Online_Shopping
//
//  Created by latha-16226 on 25/02/23.
//

import Foundation
class UserInput
{
    
    
    
    static func getChoice() -> Int {
        
        View.showHomePageOptions()
        if let choice = Int(readLine()!)
        {
            
            if InputValidation.checkChoice(choice: choice)
            {
                
                return choice
            }
        }
        print("Enter the valid number from 1 to 2")
        return getChoice()
    }
    
    
    static func getUserChoice() -> Int {
        
        print("Choose the Anyone")
        if let choice = Int(readLine()!)
        {
            
            if InputValidation.checkUserChoice(choice: choice)
            {
                
                return choice
            }
        }
        print("Enter the valid number from 1 to 3")
        return getUserChoice()
    }
    
    
    static func getName() -> String {
        
        print("Enter the name")
        if let name = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue : name)
            {
                
                return name
            }
        }
        print("Enter a valid name")
        return getName()
    }
    
    
    static func getEmail() -> String {
        
        print("Enter the email")
        if let email = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue : email)
            {
                
                return email
            }
        }
        print("Enter a valid email")
        return getEmail()
    }
    
    static func getMobileNumber() -> Int {
        
        print("Enter the mobile number with 10 digit")
        if let mobileNumber = Int(readLine()!)
        {
            
            if InputValidation.checkMobileNumber(mobileNumber : mobileNumber)
            {
                
                return mobileNumber
            }
        }
        print("Enter a mobile number with correct digit")
        return getMobileNumber()
    }
    
    
    static func getSecurityQuestionNumber() -> Int {
        
        View.showSecurityQuestions()
        
        print("Choose the security question number")
        if let questionNumber = Int(readLine()!)
        {
            
            if InputValidation.checkQuestionNumber(questionNumber : questionNumber)
            {
                
                return questionNumber
            }
        }
        print("Enter a valid question number")
        return getSecurityQuestionNumber()
    }
    
    static func getAnswer() -> String {
        
        print("Enter answer for the security question")
        if let answer = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue : answer)
            {
                
                return answer
            }
        }
        print("Enter a answer properly")
        return getAnswer()
    }
    
    
    static func getUserId() -> String {
        
        print("Enter the userId")
        if let userId = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue: userId)
            {
                
                return userId
            }
        }
        print("Enter a valid userId")
        return getUserId()
    }
    
    
    
    static func getPassword() -> String {
        
        print("Enter the password with 5 digit")
        if let password = readLine()
        {
            
            if InputValidation.checkPassword(password : password)
            {
                
                return password
            }
        }
        print("Enter a password with correct length")
        return getPassword()
    }
    
    
    static func getAddress() -> String {
        
        print("Enter the address")
        if let address = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue: address)
            {
                
                return address
            }
        }
        print("Enter a valid address")
        return getAddress()
    }
    
    static func getDistrict() -> String {
        
        print("Enter the district")
        if let city = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue: city)
            {
                
                return city
            }
        }
        print("Enter a valid district")
        return getDistrict()
    }
    
    static func getState() -> String {
        
        print("Enter the State")
        if let state = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue: state)
            {
                
                return state
            }
        }
        print("Enter a valid state")
        return getState()
    }
    
    static func getCountry() -> String {
        
        print("Enter the country")
        if let country = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue: country)
            {
                
                return country
            }
        }
        print("Enter a valid country")
        return getCountry()
    }
    
    
    static func getUserOptionValue() -> Int {
        
        
        print("Enter the which operartion you want to perform?")
        if let choice = Int(readLine()!)
        {
            
            if InputValidation.checkUserOptionValue(choice: choice)
            {
                
                return choice
            }
        }
        print("Enter the valid number from 1 to 12")
        return getUserOptionValue()
    }
    
    
    static func getUserContinueOptionValue() -> Bool
    {
        print("Do you want to perform another one operation? if you want to continue enter a proper value like Y or y or Yes or yes or YES")
        if let userContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : userContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : userContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        return getUserContinueOptionValue()
        
    }
    
    
    static func getUserLoginTryOption() -> Bool
    {
        print("Do you try again? if you want to try again enter a proper value like Y or y or Yes or yes or YES")
        if let userLoginTryOption = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : userLoginTryOption)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : userLoginTryOption)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        return getUserLoginTryOption()
        
    }
    
    static func getSecurityAnswerTryOption() -> Bool
    {
        print("Your security question answer was wrong")
        print("Do you try again? if you want to try again enter a proper value like Y or y or Yes or yes or YES")
        if let securityAnswerTryOption = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : securityAnswerTryOption)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : securityAnswerTryOption)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        return getSecurityAnswerTryOption()
        
    }
    
    static func getAdminOptionValue() -> Int {
        
        
        print("Enter the which operartion you want to perform?")
        if let choice = Int(readLine()!)
        {
            
            if InputValidation.checkAdminOptionValue(choice: choice)
            {
                
                return choice
            }
        }
        print("Enter the valid number from 1 to 4")
        return getAdminOptionValue()
    }
    
    static func getDistributorOptionValue() -> Int {
        
        
        print("Enter the which operartion you want to perform?")
        if let choice = Int(readLine()!)
        {
            
            if InputValidation.checkAdminOptionValue(choice: choice)
            {
                
                return choice
            }
        }
        print("Enter the valid number from 1 to 4")
        return getAdminOptionValue()
    }
    
   
    static func getProductId() -> Int
    {
        
        print("Enter the product id")
        if let productId = Int(readLine()!)
        {
            
            if InputValidation.checkIntValue(intValue : productId)
            {
                return productId
            }
        }
        
        print("Enter the valid product id")
        
        return getProductId()
    }
    

    static func getProductName() -> String {
        
        print("Enter the product name")
        if let productName = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue :  productName)
            {
                
                return productName
            }
        }
        print("Enter a valid product name")
        return getProductName()
    }
    
    static func getCategory() -> String {
        
        print("Enter the category")
        if let category = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue :  category)
            {
                
                return category
            }
        }
        print("Enter a valid category")
        return getCategory()
    }
    
    static func getPrice() -> Int {
        
        print("Enter the price")
        if let price = Int(readLine()!)
        {
            
            if InputValidation.checkIntValue(intValue: price)
            {
                
                return price
            }
        }
        print("Enter a valid price")
        return getPrice()
    }
    
    static func getStartingPrice() -> Int {
        
        print("Enter the starting price")
        if let price = Int(readLine()!)
        {
            
            if InputValidation.checkIntValue(intValue: price)
            {
                
                return price
            }
        }
        print("Enter a valid price")
        return getPrice()
    }
    
    static func getEndingPrice() -> Int {
        
        print("Enter the ending price")
        if let price = Int(readLine()!)
        {
            
            if InputValidation.checkIntValue(intValue: price)
            {
                
                return price
            }
        }
        print("Enter a valid price")
        return getPrice()
    }
    
    
    
    static func getActive() -> String {
        
        print("Enter the active")
        if let active = readLine()
        {
            
            if InputValidation.checkStringValue(stringValue :  active)
            {
                
                return active
            }
        }
        print("Enter a valid active")
        return getActive()
    }
    
    
    
    
    static func getAdminAddProductOption() -> Bool
    {
        
        print("Do you want to add another one product? if you want to add enter a proper value like Y or y or Yes or yes or YES")
        if let adminAddProductOption = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : adminAddProductOption)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : adminAddProductOption)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        print("Enter a valid value")
        return getAdminAddProductOption()
        
    }
    
    
    
   
    static func getAdminUpdateProductOption() -> Bool
    {
        
        print("Do you want to update another one product? if you want to update enter a proper value like Y or y or Yes or yes or YES")
        if let adminUpdateProductOption = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : adminUpdateProductOption)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : adminUpdateProductOption)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        print("Enter a valid value")
        return getAdminAddProductOption()
        
    }
    
    static func getAdminLoginTryOption() -> Bool
    {
        print("Do you try again? if you want to try again enter a proper value like Y or y or Yes or yes or YES")
        if let adminLoginTryOption = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : adminLoginTryOption)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : adminLoginTryOption)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        return getAdminLoginTryOption()
        
    }
    
    
    
    static func getAdminContinueOptionValue() -> Bool
    {
        print("Do you want to perform another one operation? if continue enter a proper value like Y or y or Yes or yes or YES")
        if let adminContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : adminContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : adminContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        return getAdminContinueOptionValue()
        
    }
    
    static func getDistributorContinueOptionValue() -> Bool
    {
        print("Do you want to perform another one operation? if continue enter a proper value like Y or y or Yes or yes or YES")
        if let adminContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : adminContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : adminContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        return getDistributorContinueOptionValue()
        
    }
  
    static func getDistributorLoginTryOption() -> Bool
    {
        print("Do you try again? if you want to try again enter a proper value like Y or y or Yes or yes or YES")
        if let adminLoginTryOption = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : adminLoginTryOption)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : adminLoginTryOption)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        return getAdminLoginTryOption()
        
    }
    
    
    
    static func getHomeOptionValue() -> Bool
    {
        print("Do you want to continue? if continue enter a proper value like Y or y or Yes or yes or YES")
        if let homeContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : homeContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : homeContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        print("Enter a proper value")
        return getHomeOptionValue()
        
    }
    
    static func getNumberOfQuantity() -> Int
    {
        print("Enter the number of quantity?")
        if let numberOfQuantity = Int(readLine()!)
        {
            
            if InputValidation.checkIntValue(intValue : numberOfQuantity)
            {
                return numberOfQuantity
            }
        }
        
        print("Enter the valid quantity")
        
        return getNumberOfQuantity()
    }
    
    static func getOrderProductContinueOption() -> Bool
    {
        
        print("Do you want to order another one product? if you want to order enter a proper value like Y or y or Yes or yes or YES")
        if let orderProductContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : orderProductContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : orderProductContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        print("Enter a proper value")
        return getOrderProductContinueOption()
        
    }
    
    static func getChangeProductContinueOption() -> Bool
    {
        
        print("Do you want to change the another one product quantity? if you want to change enter a proper value like Y or y or Yes or yes or YES")
        if let changeProductContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : changeProductContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : changeProductContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        print("Enter a proper value")
        return getChangeProductContinueOption()
        
    }
    
    
    
    static func getCancelProductContinueOption() -> Bool
    {
        
        print("Do you want to cancel the another one product? if you want to cancel enter a proper value like Y or y or Yes or yes or YES")
        if let cancelProductContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : cancelProductContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : cancelProductContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        
        return getCancelProductContinueOption()
        
    }
    
    
    static func getBillNumber() -> Int
    {
        print("Enter the bill number")
        if let billNumber = Int(readLine()!)
        {
            
            if InputValidation.checkIntValue(intValue : billNumber)
            {
                
                return billNumber
            }
        }
        print("Enter the valid number")
        return getBillNumber()
    }
    
    static func getCancelOrderContinueOption() -> Bool
    {
        
        print("Do you want to cancel the another one order? if you want to cancel enter a proper value like Y or y or Yes or yes or YES")
        if let cancelOrderContinuationOptionValue = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : cancelOrderContinuationOptionValue)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : cancelOrderContinuationOptionValue)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
            
        }
        
        return getCancelOrderContinueOption()
        
        
    }
    
    static func getAdminChoice() -> Int {
        
        print("Choose the Anyone , if you want signup press 1 and 2 for login , 3 for forgot password")
        if let choice = Int(readLine()!)
        {
            
            if InputValidation.checkAdminChoice(choice: choice)
            {
                
                return choice
            }
        }
        print("Enter the valid number from 1 to 3")
        return getAdminChoice()
    }
    
    
    
  
    
    static func getOrderChoice() -> Bool
    {
        print("Do you want to order the product? if you want to order enter a proper value like Y or y or Yes or yes or YES")
        if let orderChoice = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : orderChoice)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : orderChoice)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
        }
        return getOrderChoice()
    }
    
    static func getAddressConfirmation() -> Bool
    {
        print("Do you want to add permanent address for delivery? if you want to add enter a proper value like Y or y or Yes or yes or YES")
        if let orderChoice = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : orderChoice)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : orderChoice)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
        }
        return getAddressConfirmation()
    }
 
    
    static func getEditChoice() -> Bool
    {
        print("Do you want to edit permanent address for delivery? if you want to edit enter a proper value like Y or y or Yes or yes or YES")
        if let orderChoice = readLine()
        {
            
            if InputValidation.checkContinueOptionValue(continuationOptionValue : orderChoice)
            {
                
                if InputValidation.checkContinueOptionValue1(continuationOptionValue : orderChoice)
                {
                    return true
                }
                else
                {
                    return false
                }
            }
        }
        return getEditChoice()
    }
    
    
    
    static func getDistributorChoice() -> Int {
        
        print("Choose the Anyone")
        if let choice = Int(readLine()!)
        {
            
            if InputValidation.checkUserChoice(choice: choice)
            {
                
                return choice
            }
        }
        print("Enter the valid number from 1 to 3")
        return getDistributorChoice()
    }
    
    static func getLogoutConformationMessage() -> Bool
     {
         print("Surely do you want to log out from your account? if you want to log out enter a proper value like Y or y or Yes or yes or YES")
         if let choice = readLine()
         {
             
             if InputValidation.checkContinueOptionValue(continuationOptionValue : choice)
             {
                 
                 if InputValidation.checkContinueOptionValue1(continuationOptionValue : choice)
                 {
                     return true
                 }
                 else
                 {
                     return false
                 }
             }
         }
         return getLogoutConformationMessage()
     }
    
}

