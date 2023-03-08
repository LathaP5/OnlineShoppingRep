//
//  Validation.swift
//  Online_Shopping
//
//  Created by latha-16226 on 06/03/23.
//

import Foundation


class InputValidation
{

static func checkChoice(choice : Int) -> Bool
{
    if choice >= 1 && choice <= 3
    {
        return true
    }
    else
    {
        return false
    }
}


static func checkUserChoice(choice : Int) -> Bool
{
    if choice >= 1 && choice <= 3
    {
        return true
    }
    else
    {
        return false
    }
}


    static func checkStringValue(stringValue : String)-> Bool
    {
        if stringValue != ""
        {
            
            return true
        }
        else
        {
            return false
        }
        
    }

    
    
    
    static func checkMobileNumber(mobileNumber : Int) -> Bool
    {
        
        if mobileNumber >= 0
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    
    static func checkQuestionNumber(questionNumber : Int) -> Bool
    {
        if questionNumber >= 1 && questionNumber <= 4
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    static func checkPassword(password : String) -> Bool
    {
        
        if password != "" && password.count == 5
        {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    
static func checkUserOptionValue(choice : Int) -> Bool
{
    if choice >= 1 && choice <= 12
    {
        return true
    }
    else
    {
        return false
    }
}



static func checkAdminChoice(choice : Int) -> Bool
{
    if choice >= 1 && choice <= 3
    {
        return true
    }
    else
    {
        return false
    }
}

static func checkAdminOptionValue(choice : Int) -> Bool
{
    if choice >= 1 && choice <= 4
    {
        return true
    }
    else
    {
        return false
    }
}




static func checkIntValue(intValue : Int) -> Bool
{
    
    if intValue > 0
    {
       return true
    }
    else
    {
        return false
    }
    
}






static func checkContinueOptionValue(continuationOptionValue : String) -> Bool
{
    
    if continuationOptionValue != ""
    {
        return true
    }
    else
    {
        return false
    }
}


static func checkContinueOptionValue1(continuationOptionValue : String) -> Bool
{
    
    if (continuationOptionValue == "Y" || continuationOptionValue == "y" || continuationOptionValue == "Yes"||continuationOptionValue == "YES"||continuationOptionValue == "yes")
        
    {
        return true
    }
    else
    {
        return false
    }
    
}


}
