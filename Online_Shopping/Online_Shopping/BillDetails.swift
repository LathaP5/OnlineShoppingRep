//
//  BillDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 16/02/23.
//

import Foundation

class BillDetails
{
    
    var productId : Int = 0
    var productName : String = ""
    var category : String = ""
    var price : Int = 0

    var quantity : Int = 0
    
    var dateOfOrder : Date?
    var dateOfDelivery : Date?
    var totalAmount : Int = 0
    var grandTotal : Int = 0

}
