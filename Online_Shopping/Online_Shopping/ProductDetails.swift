import Foundation



protocol Product
{
    var productId : Int {get set}
    var productName : String {get set}
    var category : String {get set}
    var price : Int {get set}
}


class ProductDetails : Product
{
    var productId: Int = 0
    
    var productName: String = ""
    
    var category: String = ""
    
    var price: Int = 0
    
    
    var active : String = ""
    
}


class  ProductTableDetails
{
  
    var tableName: String
    
    var fieldNames : [String] = []
    
    var tableName1: String
    
    var fieldNames1 : [String] = []
    
    
    var condition : String = ""
    init()
    {
    tableName = "ProductDetails"
    tableName1 = "AdminProductDetails"
        
    fieldNames = ["productId" ,"productName" , "category" , "price" , "active"]
    fieldNames1 = ["userId" , "productId"]
        
    let createQuery = "create table if not exists \(tableName)(productId int primary key, productName text, category text, price int, active text);"

    let createQuery1 = "create table if not exists \(tableName1)(userId text , productId int primary key);"
        
    
     SqliteDatabase.getObject().createTable(createQuery: createQuery)
     SqliteDatabase.getObject().createTable(createQuery: createQuery1)
    
        
    }
    
    func insertValueDetails(product : ProductDetails)
    {
        var values : [Any] = []
        
        values.append(product.productId)
        values.append(product.productName)
        values.append(product.category)
        values.append(product.price)
        values.append(product.active)
    
        SqliteDatabase.getObject().insertRecord(tableName : tableName ,fieldNames : fieldNames ,values: values)
        
    }
    
    func insertAdminWithProductDetail(adminProductDetail : AdminProductDetails)
    {
        var values : [Any] = []
        
        values.append(adminProductDetail.userId)
        values.append(adminProductDetail.productId)
        
        SqliteDatabase.getObject().insertRecord(tableName : tableName1 ,fieldNames : fieldNames1 ,values: values)
    }
    
  
    func viewAllProducts()
    {
        fieldNames = ["productId" , "productName" , "category" , "price" , "active"]
        condition = ""
       
        SqliteDatabase.getObject().retriveRecords(tableName: tableName, retriveColumns: fieldNames, condition: condition)
    }
    
    func getProductAvailablity(productId : Int) -> (Int , String , String , Int , String)
    {
        let values = SqliteDatabase.getObject().checkProductAvailablity(tableName: tableName, productId: productId)
        return values
    }
    
   
    
    func UpdateProductIdDetails(oldProductId : Int , newPrice : Int , newActive : String)
    {
            var updateColumnDetails : [String] = []
            let operation : String = ""
            var condition : [String] = []
            
            updateColumnDetails.append("price = \(newPrice)")
            updateColumnDetails.append("active= '\(newActive)'")
            
            condition.append("productId = \(oldProductId)")
            
            SqliteDatabase.getObject().updateRecords(tableName: tableName, updateColumnDetails: updateColumnDetails, operation: operation , condition: condition)

    }
    
    func getDetailsCategoryWise(category : String) ->[Int]
    {
        fieldNames = ["productId" , "productName" , "category" , "price" , "active"]
        condition = "category = '\(category)'"
        SqliteDatabase.getObject().retriveRecords(tableName: tableName, retriveColumns: fieldNames, condition: condition)
        
        fieldNames = ["productId"]
        let productIds = SqliteDatabase.getObject().retriveRecordsByCategoryWise(tableName: tableName, retriveColumns: fieldNames, condition: condition)
        return productIds
    }
    
    func getDetailsPriceWise(fromrRange : Int , toRange : Int , category : String) -> [Int]
    {
        fieldNames = ["productId" , "productName" , "category" , "price" , "active"]
        condition = "price >=\(fromrRange) and price <= \(toRange) and category = '\(category)'"
        SqliteDatabase.getObject().retriveRecords(tableName: tableName, retriveColumns: fieldNames, condition: condition)
        
        fieldNames = ["productId"]
        let productIds = SqliteDatabase.getObject().retriveRecordsByCategoryWise(tableName: tableName, retriveColumns: fieldNames, condition: condition)
        return productIds
    }

    func getAdminWiseProductId(userId : String) -> [Int]
    {
        var produstIds = SqliteDatabase.getObject().getDetails(tableName: tableName1 , userId:  userId)
        return produstIds
    }
    
    func getAdminWiseProductDetails(productIds : [Int])
    {
        
        for productId in productIds
        {
            fieldNames = ["productId" , "productName" , "category" , "price" , "active"]
            condition = "productId = \(productId)"
           
            SqliteDatabase.getObject().retriveRecords(tableName: tableName, retriveColumns: fieldNames, condition: condition)
        }
        
    }
    
    
}
                                        
