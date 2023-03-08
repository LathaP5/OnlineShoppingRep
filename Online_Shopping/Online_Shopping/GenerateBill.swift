//
//  GenerateBill.swift
//  Online_Shopping
//
//  Created by latha-16226 on 16/02/23.
//

import Foundation


class GenerateBill
{
    func calculateTotal(purchaseOrderDetails : [PurchaseOrderDetails]) -> [BillDetails]
    {
        var billDetails : [BillDetails] = []
    
        if !purchaseOrderDetails.isEmpty
        {
            for index in 0..<purchaseOrderDetails.count
            {
                let billDetail = BillDetails()
                billDetail.productId = purchaseOrderDetails[index].productId
                billDetail.productName = purchaseOrderDetails[index].productName
                billDetail.category = purchaseOrderDetails[index].category
                billDetail.price = purchaseOrderDetails[index].price
                billDetail.quantity = purchaseOrderDetails[index].quantity
                billDetail.totalAmount = purchaseOrderDetails[index].price * purchaseOrderDetails[index].quantity
                
                if index == 0
                {
                    billDetail.grandTotal = billDetail.totalAmount
                }
                else
                {
                    billDetail.grandTotal = billDetails[index - 1].grandTotal + billDetail.totalAmount
                }
                
                billDetails.append(billDetail)
            }
            
            print("Your order was successfully placed")
            print("Please wait 2 secs")
            
        }
        return billDetails
    }
}


class OrderDeliveryDate
{
    
    func generateDeliveryDate(district : String) -> Date
    {
        /*
         var date : Date?
         switch district
         {
         case "Chennai" , "chennai":
         date = Calendar.current.date(byAdding: .day, value : 2 , to: Date())!
         break
         case "Coimbatore" , "coimbatore" , "CBE" , "Cbe" , "cbe":
         date = Calendar.current.date(byAdding: .day, value : 2 , to: Date())!
         break
         case "Madurai" , "madurai" , "MDU" , "Mdu" , "mdu":
         date = Calendar.current.date(byAdding: .day, value : 3 , to: Date())!
         break
         case "Dindigul" , "dindigul" , "DGL" , "dgl" ,"Dgl":
         date = Calendar.current.date(byAdding: .day, value : 4 , to: Date())!
         break
         default:
         date = Calendar.current.date(byAdding: .day, value : 5 , to: Date())!
         break
         }
         return date!
         */
        
        
        var date : Date?
        switch district
        {
        case "Chennai" , "chennai":
            date = Calendar.current.date(byAdding: .minute, value : 2 , to: Date())!
            break
        case "Coimbatore" , "coimbatore" , "CBE" , "Cbe" , "cbe":
            date = Calendar.current.date(byAdding: .minute, value : 2 , to: Date())!
            break
        case "Madurai" , "madurai" , "MDU" , "Mdu" , "mdu":
            date = Calendar.current.date(byAdding: .minute, value : 3 , to: Date())!
            break
        case "Dindigul" , "dindigul" , "DGL" , "dgl" ,"Dgl":
            date = Calendar.current.date(byAdding: .minute, value : 4 , to: Date())!
            break
        default:
            date = Calendar.current.date(byAdding: .minute, value : 4 , to: Date())!
            break
        }
        return date!
        
        
    }
   
}
