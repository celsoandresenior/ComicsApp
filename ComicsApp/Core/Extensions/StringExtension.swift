//
//  StringExtensions.swift
//  ComicsApp
//
//  Created by Celso Lima on 29/04/23.
//

import Foundation

extension String {
    func toInt() ->  Int {
        return Int(self) ?? 0
    }
    
    func toDouble() ->  Double {
        return Double(self) ?? 0
    }
}
