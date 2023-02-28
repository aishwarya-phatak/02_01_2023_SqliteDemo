//
//  Employee.swift
//  02_01_2023_SqliteDemo
//
//  Created by Vishal Jagtap on 22/02/23.
//

import Foundation
class Employee{
    var empId : Int
    var empName : String
   // var empSalary : Double
    
    init(empId: Int, empName: String) {
        self.empId = empId
        self.empName = empName
        //self.empSalary = empSalary
    }
}
