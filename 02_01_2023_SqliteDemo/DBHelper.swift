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
    var dbPath : String = "my_ios_datbase.sqlite"
    var db : OpaquePointer?
    init(){
        self.db = openDatabase()
        print("db is : \(db)")
        self.createEmployeeTable()
    }
   
    func openDatabase()->OpaquePointer?{
        
        let fileUrl = try! FileManager.default.url(
            for: .documentDirectory,            //imp
            in: .userDomainMask,                //imp
            appropriateFor: nil,
            create: false).appendingPathExtension(dbPath)
        
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
    let createTableString = "CREATE TABLE IF NOT EXISTS employee(EmpId INTEGER,Empname TEXT);"

        var createStatement : OpaquePointer? = nil
        
       if sqlite3_prepare_v2(db,
                             createTableString,
                           -1,
                           &createStatement,
                             nil) == SQLITE_OK{
           print("The create table statement executed")
           if sqlite3_step(createStatement) == SQLITE_DONE{
               print("The table created")
           } else {
               print("Table not created")
           }
       } else {
           print("The create table statment creation failed")
       }
       
        sqlite3_finalize(createStatement)
    }
    
    func insertEmployeeRecord(empId : Int, empName : String){
        let insertQueryString = "INSERT INTO employee(EmpId,Empname) VALUES(?,?);"
        var insertStatement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db,
                              insertQueryString,
                              -1,
                              &insertStatement,
                              nil) == SQLITE_OK{
            print("Insert Statement Is Executed")
            sqlite3_bind_int(insertStatement, 0, Int32(empId))
            sqlite3_bind_text(insertStatement,
                              1,
                              (empName as NSString).utf8String,
                              -1,
                              nil)
           // sqlite3_bind_double(insertStatement, 3, empSalary)
        } else {
            print("Insert Statement Not Created")
        }
        sqlite3_finalize(insertStatement)
        
    }
    
    func deleteEmployeerecord(empId : Int){
        let deleteQueryString = "DELETE FROM employee WHERE EmpId = ?;"
        var deleteStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                              deleteQueryString,
                              -1,
                              &deleteStatement,
                              nil) == SQLITE_OK{
             print("The delete statement is executed")
            
            sqlite3_bind_int(deleteStatement, 1, Int32(empId))
        } else {
            print("The delete statement preparation failed")
        }
        
        sqlite3_finalize(deleteStatement)
    }
    
    
    func retriveAllEmployeeRecords()->[Employee]{
        
        var employees : [Employee] = []
        let retriveEmployeeRecordsString = "SELECT * FROM employee;"
        var retriveEmployeeStatement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db,
                           retriveEmployeeRecordsString,
                           -1,
                           &retriveEmployeeStatement,
                           nil) == SQLITE_OK{
                while sqlite3_step(retriveEmployeeStatement) == SQLITE_ROW{
                    let retrivedEmpId = sqlite3_column_int(retriveEmployeeStatement, 0)
                    let retrivedEmpName = String(describing: String(cString: sqlite3_column_text(retriveEmployeeStatement, 1)))
                    
                    employees.append(Employee(empId: Int(retrivedEmpId), empName: retrivedEmpName))
                    
            }
            
        } else {
            print("The statement preparation failed")
        }
        
        sqlite3_finalize(retriveEmployeeStatement)
        return employees
    }
    
}
