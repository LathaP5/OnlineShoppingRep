//
//  CancelOrder.swift
//  Online_Shopping
//
//  Created by latha-16226 on 16/02/23.
//



import Foundation

class CancelOrder
{
    
    
    func orderCancel(billTableDetails : BillTableDetails , userId : String)
    {
        repeat
        {
           
            let number = UserInput.getBillNumber()
            
            var dateOfDelivery = billTableDetails.checkIsUserBillExists(userId: userId , number : number)
                        
            if dateOfDelivery != ""
            {
            
                        let date = Date()
                        
                       
                         
                         let formatter = DateFormatter()
                         formatter.dateFormat = "yyyy/MM/dd HH:mm"
                         
                         let deliveryDate = formatter.date(from: dateOfDelivery)
                         
                       
                        if date.timeIntervalSinceReferenceDate < deliveryDate!.timeIntervalSinceReferenceDate
                        {
                            billTableDetails.deleteUser(userId: userId, number: number)
                                    
                        }
                        else
                        {
                            print("Sry your date of cancellation duration is exide")
                        }
                
            }
            else
            {
                print("Check the user name , bill number for cancel the order")
            }
            
        }while UserInput.getCancelOrderContinueOption()
                
                
                
    }
    
}







