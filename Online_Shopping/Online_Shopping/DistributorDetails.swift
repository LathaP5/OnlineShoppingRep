//
//  DistributorDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 06/03/23.
//

import Foundation

class DistributorDetails : SignUpDetails
{
    var name: String = ""
    
    var email: String = ""
    
    var mobileNumber: Int = 0
    
    var securityQuestion: String = ""
    
    var answer: String = ""
    
    var userId: String = ""
    
    var password: String = ""
    
}


class  DistributorTableDetails
{
    
    var tableName: String
    
    var fieldNames : [String] = []
    
    
    var condition : String = ""
    init()
    {
    tableName = "DestributorDetails"
    fieldNames = ["name" , "email" , "mobileNumber" , "securityQuestion" , "answer" , "userId" , "password"]
        let createQuery = "create table if not exists \(tableName)(name text , email text not null unique, mobileNumber real , securityQuestion text , answer text , userId text not null unique , password text);"

   
        
    
     SqliteDatabase.getObject().createTable(createQuery: createQuery)
  
        
    }
    
    func insertValueDetails(distributor : DistributorDetails)
    {
        var values : [Any] = []
        
        values.append(distributor.name)
        values.append(distributor.email)
        values.append(distributor.mobileNumber)
        values.append(distributor.securityQuestion)
        values.append(distributor.answer)
        values.append(distributor.userId)
        values.append(distributor.password)
        
       
        SqliteDatabase.getObject().insertRecord(tableName : tableName ,fieldNames : fieldNames ,values: values)
        
    }
  
    func viewAllProducts()
    {
        fieldNames = ["productId" , "productName" , "category" , "price" , "active"]
        condition = ""
       
        SqliteDatabase.getObject().retriveRecords(tableName: tableName, retriveColumns: fieldNames, condition: condition)
    }
    
    
    func checkProductAvailablity(productId : Int) -> (Int , String , String , Int , String)
    {
        
        let values = SqliteDatabase.getObject().checkProductAvailablity(tableName: tableName, productId: productId)
        print(values.0)
        print(values.1)
        print(values.2)
        print(values.3)
        print(values.4)
        return values
    }
    
   
    func checkUserId(userId : String) -> Bool
    {
        
        if SqliteDatabase.getObject().checkRecord(tableName : tableName , userId : userId)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func updatePassword(userId : String)
    {
        
        let values = SqliteDatabase.getObject().getUserParticularRecord(tableName: tableName, userId: userId)
        
        func showQuestionAgain()
        {
            print(values.0)
            let answer = UserInput.getAnswer()
            
            if answer == values.1
            {
                var updateColumnDetails : [String] = []
                let operation : String = ""
                var condition : [String] = []
                
                let password = UserInput.getPassword()
                
                updateColumnDetails.append("password = '\(password)'")
                condition.append("userId = '\(userId)'")
                
                SqliteDatabase.getObject().updateRecords(tableName: tableName, updateColumnDetails: updateColumnDetails, operation: operation, condition: condition)
            }
            else
            {
                print("your security question is was wrong so try again")
                showQuestionAgain()
            }
        }
        showQuestionAgain()
        
        
    }
    
    
    func checkUserIdAndPasasword(userId : String , password : String) -> Bool
    {
            if SqliteDatabase.getObject().checkRecord(tableName : tableName , userId : userId , password : password)
        {
            return true
        }
        else
        {
            return false
        }
    }

    
    
}
                                        
