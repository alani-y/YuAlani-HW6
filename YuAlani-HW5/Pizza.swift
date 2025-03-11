// Project: YuAlani-HW5
// EID: ay7892
// Course: CS329E
//  Pizza.swift
//  YuAlani-HW5
//
//  Created by Alani Yu on 2/27/25.
//

import Foundation

class Pizza {
    var pSize: String
    var crust: String
    var cheese: String
    var meat: String
    var veggies: String
    
    init(pSize: String, crust: String, cheese: String, meat: String, veggies: String){
        self.pSize = pSize
        self.crust = crust
        self.cheese = cheese
        self.meat = meat
        self.veggies = veggies
    }
    
    // prints the user's pizza
    func toString() -> String{
        print(("One \(self.pSize.lowercased()) pizza with: \n\t\(self.crust)\n\t\(self.cheese)\n\t\(self.meat)\n\t\(self.veggies)"))
        return ("One \(self.pSize.lowercased()) pizza with: \n\t\(self.crust)\n\t\(self.cheese)\n\t\(self.meat)\n\t\(self.veggies)")
    }
}
