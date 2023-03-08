
import Foundation


enum LoginFormValidationError : Error
{
    case notFoundUserIdAndPassword
    case notFoundUserId
    
    var errorMessage : String
    {
        switch self
        {
        case .notFoundUserIdAndPassword:
            return "Please check the user id and password or to create sign up account first"
        case .notFoundUserId:
            return "Please check the user Id"
        }
    }
}



class LoginForm
{
    func checkUserDetail(userDetails : UserTableDetails , userId : String , password : String)throws
    {
        var temp : Int = 0
        if userDetails.checkUserIdAndPasasword(userId: userId, password: password)
        {
                temp = 1
                View.showUserLoginSuccessMessage()
        }

        guard temp == 1 else
        {
            throw LoginFormValidationError.notFoundUserIdAndPassword
        }
        
    }
    
    
    
    func checkAdminDetail(adminDetails : AdminTableDetails , userId : String , password : String)throws
    {
        var temp : Int = 0
        if adminDetails.checkUserIdAndPasasword(userId: userId, password: password)
        {
                temp = 1
                View.showAdminLoginSuccessMessage()
        }

        guard temp == 1 else
        {
            throw LoginFormValidationError.notFoundUserIdAndPassword
        }
        
    }
    
    
    func checkDestributorDetail(distributorDetails : DistributorTableDetails , userId : String , password : String)throws
    {
        var temp : Int = 0
        if distributorDetails.checkUserIdAndPasasword(userId: userId, password: password)
        {
                temp = 1
                View.showDistributorLoginSuccessMessage()
        }

        guard temp == 1 else
        {
            throw LoginFormValidationError.notFoundUserIdAndPassword
        }
        
    }
    
    
    func checkForgotDetails(userDetails : UserTableDetails , userId: String)throws
    {
       
            var temp = 0
        
            if userDetails.checkUserId(userId: userId)
            {
                temp = 1
                userDetails.updatePassword(userId : userId)
            }

            guard temp == 1 else
            {
            throw LoginFormValidationError.notFoundUserId
            
            }
     
    }
    
    
    func checkForgotDetails(adminDetails : AdminTableDetails , userId: String)throws
    {
       
            var temp = 0
        
            if adminDetails.checkUserId(userId: userId)
            {
                temp = 1
                adminDetails.updatePassword(userId : userId)
            }

            guard temp == 1 else
            {
            throw LoginFormValidationError.notFoundUserId
            
            }
     
    }
    
    func checkForgotDetails(distributorDetails: DistributorTableDetails, userId: String)throws
    {
        
        var temp = 0
    
        if distributorDetails.checkUserId(userId: userId)
        {
            temp = 1
            distributorDetails.updatePassword(userId : userId)
        }

        guard temp == 1 else
        {
        throw LoginFormValidationError.notFoundUserId
        }
        
    }
    
    
    }
    
    
    
    
   
