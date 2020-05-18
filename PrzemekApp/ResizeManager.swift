//
//  ResizeManager.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 16/04/2020.
//  Copyright © 2020 Konrad Łęski. All rights reserved.
//

import Foundation
import UIKit

class ResizeManager {
    
    private var newWidth : Int
    private var newHeight : Int
    private var tile : Tile
    private var newFrame : CGRect
    
    init(forTile tile:Tile, andLocation location:CGPoint) {
        self.tile = tile
        newWidth = Int(floor((location.x) / tile.cellSize) + 1) * Int(tile.cellSize)
        newHeight = Int(floor((location.y) / tile.cellSize) + 1) * Int(tile.cellSize)
        newFrame = CGRect(x: tile.frame.origin.x, y: tile.frame.origin.y, width: CGFloat(newWidth), height: CGFloat(newHeight))
    }
    
    func resizeCanTakePlace() -> Bool {
        return self.newSizeDifferentFromCurrent() && self.newSizeValid() && GridSpaceManager.shared.spaceAvailableForFrame(newFrame)
    }
    
    func newTileFrame() -> CGRect {
        return CGRect(x: tile.frame.origin.x, y: tile.frame.origin.y, width: CGFloat(newWidth), height: CGFloat(newHeight))
    }
    
    private func newSizeDifferentFromCurrent() -> Bool {
        return (self.newWidth != Int(self.tile.frame.size.width) || self.newHeight != Int(self.tile.frame.size.height))
    }

    private func newSizeValid() -> Bool {
        return (self.newWidth >= 2 * Int(self.tile.cellSize) && self.newHeight >= 2 * Int(self.tile.cellSize))
    }
}
