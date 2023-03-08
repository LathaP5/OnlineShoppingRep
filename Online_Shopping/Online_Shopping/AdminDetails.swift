//
//  AdminDEtails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 26/02/23.
//

import Foundation

class AdminDetails : SignUpDetails
{
    var name: String = ""
    
    var email: String = ""
    
    var mobileNumber: Int = 0
    
    var securityQuestion: String = ""
    
    var answer: String = ""
    
    var userId: String = ""
    
    var password: String = ""
    
    
}

class AdminTableDetails
{
   
    var tableName: String
    
    init()
    {
    tableName = "AdminDetails"
    let createQuery = "create table if not exists \(tableName)(name text , email text not null unique, securityQuestion text , answer text , userId text not null unique , password text);"
    
        SqliteDatabase.getObject().createTable(createQuery: createQuery)
    }
    
    func insertValueDetails(admin : AdminDetails)
    {
        var values : [Any] = []
        
        let fieldNames = ["name" , "email" , "securityQuestion" , "answer" , "userId" , "password"]
        
        values.append(admin.name)
        values.append(admin.email)
        values.append(admin.securityQuestion)
        values.append(admin.answer)
        values.append(admin.userId)
        values.append(admin.password)
        
       
        SqliteDatabase.getObject().insertRecord(tableName : tableName ,fieldNames : fieldNames ,values: values)
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
        
        var values = SqliteDatabase.getObject().getUserParticularRecord(tableName: tableName, userId: userId)
        
        func showQuestionAgain()
        {
            print(values.0)
            var answer = UserInput.getAnswer()
            
            if answer == values.1
            {
                var updateColumnDetails : [String] = []
                var operation : String = ""
                var condition : [String] = []
                
                var password = UserInput.getPassword()
                
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
    
    
    
    
    
}
