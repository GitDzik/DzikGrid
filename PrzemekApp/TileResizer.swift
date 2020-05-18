//
//  TileResizer.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 04/04/2019.
//  Copyright © 2019 Konrad Łęski. All rights reserved.
//

import UIKit

class TileResizer: UIView {

    var tile: Tile
  //  var gestureInterpreter : PanGestureInterpreter
    
    init(forTile tile: Tile) {
        self.tile = tile
        
        super.init(frame: CGRect(x: (tile.frame.width) - 30, y: (tile.frame.height) - 30, width: 30, height: 30))
        
        self.backgroundColor = UIColor.red
        self.setupGestureRecognizers()
    }
    
    func setupGestureRecognizers() {
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(handlePan))
        self.gestureRecognizers = [panRecognizer]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tile.originalFrame = self.tile.frame
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        let gestureInterpreter = PanGestureInterpreter(withRecognizer: recognizer, forResizer: self)
     
        if (gestureInterpreter.panTriggerResize()) {
            self.tile.performResize(forLocation: gestureInterpreter.tileLocation())
        }
    }

}
