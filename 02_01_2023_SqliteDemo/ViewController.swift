//
//  ViewController.swift
//  02_01_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 22/02/23.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var e : [Employee] = [Employee]()
       var dbHelper = DBHelper()
        print("Inserting Records into the Employee Database")
        dbHelper.insertEmployeeRecord(empId: 1, empName: "ABC")
        dbHelper.insertEmployeeRecord(empId: 2, empName: "ABC")
        dbHelper.insertEmployeeRecord(empId: 3, empName: "ABC")
        dbHelper.insertEmployeeRecord(empId: 4, empName: "ABC")
        dbHelper.insertEmployeeRecord(empId: 34, empName: "ABC")
        dbHelper.insertEmployeeRecord(empId: 112, empName: "ABC")
        print("All the records are added successfully")
        
        print("__________________")
        print("Delete an employee with id as 111")
        //dbHelper.deleteEmployeerecord(empId: 1)
        print("Employee 111 deleted")
        print("Retrive Records called")
        e = dbHelper.retriveAllEmployeeRecords()
        for eachEmp in e{
            print("each Emp -- \(eachEmp.empId) -- \(eachEmp.empName)")
        }
        print("Retrived All Records")
        
    }


}

