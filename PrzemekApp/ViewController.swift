//
//  ViewController.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 03/04/2019.
//  Copyright © 2019 Konrad Łęski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  let sizeOfView = 100
        let maxViews = 1
        
     
        //   let statusBarSize = UIApplication.shared.statusBarFrame.size
        let board = Board()
        view.addSubview(board)
        
        // Add the Views
        for _ in 0 ..< maxViews {
   /*         let pointX = Int.random(in: 0 ..< Int(view.bounds.width) - sizeOfView)
            let pointY = Int.random(in: Int(statusBarSize.height) ..< Int(view.bounds.height) - sizeOfView)
            let tileFrame = CGRect(x: pointX, y: pointY, width: 100, height: 100)
            let newView = Tile(frame: tileFrame, board: board)
         //   board.markOccupiedSpaceForFrame(frame: tileFrame)
            board.addSubview(newView)*/
        }
    }
    
}

