//
//  TileBoard.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 10/04/2019.
//  Copyright © 2019 Konrad Łęski. All rights reserved.
//

import Foundation
import UIKit

let boardHorizontalDimension : CGFloat = 30
let boardVerticalDimension : CGFloat = 39


class Board: UIView {
    
    var cellSize = CGFloat()
    var newTileOrigin = CGPoint(x: 0, y: 0)
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0)) //TO_DO czy to tak ma byc
        setBoardFrame()
        initializeGestureRecognizers()
        backgroundColor = UIColor.gray
        addTile()
    }
    
    func setBoardFrame() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let statusBarSize = UIApplication.shared.statusBarFrame.size

        cellSize = floor(screenWidth / boardHorizontalDimension)
        let boardWidth = cellSize * boardHorizontalDimension
        let boardHeight = cellSize * boardVerticalDimension
        let boardOriginX = (screenWidth - boardWidth) / 2
        let boardOriginY = (screenHeight - statusBarSize.height - boardHeight) / 2 + statusBarSize.height
        
        frame = CGRect(x: boardOriginX, y: boardOriginY, width: boardWidth, height: boardHeight)
    }
    
    func initializeGestureRecognizers() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(boardLongPressed(_ :)))
        self.addGestureRecognizer(longPressRecognizer)
    }

   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func boardLongPressed(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case  .began:
            handleLongPressBegan(gesture)
        default:
            print("do nothing")
        }
    }
    
    func handleLongPressBegan(_ gesture: UILongPressGestureRecognizer) {
        newTileOrigin = CGPoint(x: Int(floor(gesture.location(in: self).x / cellSize)), y: Int(floor(gesture.location(in: self).y / cellSize)))

        if (GridSpaceManager.shared.spaceAvailableForNewTile(origin: newTileOrigin)) {
            self.showActionPopover()
        }
    }
    
    func showActionPopover() {
        var topVC = UIApplication.shared.keyWindow?.rootViewController
        while((topVC!.presentedViewController) != nil) {
            topVC = topVC!.presentedViewController
        }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: LongpressActionTVC = storyboard.instantiateViewController(withIdentifier: "LongpressActionTVC") as! LongpressActionTVC
        
        vc.view.backgroundColor = UIColor.red
        vc.modalPresentationStyle = .popover
        vc.popoverPresentationController?.sourceView = getPopoverPlaceholderView()
        vc.board = self

        
        topVC?.present(vc, animated: false, completion:{vc.popoverPresentationController?.sourceView?.removeFromSuperview()})
    }
    
    func getPopoverPlaceholderView() -> UIView {
        let X = Int(newTileOrigin.x)
        let Y = Int(newTileOrigin.y)
        
        let popoverPlaceholderView = UIView(frame: CGRect(x: X * Int(cellSize),y: Y * Int(cellSize), width: Int(cellSize), height: Int(cellSize)))
        popoverPlaceholderView.backgroundColor = UIColor.gray
        addSubview(popoverPlaceholderView)
        return popoverPlaceholderView
    }
    
    func addTile() {
        let X = Int(newTileOrigin.x)
        let Y = Int(newTileOrigin.y)
        
        let tileFrame = CGRect(x: X * Int(cellSize), y: Y * Int(cellSize), width: Int(cellSize) * 2, height: Int(cellSize) * 2)
        let tile = Tile(frame: tileFrame, board: self)
        
        GridSpaceManager.shared.reserveSpaceForTile(tile: tile)
        addSubview(tile)
    }
}


