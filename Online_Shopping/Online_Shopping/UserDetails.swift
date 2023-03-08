
import Foundation

protocol SignUpDetails
{
    var name : String {get set}
    var email : String {get set}
    var mobileNumber  : Int {get set}
    var securityQuestion : String {get set}
    var answer : String {get set}
    var userId : String {get set}
    var password : String {get set}
}


class UserDetails : SignUpDetails
{
    var name: String = ""
    
    var email: String = ""
    
    var mobileNumber: Int = 0
    
    var securityQuestion: String = ""
    
    var answer: String = ""
    
    var userId: String = ""
    
    var password: String = ""
    
    
}

class UserAddressDetails
{
    var address : String = ""
    var district : String = ""
    var state : String = ""
}


class UserTableDetails
{
    
    var tableName: String
    var fieldNames : [String]

    
    var condition : String = ""
    
    init()
    {
    tableName = "UserDetails"
    fieldNames = ["name" , "email" , "mobileNumber" , "securityQuestion" , "answer" , "userId" , "password"]
    let createQuery = "create table if not exists \(tableName)(name text , email text not null unique, mobileNumber real , securityQuestion text , answer text , userId text not null unique , password text);"
    
    SqliteDatabase.getObject().createTable(createQuery: createQuery)
        
    }
    
    func insertValueDetails(user : UserDetails)
    {
        var values : [Any] = []
        
        values.append(user.name)
        values.append(user.email)
        values.append(user.mobileNumber)
        values.append(user.securityQuestion)
        values.append(user.answer)
        values.append(user.userId)
        values.append(user.password)
        
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
    
    
    func editMobileNumber(userId : String , password:  String)
    {
        
        var updateColumnDetails : [String] = []
        let operation : String = "and"
        var condition : [String] = []
        
        
        let mobileNumber = UserInput.getMobileNumber()
        
        updateColumnDetails.append("mobileNumber = \(mobileNumber)")
        condition.append("userId = '\(userId)'")
        condition.append("password = '\(password)'")
        
        if SqliteDatabase.getObject().checkRecord(tableName : tableName , userId : userId , password : password)
        {
            SqliteDatabase.getObject().updateRecords(tableName: tableName, updateColumnDetails: updateColumnDetails, operation: operation, condition: condition)
            View.showProfileChangeSuccessMessage()
        }
        else
        {
            View.showErrorMessage()
        }
  
    }

    
    func getUserRecord(userId : String , password : String) -> (String , String , Float)
    {
        condition += "userId ='\(userId)' and password ='\(password)'"
       
        let userData = SqliteDatabase.getObject().getUserParticularRecord(tableName: tableName, userId: userId , password : password)
       return userData
    }
    
    
    
    
}




