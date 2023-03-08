//
//  BillDetails.swift
//  Online_Shopping
//
//  Created by latha-16226 on 16/02/23.
//

import Foundation

class BillDetails : Product
{
    var productId: Int = 0
    
    var productName: String = ""
    
    var category: String = ""
    
    var price: Int = 0
    
    var quantity : Int = 0
    
    var totalAmount : Int = 0
    var grandTotal : Int = 0

}

class OrderDateDetails
{
    var dateOfOrder : Date?
    var dateOfDelivery : Date?
    var status : String = ""
}

class BillTableDetails
{
    
    var tableName: String
    var fieldNames : [String]
    
    var tableName1: String
    var fieldNames1 : [String]
    
    var tableName2 : String
    
    var retriveColumn : [String] = []
    var condition : String = ""
    
    var tableName3 : String
    var fieldNames3 : [String]
    
    var tableName4 : String
    var fieldNames4 : [String]
    
    init()
    {
    tableName = "BillDetails"
    tableName1 = "BillAndUserDetails"
    tableName2 = "BillNumberDetail"
    tableName3 = "AddressDetails"
    tableName4 = "CancelOrderDetails"
        
    fieldNames = ["billNumber" , "userId" , "productId" , "price" , " quantity" , "totalAmount" , "grandTotal" , "dateOfOrder" , "dateOfDelivery" , "status" , "address" , "district" , "state" , "zuId"]
    fieldNames1 = ["billNumber" , "userId" , "orderId"]
    fieldNames3 = ["userId", "address" , "district" , "state" , "zuId"]
    fieldNames4 = ["billNumber" , "userId"]
        
        
    let createQuery = "create table if not exists \(tableName)(billNumber int, userId String ,  productId int , price int ,  quantity int , totalAmount int , grandTotal int , dateOfOrder text , dateOfDelivery text , status text , address text , district text , state text , zuId int);"
        
    let createQuery1 = "create table if not exists \(tableName1)(billNumber int  not null unique, userId String not null , orderId int  not null unique);"
    
    let createQuery2 = "create table if not exists \(tableName2)(billNumber int  not null unique , zuId int not null unique , orderId int  not null unique );"
        
    let createQuery3 = "create table if not exists \(tableName3)(userId text , address text , district text , state text , zuId int not null unique);"
    
    let createQuery4 = "create table if not exists \(tableName4)(billNumber int  not null unique, userId String not null);"
        
        SqliteDatabase.getObject().createTable(createQuery: createQuery)
        SqliteDatabase.getObject().createTable(createQuery: createQuery1)
        SqliteDatabase.getObject().createTable(createQuery: createQuery2)
        SqliteDatabase.getObject().createTable(createQuery: createQuery3)
        SqliteDatabase.getObject().createTable(createQuery: createQuery4)
    }
    
    func insertValueDetails(billNumber: Int, billDetails: [BillDetails] , userId : String , password : String, userAddressDetail : UserAddressDetails , orderDateDetail : OrderDateDetails , addressId : Int)
    {
        
        for bill in billDetails
        {
            
            var values : [Any] = []
            
            values.append(billNumber)
            values.append(userId)
        
            values.append(bill.productId)
            values.append(bill.price)
            values.append(bill.quantity)
            values.append(bill.totalAmount)
            values.append(bill.grandTotal)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"

            values.append(formatter.string(from: orderDateDetail.dateOfOrder!))
            values.append(formatter.string(from: orderDateDetail.dateOfDelivery!))
            
            values.append(orderDateDetail.status)

            values.append(userAddressDetail.address)
            values.append(userAddressDetail.district)
            values.append(userAddressDetail.state)
            values.append(addressId)
            
           
            SqliteDatabase.getObject().insertRecord(tableName : tableName ,fieldNames : fieldNames ,values: values)
        }
    }
    
    
   

    func insertBillNumberAndUserIdAndOrderId(billNumber : Int , userId : String , orderId : Int)
    {
        var values : [Any] = []
        
        values.append(billNumber)
        values.append(userId)
        values.append(orderId)
        
        SqliteDatabase.getObject().insertRecord(tableName : tableName1 ,fieldNames : fieldNames1 ,values: values)
    }
    
    func getBillNumberAndZuIdAndOrderId() -> (Int , Int , Int)
    {
        
        let billNumberAndZuId = SqliteDatabase.getObject().retriveBillNumber(tableName: tableName2, retriveColumns: retriveColumn, condition: condition)
        return billNumberAndZuId
    }
    
    
    func updateBillNumber(billNumber : Int , zuId : Int , orderId : Int)
    {
        var updateColumnDetails : [String] = []
        let operation1 : String = ""
        let condition1 : [String] = []
        
        updateColumnDetails.append("billNumber = \(billNumber)")
        updateColumnDetails.append("zuId = \(zuId)")
        updateColumnDetails.append("orderId = \(orderId)")
        SqliteDatabase.getObject().updateRecords(tableName: tableName2, updateColumnDetails: updateColumnDetails, operation: operation1, condition : condition1)
    }
    
    
    
    func editPermanentAddress(userId : String , userAddressDetail:  UserAddressDetails)
    {
        var updateColumnDetails : [String] = []
        var operation1 : String = "and"
        var condition1 : [String] = []
        
        var condition2 : [String] = []
        
        updateColumnDetails.append("address = '\(userAddressDetail.address)'")
        updateColumnDetails.append("district = '\(userAddressDetail.district)'")
        updateColumnDetails.append("state = '\(userAddressDetail.state)'")
        
        condition1.append("userId = '\(userId)'")
        
       
     
            SqliteDatabase.getObject().updateRecords(tableName: tableName3, updateColumnDetails: updateColumnDetails, operation: operation1, condition : condition1)
        
       
        View.showProfileChangeSuccessMessage()
    }
    
    
    func editDeliveryAddress(userId : String , userAddressDetail : UserAddressDetails , billNumber : Int)
    {
    
        var updateColumnDetails : [String] = []
        var operation1 : String = "and"
        var condition1 : [String] = []
        
        updateColumnDetails.append("address = '\(userAddressDetail.address)'")
        updateColumnDetails.append("district = '\(userAddressDetail.district)'")
        updateColumnDetails.append("state = '\(userAddressDetail.state)'")
        
        condition1.append("userId = '\(userId)'")
        condition1.append("billNumber = \(billNumber)")
        
        if SqliteDatabase.getObject().checkRecord(tableName: tableName, userId: userId , billNumber : billNumber)
        {
          
            var date = SqliteDatabase.getObject().getDeliveryDate(tableName: tableName, userId: userId , billNumber : billNumber)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd HH:mm"


            if Date().timeIntervalSinceReferenceDate < formatter.date(from: date)!.timeIntervalSinceReferenceDate
            
            {
                print(formatter.date(from: date)!.timeIntervalSinceReferenceDate/(60 * 60 * 24))
                SqliteDatabase.getObject().updateRecords(tableName: tableName, updateColumnDetails: updateColumnDetails, operation: operation1, condition : condition1)
            }
            else
            {
                View.showMessage()
            }
          
        }
        else
        {
            View.showNotFoundBillNumberMessage()
        }
        
        
    }
    
    func checkUser(userId: String) -> [String]
    {
       return SqliteDatabase.getObject().checkAddress(tableName: tableName3, userId: userId)
    }
    
    func addAddress(userId : String , userAddressDetail : UserAddressDetails , zuId : Int)
    {
        var values : [Any] = []
        
        
        values.append(userId)
        values.append(userAddressDetail.address)
        values.append(userAddressDetail.district)
        values.append(userAddressDetail.state)
        values.append(zuId)
        
        
        SqliteDatabase.getObject().insertRecord(tableName : tableName3 ,fieldNames : fieldNames3 ,values: values)
   
        
    }
    
    
    
        func checkUserId(userId: String) -> Bool
    {
        
        
        if SqliteDatabase.getObject().checkUser(tableName : tableName3 , userId : userId)
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func retriveColumnDetails() -> [String]
    {
        var retriveColumns : [String] = []
        
        retriveColumns.append("name")
        retriveColumns.append("email")
        retriveColumns.append("mobileNumber")
        
        retriveColumns.append("billNumber")
        retriveColumns.append("dateOfOrder")
        retriveColumns.append("dateOfDelivery")
        retriveColumns.append("status")
        retriveColumns.append("address")
        retriveColumns.append("district")
        retriveColumns.append("state")
        
        
        retriveColumns.append("productId")
        retriveColumns.append("quantity")
        retriveColumns.append("price")
        retriveColumns.append("totalAmount")
        retriveColumns.append("grandTotal")
    
        return retriveColumns
    }
    
    
    
        func getOrderedDetails()
    {
        
        var retriveColumns : [String] = []
        var condition : [String] = []
        var orderType : String = "receivedOrder"
        
        var values = SqliteDatabase.getObject().getDetails(tableName: tableName1)
        
        var firstTableName = "UserDetails"
        var joinName = "inner join"
        var operation = "="
        
        retriveColumns = retriveColumnDetails()
        
        for bill in 0..<values.0.count
        {
            
            condition.append("userId")
            condition.append("userId")
            
            var billNumber = values.0[bill]
           
            SqliteDatabase.getObject().retriveRecordUsingJoin(firstTableName: firstTableName ,secondTableName: tableName, retriveColumns: retriveColumns, joinName: joinName, condition: condition, operation: operation , billNumber : billNumber , orderType : orderType)
        }
        
        
    }
    
    
  
    
    func getCancelOrderedDetails()
{
    
    var retriveColumns : [String] = []
    var condition : [String] = []
    var orderType : String = "canceledOrder"
    
    var values = SqliteDatabase.getObject().getDetails(tableName: tableName4)
    
    var firstTableName = "UserDetails"
    var joinName = "inner join"
    var operation = "="
    
    retriveColumns = retriveColumnDetails()
    
    
    for bill in 0..<values.0.count
    {
        
        condition.append("userId")
        condition.append("userId")
        
        var billNumber = values.0[bill]
       
        SqliteDatabase.getObject().retriveRecordUsingJoin(firstTableName: firstTableName ,secondTableName: tableName, retriveColumns: retriveColumns, joinName: joinName, condition: condition, operation: operation , billNumber : billNumber , orderType : orderType)
    }
    
    
}
    func getDeliveryOrderedDetails()
{
    
    var retriveColumns : [String] = []
    var condition : [String] = []
    var orderType : String = "deliveredOrder"
    
    var values = SqliteDatabase.getObject().getDetails(tableName: tableName1)
    
    var firstTableName = "UserDetails"
    var joinName = "inner join"
    var operation = "="
    
    retriveColumns = retriveColumnDetails()
    
    
    for bill in 0..<values.0.count
    {
        
        condition.append("userId")
        condition.append("userId")
        
        var billNumber = values.0[bill]
       
        SqliteDatabase.getObject().retriveRecordUsingJoin(firstTableName: firstTableName ,secondTableName: tableName, retriveColumns: retriveColumns, joinName: joinName, condition: condition, operation: operation , billNumber : billNumber , orderType:  orderType)
    }
    
    
}
    
    
    func checkIsUserBillExists(userId: String , number : Int) -> String
    {
        
        var retriveColumn : String = ""
        var condition : String = ""
        var dateOfDelivery = ""
        
        retriveColumn = "dateOfDelivery"
        condition = "billNumber = \(number)"
          
        
        if SqliteDatabase.getObject().checkRecord(tableName: tableName1, userId: userId, billNumber: number)
        {
            
            var dateOfDelivery = SqliteDatabase.getObject().retriveRecords(tableName : tableName , retriveColumn : retriveColumn , condition : condition)
            return dateOfDelivery
            
        }
        else
        {
            return dateOfDelivery
        }
        
    }
    
    
    func deleteUser(userId: String , number : Int)
    {
      var operation = "and"
      var condition : [String] = []
        condition.append("userId = '\(userId)'")
        condition.append("billNumber = \(number)")
      SqliteDatabase.getObject().deleteRecords(tableName: tableName1, operation: operation, condition: condition)
        
        var values : [Any] = []
        values.append(number)
        values.append(userId)
      SqliteDatabase.getObject().insertRecord(tableName: tableName4, fieldNames: fieldNames4, values: values)
    }
    
    
    
    func viewOrderHistory(userId : String)
    {
        print("Your orders ares")
        
        var retriveColumns : [String] = []
        var condition : [String] = []
        var orderType : String = "receivedOrder"
        
        var values = SqliteDatabase.getObject().getDetails(tableName: tableName1)
        
        
        var firstTableName = "UserDetails"
        var joinName = "inner join"
        var operation = "="
        
        retriveColumns = retriveColumnDetails()
        
        for bill in 0..<values.0.count
        {
            
            condition.append("userId")
            condition.append("userId")
            
            var billNumber = values.0[bill]
            
            if values.1[bill] == userId
                
            {
                SqliteDatabase.getObject().retriveRecordUsingJoin(firstTableName: firstTableName ,secondTableName: tableName, retriveColumns: retriveColumns, joinName: joinName, condition: condition, operation: operation , billNumber : billNumber , orderType : orderType)
            }
            
        }
        
    }
    
    
    func viewCancelOrderHistory(userId : String)
    {
        
        var orderType = "canceledOrder"
        var condition : [String] = []
        var values = SqliteDatabase.getObject().getDetails(tableName: tableName4)
        
        var firstTableName = "UserDetails"
        var joinName = "inner join"
        var operation = "="
        
        var retriveColumns = retriveColumnDetails()
        
        
        for bill in 0..<values.0.count
        {
            
            condition.append("userId")
            condition.append("userId")
            
            var billNumber = values.0[bill]
            
            if values.1[bill] == userId
           
            {
                
                SqliteDatabase.getObject().retriveRecordUsingJoin(firstTableName: firstTableName ,secondTableName: tableName, retriveColumns: retriveColumns, joinName: joinName, condition: condition, operation: operation , billNumber : billNumber , orderType : orderType)
            }
        }
        
    }
    
   
    
}


