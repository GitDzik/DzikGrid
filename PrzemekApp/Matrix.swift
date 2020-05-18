//
//  Matrix.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 04/02/2020.
//  Copyright © 2020 Konrad Łęski. All rights reserved.
//

import Foundation

class Matrix {
    
    let rows :Int, columns : Int
    var grid : [Bool]
    
    init(rows :Int, columns: Int) {
        self.rows = rows
        self.columns = columns;
        self.grid = Array(repeating: false, count: rows * columns)
    }
    
    subscript(row: Int, column: Int) -> Bool {
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue;
        }
        get {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
    }
    
    func indexIsValid(row : Int, column : Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
}
