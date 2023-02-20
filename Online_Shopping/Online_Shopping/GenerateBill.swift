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
    
        for index in 0..<purchaseOrderDetails.count
        {
            var billDetail = BillDetails()
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
            billDetail.dateOfOrder = Date()
            billDetail.dateOfDelivery = Calendar.current.date(byAdding: .day, value : 7 , to: Date())
            
            billDetails.append(billDetail)
        }
        
        print("Your bill was generated successfully")
        return billDetails
        
    }
}
