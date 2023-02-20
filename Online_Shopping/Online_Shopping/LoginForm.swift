
import Foundation


enum LoginFormValidationError : Error
{
    case emptyUserName
    case emptyPassword
    case emptyEmail
    case invalidPasswordLength
    case notFoundUserNameAndPassword
    case incorrectAdminUserNameAndPassword
    case notFoundUserNameAndEmail
    
    var errorMessage : String
    {
        switch self
        {
        case .emptyUserName:
            return "Please enter user name"
        case .emptyPassword:
            return "Please enter a password"
        case .emptyEmail:
            return "Please enter a email"
        case .invalidPasswordLength:
            return "Please enter a password with correct length"
        case .notFoundUserNameAndPassword:
            return "Please check the user name and password or to create sign up account first"
        case .incorrectAdminUserNameAndPassword:
            return "Please check the admin user name and password"
        case .notFoundUserNameAndEmail:
            return "Please check the user name and email"
        }
    }
}



class LoginForm
{
    func checkUserDetails(userDetails : [UserDetails] , userName : String , password : String)throws
    {
        
        guard userName != "" else
        {
            throw LoginFormValidationError.emptyUserName
        }
        
        guard password != "" else
        {
            throw LoginFormValidationError.emptyPassword
        }
    
        guard password.count == 5  else
        {
            throw LoginFormValidationError.invalidPasswordLength
        }
        
        
        var temp : Int = 0
        
        for details in userDetails
        {
            if details.userName == userName && details.password == password
            {
                temp = 1
                print("User login successfully")
                print("welcome to user home page")
                
            }
        }

        guard temp == 1 else
        {
            throw LoginFormValidationError.notFoundUserNameAndPassword
        }
        
    }
    
    func checkAdminDetails(userName : String , password : String)throws
    {
        
        guard userName != "" else
        {
            throw LoginFormValidationError.emptyUserName
        }
        
        guard password != "" else
        {
            throw LoginFormValidationError.emptyPassword
        }
    
        guard password.count == 5  else
        {
            throw LoginFormValidationError.invalidPasswordLength
        }
        
        guard  userName == "admin" && password == "12345" else
        {
            throw LoginFormValidationError.incorrectAdminUserNameAndPassword
        }
        
        print("Admin login successfully")
        print("welcome to admin home page")
    }
    
    
    func checkForgotDetails(userDetails : [UserDetails] , userName: String , email : String)throws
    {
        guard userName != "" else
        {
            throw LoginFormValidationError.emptyUserName
        }
        
        guard email != "" else
        {
            throw LoginFormValidationError.emptyEmail
        }
        
        
        var temp : Int = 0
        
        for details in userDetails
        {
            if details.userName == userName && details.email == email
            {
                temp = 1
                func checkSecurityQuestionAnswer()
                {
                    print(details.securityQuestion)
                    let answer = readLine()!
                    
                    if answer == details.answer
                    {
                        print("Enter the new password")
                        details.password = readLine()!
                    }
                    else
                    {
                        print("Your security question ans was wrong")
                        print("Do you want try again?")
                        if readLine()! == "Yes"
                        {
                            checkSecurityQuestionAnswer()
                        }
                    }
                }
                checkSecurityQuestionAnswer()
            }
        }

        guard temp == 1 else
        {
            throw LoginFormValidationError.notFoundUserNameAndEmail
            
        }
        
        
    }
    
    
}

