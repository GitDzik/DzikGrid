//
//  Tile.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 03/04/2019.
//  Copyright © 2019 Konrad Łęski. All rights reserved.
//

import UIKit

class Tile: UIView {

    var originalFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var originalButtonFrame = CGRect(x: 0, y: 0, width: 0, height: 0) // button ma byc zastapiany czymkolwiek UIView
    let button = UIButton(type: .system)
    var resizer : TileResizer?
    var board : Board?
    
    var potentialNewWidth :Int?
    var potentialNewHeight :Int?
    var cellSize : CGFloat = 0
    
    
    init(frame: CGRect, board: Board) {
        super.init(frame: frame)
        self.board = board
        cellSize = board.cellSize
        //TO_DO czy to ma byc optional?
        
        button.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.bounds.size.width, height: self.bounds.size.height)
        button.backgroundColor = UIColor.blue

        self.resizer = TileResizer(forTile: self)
        self.addSubview(self.resizer!)

        
        //randomize view color
        let blueValue = CGFloat.random(in: 0 ..< 1)
        let greenValue = CGFloat.random(in: 0 ..< 1)
        let redValue = CGFloat.random(in: 0 ..< 1)
        
        self.backgroundColor = UIColor(red:redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performResize(forLocation location: CGPoint) {
        
        let resizeManager = ResizeManager(forTile: self, andLocation: location)
        GridSpaceManager.shared.releaseSpaceForTile(tile:self)
        if (resizeManager.resizeCanTakePlace()) {
            setNewFrame(resizeManager.newTileFrame())
        }
        GridSpaceManager.shared.reserveSpaceForTile(tile:self)
    }
    
    func setNewFrame(_ frame : CGRect) {
        self.frame = frame
        button.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: frame.size.width, height: frame.size.height)
        resizer?.frame = CGRect(x: self.frame.width - cellSize, y: self.frame.height - cellSize, width: cellSize, height: cellSize)
    }
}
