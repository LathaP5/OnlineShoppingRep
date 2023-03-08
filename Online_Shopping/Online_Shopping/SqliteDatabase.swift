
import Foundation
import SQLite3


class SqliteDatabase
{
    var db : OpaquePointer?
    
    
    private static var sqliteDatabase = SqliteDatabase()
    
    private init()
    {
        
    }
    
    public static func getObject() -> SqliteDatabase
    {
        return sqliteDatabase
    }
    
    
    
    func createDatabase()
    {
        let fileUrl = try!
        FileManager.default.url(for: .documentDirectory, in: .userDomainMask , appropriateFor: nil , create: false).appendingPathComponent("OnlineShoppingDatabase1.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) == SQLITE_OK
        {
            print("Database opened successfully = \(fileUrl)")
            print(db!)
        }
        else
        {
            print("Unable to open")
        }
        
    }
    
    func createTable(createQuery : String)
    {
        
        var createTablePointer : OpaquePointer?
        
        if sqlite3_prepare_v2(db, createQuery, -1, &createTablePointer, nil) == SQLITE_OK
        {
            
            if sqlite3_step(createTablePointer) == SQLITE_DONE
            {
                print(db!)
                print("Table created successfully")
            }
            else
            {
                print("Table is not created")
            }
        }
        else
        {
            print("Create Table statement is not prepared")
        }
        
        defer
        {
            sqlite3_finalize(createTablePointer)
        }
        
    }
    
    
    func insertRecord(tableName : String , fieldNames : [String] ,values: [Any])
    {
        
        var insertPointer : OpaquePointer?
        var temp : Int = 0
        
        var insertQuery = "INSERT INTO " + "\(tableName) ("
        
        for field in 0..<values.count
        {
            insertQuery += fieldNames[field]
            
            if field < values.count - 1
            {
                insertQuery += ","
            }
        }
        
        insertQuery += ") VALUES("
        
        
        for field in 0..<values.count
        {
            let value = values[field]
            
            switch value
            {
            case let someString as String:
                temp = 1
            default:
                temp = 0
            }
            
            
            
            if temp == 1
            {
                insertQuery += "'\(value)'"
            }
            else
            {
                insertQuery += "\(value)"
            }
            
            
            
            if field < values.count - 1
            {
                insertQuery += ","
            }
        }
        
        insertQuery += ");"
        
        
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertPointer, nil) == SQLITE_OK
        {
            
            if sqlite3_step(insertPointer) == SQLITE_DONE
            {
                print("The records is inserted successfully")
            }
            else
            {
                print("The records is not inserted")
            }
        }
        else
        {
            print("Insert statement is not prepared")
        }
        
        defer
        {
            sqlite3_finalize(insertPointer)
        }
    }
    
    
    
    
    
    func retriveRecords(tableName : String , retriveColumns : [String] , condition : String)
    {
        var selectPointer : OpaquePointer?
        
        var selectQuery = ""
        
        if retriveColumns.isEmpty
        {
            selectQuery = "SELECT * FROM \(tableName)"
            
            if condition.isEmpty
            {
                selectQuery += ";"
            }
            else
            {
                selectQuery += " where \(condition);"
            }
            
        }
        else
        {
            selectQuery = "SELECT "
            for column in 0..<retriveColumns.count
            {
                selectQuery += retriveColumns[column]
                
                if column < retriveColumns.count - 1
                {
                    selectQuery += ","
                }
            }
            selectQuery += " FROM \(tableName)"
            
            if condition.isEmpty
            {
                selectQuery += ";"
            }
            else
            {
                selectQuery += " where \(condition);"
            }
            
            
        }
        
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            var temp = 0
            //if sqlite3_step(selectPointer) == SQLITE_ROW
            while (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                var datas : [Any] = []
                var data : Any?
                for value in 0..<sqlite3_column_count(selectPointer)
                {
                    let type = sqlite3_column_type(selectPointer, value)
                    switch type
                    {
                        
                    case SQLITE_FLOAT:
                        data = sqlite3_column_double(selectPointer,value)
                    case SQLITE_BLOB:
                        data = sqlite3_column_blob(selectPointer,value)
                    case SQLITE_INTEGER:
                        data = sqlite3_column_int64(selectPointer,value)
                    case SQLITE_TEXT:
                        guard let cString = sqlite3_column_text(selectPointer, value) else
                        {
                            return
                            
                        }
                        data = String(cString: cString)
                    case SQLITE_NULL:
                        data = "NULL"
                    default:
                        data = "Any other datatype"
                    }
                    datas.append(data!)
                    
                }
                if tableName == "ProductDetails"
                {
                    //print("\(datas[index])",terminator:"   |  ")
                    let view = View()
                    if temp == 0
                    {
                        View.showProductDetailsHeading()
                        temp = 1
                    }
                    view.viewAllProducts(productDetails : datas)
                    
                }
                
            }
            
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        defer
        {
            sqlite3_finalize(selectPointer)
        }
        
        
    }
    
    
    
    
    func deleteRecords(tableName : String , operation : String ,  condition : [String])
    {
        var deletePointer : OpaquePointer?
        
        var conditionOperator : String = ""
        
        if operation == "and"
        {
            conditionOperator = operation
        }
        else if operation == "or"
        {
            conditionOperator = operation
        }
        
        
        var deleteQuery = "delete from \(tableName)"
        
        
        if condition.isEmpty
        {
            deleteQuery += ";"
        }
        else
        {
            deleteQuery += " where "
            
            for index in 0..<condition.count
            {
                deleteQuery += "\(condition[index])"
                
                if index < condition.count - 1
                {
                    deleteQuery += " \(conditionOperator) "
                }
            }
            
            deleteQuery += ";"
            
        }
        
        
        if sqlite3_prepare_v2(db, deleteQuery , -1, &deletePointer, nil) == SQLITE_OK
        {
            
            if sqlite3_step(deletePointer) == SQLITE_DONE
            {
                print("The records is deleted successfully")
            }
            else
            {
                print("The records is not deleted")
            }
        }
        else
        {
            print("delete statement is not prepared")
        }
        defer
        {
            sqlite3_finalize(deletePointer)
        }
        
    }
    
    func retriveRecordUsingJoin(firstTableName : String , secondTableName : String ,retriveColumns : [String] , joinName : String , condition : [String] , operation : String , billNumber : Int , orderType : String)
    {
        
        
        
        var selectPointer : OpaquePointer?
        
        var selectQuery = "SELECT "
        
        if joinName == "cross join"
        {
            if retriveColumns.isEmpty
            {
                selectQuery += "* FROM \(firstTableName) \(joinName) \(secondTableName) where billNumber = \(billNumber);"
                
            }
            else
            {
                for column in 0..<retriveColumns.count
                {
                    selectQuery += retriveColumns[column]
                    
                    if column < retriveColumns.count - 1
                    {
                        selectQuery += ","
                    }
                }
                selectQuery += " FROM \(firstTableName) \(joinName) \(secondTableName) where billNumber = \(billNumber);"
                
            }
        }
        else
        {
            if retriveColumns.isEmpty
            {
                selectQuery += "* "
            }
            else
            {
                for column in 0..<retriveColumns.count
                {
                    selectQuery += retriveColumns[column]
                    
                    if column < retriveColumns.count - 1
                    {
                        selectQuery += ","
                    }
                }
                
            }
            
            selectQuery += " from \(firstTableName) \(joinName) \(secondTableName) on \(firstTableName).\(condition[0]) \(operation) \(secondTableName).\(condition[1]) where  billNumber = \(billNumber);"
            
        }
        
        
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            
            var orderDetails : [[Any]] = []
            while (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                var datas : [Any] = []
                var data : Any?
                
                for value in 0..<sqlite3_column_count(selectPointer)
                {
                    
                    let type = sqlite3_column_type(selectPointer, value)
                    switch type
                    {
                        
                    case SQLITE_FLOAT:
                        data = sqlite3_column_double(selectPointer,value)
                    case SQLITE_BLOB:
                        data = sqlite3_column_blob(selectPointer,value)
                    case SQLITE_INTEGER:
                        data = sqlite3_column_int64(selectPointer, value)
                    case SQLITE_TEXT:
                        data = String(cString: sqlite3_column_text(selectPointer, value))
                    case SQLITE_NULL:
                        data = "NULL"
                    default:
                        data = "Any other datatype"
                    }
                    datas.append(data!)
                    
                }
                
                orderDetails.append(datas)
                
                
            }
            if orderType == "receivedOrder"
            {
                let view = View()
                view.viewReceivedOrder(billDetails : orderDetails)
            }
            if orderType == "deliveredOrder"
            {
                let view = View()
                view.viewDeliveryOrder(billDetails : orderDetails)
            }
            if orderType == "canceledOrder"
            {
                let view = View()
                view.viewReceivedOrder(billDetails : orderDetails)
            }
            
            
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        defer
        {
            sqlite3_finalize(selectPointer)
        }
        
        
        
    }
    
    
    
    func updateRecords(tableName : String , updateColumnDetails : [String] , operation : String , condition : [String])
    {
        
        var updatePointer : OpaquePointer?
        
        var updateQuery = "update \(tableName) set "
        
        for index in 0..<updateColumnDetails.count
        {
            
            updateQuery += updateColumnDetails[index]
            
            if index < updateColumnDetails.count - 1
            {
                updateQuery += ","
            }
            
        }
        
        var conditionOperator : String = ""
        
        if operation == "and"
        {
            conditionOperator = operation
        }
        else if operation == "or"
        {
            conditionOperator = operation
        }
        
        
        if condition.isEmpty
        {
            updateQuery += ";"
        }
        else
        {
            updateQuery += " where "
            
            for index in 0..<condition.count
            {
                updateQuery += "\(condition[index])"
                
                if index < condition.count - 1
                {
                    updateQuery += " \(conditionOperator) "
                }
            }
            
            updateQuery += ";"
            
        }
        
        
        if sqlite3_prepare_v2(db, updateQuery , -1, &updatePointer, nil) == SQLITE_OK
        {
            
            if sqlite3_step(updatePointer) == SQLITE_DONE
            {
                print("The records is updated successfully")
            }
            else
            {
                print("The records is not updated")
            }
        }
        else
        {
            print("update statement is not prepared")
        }
        defer
        {
            sqlite3_finalize(updatePointer)
        }
        
        
    }
    
    
    
    func dropTable(tableName: String)
    {
        var dropPointer : OpaquePointer?
        
        let dropQuery = "drop table \(tableName);"
        
        if sqlite3_prepare_v2(db, dropQuery , -1, &dropPointer, nil) == SQLITE_OK
        {
            
            if sqlite3_step(dropPointer) == SQLITE_DONE
            {
                print("The table is dropped")
            }
            else
            {
                print("The table is not dropped")
            }
        }
        else
        {
            print("The drop statement is not prepared")
        }
        defer
        {
            defer
            {
                sqlite3_close(db)
            }
            
            sqlite3_finalize(dropPointer)
        }
        
    }
    
    
    
    
    
    
    func checkRecord(tableName : String , userId : String , password : String) -> Bool
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName) where userId = '\(userId)' and password ='\(password)';"
        var temp = 0
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                temp = 1
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        if temp == 1
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    
    
    
    
    
    
    func checkRecord(tableName : String , userId : String , billNumber : Int) -> Bool
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName) where userId = '\(userId)' and billNumber = '\(billNumber)';"
        var temp = 0
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                temp = 1
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        if temp == 1
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    
    
    
    
    func  checkRecord(tableName: String, userId: String) -> Bool
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName) where userId = '\(userId)';"
        var temp = 0
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                temp = 1
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        if temp == 1
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    
    
    func checkProductAvailablity(tableName : String , productId : Int) -> (Int , String , String ,Int , String)
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName) where productId = \(productId);"
        
        var values : (Int , String , String , Int , String) = (0 , "" , "" , 0 , "")
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                values.0 = Int(sqlite3_column_int64(selectPointer,0))
                let cString = sqlite3_column_text(selectPointer, 1)
                values.1 = String(cString: cString!)
                let cString1 = sqlite3_column_text(selectPointer, 2)
                values.2 = String(cString: cString1!)
                values.3 = Int(sqlite3_column_int64(selectPointer,3))
                let cString2 = sqlite3_column_text(selectPointer, 4)
                values.4 = String(cString: cString2!)
                
                
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return values
    }
    
    
    
    
    
    func retriveBillNumber(tableName : String , retriveColumns : [String] , condition : String) -> (Int , Int , Int)
    {
        
        var selectPointer : OpaquePointer?
        
        var selectQuery = ""
        
        if retriveColumns.isEmpty
        {
            selectQuery = "SELECT * FROM \(tableName)"
            
            if condition.isEmpty
            {
                selectQuery += ";"
            }
            else
            {
                selectQuery += " where \(condition);"
            }
            
        }
        else
        {
            selectQuery = "SELECT "
            for column in 0..<retriveColumns.count
            {
                selectQuery += retriveColumns[column]
                
                if column < retriveColumns.count - 1
                {
                    selectQuery += ","
                }
            }
            selectQuery += " FROM \(tableName)"
            
            if condition.isEmpty
            {
                selectQuery += ";"
            }
            else
            {
                selectQuery += " where \(condition);"
            }
            
            
        }
        
        
        var billNumber : Int = 0
        var zuId : Int = 0
        var orderId : Int = 0
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                billNumber = Int(sqlite3_column_int64(selectPointer,0))
                zuId = Int(sqlite3_column_int64(selectPointer,1))
                orderId = Int(sqlite3_column_int64(selectPointer,2))
                
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return (billNumber , zuId , orderId)
    }
    
    
    
    
    
    
    
    func getUserParticularRecord(tableName: String, userId: String , password : String) ->(String , String , Float)
    
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select name , email , mobileNumber from \(tableName) where userId ='\(userId)' and password ='\(password)';"
        
        var values : (String , String , Float) = ("" , "", 0)
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                let cString = sqlite3_column_text(selectPointer, 0)
                values.0 = String(cString: cString!)
                let cString1 = sqlite3_column_text(selectPointer, 1)
                values.1 = String(cString: cString1!)
                values.2 = Float(sqlite3_column_int64(selectPointer,2))
                
                
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return values
    }
    
    
    
    
    
    
    
    
    func checkAddress(tableName: String, userId: String) -> [String]
    {
        
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName) where userId ='\(userId)';"
        
        var values : [String] = []
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                let cString = sqlite3_column_text(selectPointer, 0)
                values.append(String(cString: cString!))
                let cString1 = sqlite3_column_text(selectPointer, 1)
                values.append(String(cString: cString1!))
                let cString2 = sqlite3_column_text(selectPointer, 2)
                values.append(String(cString: cString2!))
                let cString3 = sqlite3_column_text(selectPointer, 3)
                values.append(String(cString: cString3!))
                let zuId = sqlite3_column_int64(selectPointer, 4)
                values.append("\(zuId)")
                
                
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return values
    }
    
    

    func retriveRecords(tableName : String , retriveColumn : String , condition : String) -> String
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select \(retriveColumn) from \(tableName) where \(condition);"
       
        var dateOfDelivery : String = ""
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                let cString3 = sqlite3_column_text(selectPointer, 0)
                dateOfDelivery = String(cString: cString3!)
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return dateOfDelivery
    }
   
    
    
    
    
    func checkUser(tableName : String , userId : String) -> Bool
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName) where userId = '\(userId)';"
        var temp = 0
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                temp = 1
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        if temp == 1
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func getDeliveryDate(tableName: String, userId: String , billNumber : Int) -> String
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select dateOfDelivery from \(tableName) where userId = '\(userId)' and billNumber = \(billNumber);"
        
        var stringDate : String = ""
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                let cString3 = sqlite3_column_text(selectPointer, 0)
                stringDate = String(cString: cString3!)
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return stringDate
    }
    
    
    
    func getDetails(tableName: String, userId : String , zuId : Int ) -> ([Int] , [String])
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select billNumber , dateOfDelivery from \(tableName) where userId = '\(userId)' and zuId = \(zuId);"
        
        var billNumber : [Int] = []
        var dateOfDelivery : [String] = []
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            while (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                let billNo = sqlite3_column_int64(selectPointer, 0)
                billNumber.append(Int(billNo))
                let cString3 = sqlite3_column_text(selectPointer, 1)
                dateOfDelivery.append(String(cString: cString3!))
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return (billNumber , dateOfDelivery)
    }
    
    
    
    func getDetails(tableName: String) -> ([Int] , [String])
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName);"
        
        var billNumbers : [Int] = []
        var userIds : [String] = []
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            while (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                let billNo = sqlite3_column_int64(selectPointer, 0)
                billNumbers.append(Int(billNo))
                let cString3 = sqlite3_column_text(selectPointer, 1)
                userIds.append(String(cString: cString3!))
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return (billNumbers , userIds)
    }
    
    
    
    
    func getUserParticularRecord(tableName: String, userId: String) -> (String , String)
    {
        
        var selectPointer : OpaquePointer?
        let selectQuery = "select securityQuestion , answer from \(tableName) where userId = '\(userId)';"
        
        var values : (String , String) = ("" , "")
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                let cString2 = sqlite3_column_text(selectPointer, 0)
                values.0 = (String(cString: cString2!))
                let cString3 = sqlite3_column_text(selectPointer, 1)
                values.1 = (String(cString: cString3!))
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return values
        
    }
    
    
    func checkRecord(tableName: String, userId: String ,oldProductId : Int) -> Bool
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select * from \(tableName) where userId = '\(userId)' and productId =\(oldProductId);"
        var temp = false
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            if (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                temp = true
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return temp
        
    }
    
    func retriveRecordsByCategoryWise(tableName: String, retriveColumns: [String], condition: String) -> [Int]
    {
        
        
        var selectPointer : OpaquePointer?
        
        var selectQuery = ""
        
        if retriveColumns.isEmpty
        {
            selectQuery = "SELECT * FROM \(tableName)"
            
            if condition.isEmpty
            {
                selectQuery += ";"
            }
            else
            {
                selectQuery += " where \(condition);"
            }
            
        }
        else
        {
            selectQuery = "SELECT "
            for column in 0..<retriveColumns.count
            {
                selectQuery += retriveColumns[column]
                
                if column < retriveColumns.count - 1
                {
                    selectQuery += ","
                }
            }
            selectQuery += " FROM \(tableName)"
            
            if condition.isEmpty
            {
                selectQuery += ";"
            }
            else
            {
                selectQuery += " where \(condition);"
            }
            
            
        }
        
        var values : [Int] = []
        
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            while (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                let billNo = sqlite3_column_int64(selectPointer, 0)
                values.append(Int(billNo))
                
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
        
        return values
        
        
    }
    
    
  
    func getDetails(tableName: String, userId : String) -> [Int]
    {
        var selectPointer : OpaquePointer?
        let selectQuery = "select productId from \(tableName) where userId = '\(userId)';"
        
        var productIds : [Int] = []
        var userId : [String] = []
        if sqlite3_prepare_v2(db, selectQuery, -1, &selectPointer, nil) == SQLITE_OK
        {
            while (sqlite3_step(selectPointer) == SQLITE_ROW)
            {
                
                let billNo = sqlite3_column_int64(selectPointer, 0)
                productIds.append(Int(billNo))
            }
        }
        else
        {
            let erroeMessage = String(cString: sqlite3_errmsg(db))
            print("select statement is not prepared = \(erroeMessage)")
        }
    
            return productIds
    }
    
    

    
   
    
    
    
}
    
    

    
    





