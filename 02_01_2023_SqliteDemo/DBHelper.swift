//
//  DBHelper.swift
//  02_01_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 22/02/23.
//

import Foundation
import SQLite3
//DBUtil or DBHelper
class DBHelper{
    
    init(){
        db = openDatabase()
        print("db is : \(db)")
        createEmployeeTable()
    }
    
    var dbPath : String = "my_ios_datbase.sqlite"
    var db : OpaquePointer?
    func openDatabase()->OpaquePointer?{
        
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false)
        
        print("File Url ---\(fileUrl.path)")
        
        if sqlite3_open(fileUrl.path,
                        &db) == SQLITE_FAIL{
            print("Error creating database")
            return nil
        } else {
            print("Database created successfully\(dbPath)")
            print("Database is : \(db)")
            return db
        }
    }
    //sql query -- Create Table Employee(columns names);
    func createEmployeeTable(){
        //let createTableString = "CREATE TABLE EMPLOYEE IF NOT EXISTS(EmpId INTEGER,EmpName TEXT,EmpSalary DOUBLE);"

        let createQuery = "CREATE TABLE Emp(empId INTEGER);"
        var createStatement : OpaquePointer?
        
       if sqlite3_prepare_v2(db,
                             createQuery,
                           -1,
                           &createStatement,
                             nil) == SQLITE_OK{
           print("The create table statement executed")
       } else {
           print("The create table statment creation falied")
       }
       
        sqlite3_finalize(createStatement)
    }
    
    func insertEmployeeRecord(empId : Int, empName : String, empSalary : Double){
        let insertQueryString = "INSERT INTO EMPLOYEE(EmpId,EmpName,EmpSalary) VALUES(?,?,?);"
        var insertStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db,
                              insertQueryString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            print("Insert Statement Is Executed")
            sqlite3_bind_int(insertStatement, 1, Int32(empId))
            sqlite3_bind_text(insertStatement,
                              2,
                              (empName as NSString).utf8String,
                              -1,
                              nil)
            sqlite3_bind_double(insertStatement, 3, empSalary)
        } else {
            print("Insert Statement Not Created")
        }
        sqlite3_finalize(insertStatement)
        
    }
    
    func deleteEmployeerecord(empId : Int){
        let deleteQueryString = "DELETE FROM EMPLOYEE WHERE EmpId = ?;"
        var deleteStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              deleteQueryString,
                              -1,
                              &deleteStatement,
                              nil) == SQLITE_OK{
             print("The delete statement is executed")
            
            //sqlite3_bind_int(deleteStatement, 1, <#T##Int32#>)
            
            
        } else {
            print("The delete statement preparation failed")
        }
        
        sqlite3_finalize(deleteStatement)
    }
    
    
    
    
    
    
}
