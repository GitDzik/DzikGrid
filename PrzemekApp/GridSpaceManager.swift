//
//  GridSpaceManager.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 14/04/2020.
//  Copyright © 2020 Konrad Łęski. All rights reserved.
//

import Foundation
import UIKit

class GridSpaceManager {
    
    var cellMatrix = Matrix(rows: Int(boardHorizontalDimension), columns : Int(boardVerticalDimension))
    var startX : Int = 0
    var endX : Int = 0
    var startY : Int = 0
    var endY : Int = 0
    var cellSize = CGFloat()
    
    static let shared = GridSpaceManager()
    
    private init() {
        cellSize = floor(UIScreen.main.bounds.width / boardHorizontalDimension)
    }
    
    func reserveSpaceForTile(tile : Tile) {
        setupCoordinatesForFrame(tile.frame)
        markSpaceAsReserved(true)
    }
    
    func releaseSpaceForTile(tile : Tile) {
        setupCoordinatesForFrame(tile.frame)
        markSpaceAsReserved(false)
    }
    
    func spaceAvailableForFrame(_ frame : CGRect) -> Bool {
        setupCoordinatesForFrame(frame)
        return spaceReserved()
    }
    
    func spaceAvailableForNewTile(origin: CGPoint) -> Bool {
        let X = Int(origin.x)
        let Y = Int(origin.y)
        if X + 1 >= Int(boardHorizontalDimension) || Y + 1 >= Int(boardVerticalDimension) {
            return false
        }
        return !cellMatrix[X, Y] && !cellMatrix[X, Y + 1] && !cellMatrix[X + 1, Y] && !cellMatrix[X + 1, Y + 1]
    }
    
    private func setupCoordinatesForFrame(_ frame : CGRect) {
        startX = Int(floor(frame.origin.x/cellSize))
        endX = Int(floor(frame.origin.x/cellSize) + (frame.size.width/cellSize) - 1)
        startY = Int(floor(frame.origin.y/cellSize))
        endY = Int(floor(frame.origin.y/cellSize) + (frame.size.height/cellSize) - 1)
    }
    
    private func markSpaceAsReserved(_ reserved : Bool) {
        for x in startX...endX {
            for y in startY...endY {
                self.cellMatrix[x,y] = reserved
            }
        }
    }
    
    private func spaceReserved() -> Bool {
        for x in startX...endX {
            for y in startY...endY {
                if self.cellMatrix[x,y] == true {
                    return false
                }
            }
        }
        return true
    }
}
