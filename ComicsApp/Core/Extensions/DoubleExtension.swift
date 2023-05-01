//
//  DoubleExtension.swift
//  ComicsApp
//
//  Created by Celso Lima on 30/04/23.
//

import Foundation

extension Double {
    func toString() -> String {
        return "\(self)"
    }
    
    func toCurrent() -> String {
        return String(format: "%.2f", self)
    }
}
