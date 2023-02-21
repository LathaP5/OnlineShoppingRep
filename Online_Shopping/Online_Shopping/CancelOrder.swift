//
//  CancelOrder.swift
//  Online_Shopping
//
//  Created by latha-16226 on 16/02/23.
//



import Foundation
class CancelOrder
{
    
    func orderCancel(receivedOrder : inout [[BillDetails]] , billNumbers : inout [Int] , billConformedUser : inout [UserDetails] , canceledBillNumbers : inout [Int] , billCanceledBydUser : inout [UserDetails] , cancelOrderByUser : inout [[BillDetails]])
    {
        
        
        
        
        
        
        repeat
        {
            print("Enter the bill number for cancel the order")
            var number = Int(readLine()!)!
            var temp = 0
            
            for billNumber in billNumbers
            {
                if billNumber == number
                {
                    temp = 1
                    var index = billNumbers.index(of: number)
                    
                    canceledBillNumbers.append(billNumbers[index!])
                    
                    for position in 0..<billConformedUser.count
                    {
                        if position == index
                        {
                            billCanceledBydUser.append(billConformedUser[position])
                            cancelOrderByUser.append(receivedOrder[index! + 1])
                            
                        }
                    }
                  
                    billNumbers.remove(at: index!)
                    receivedOrder.remove(at: index! + 1)
                    billConformedUser.remove(at: index!)
                }
            }
            
            if temp == 0
            {
                print("Your bill number was not found")
            }
            
            
            print("Do you want try again for cancellantion?")
        }while readLine()! == "Yes"
    }
}
