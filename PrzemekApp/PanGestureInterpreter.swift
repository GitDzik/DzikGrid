//
//  PanGestureInterpreter.swift
//  PrzemekApp
//
//  Created by Konrad Łęski on 17/04/2020.
//  Copyright © 2020 Konrad Łęski. All rights reserved.
//

import Foundation
import UIKit

class PanGestureInterpreter {
    
    private var panResizerLocation : CGPoint
    private var panTileLocation : CGPoint
    private var resizer : TileResizer
    
    init(withRecognizer recognizer : UIPanGestureRecognizer, forResizer resizer : TileResizer) {
        panResizerLocation = recognizer.location(in: resizer)
        panTileLocation = recognizer.location(in: resizer.superview)
        self.resizer = resizer
    }
    
    func panTriggerResize() -> Bool {
        if (panResizerLocation.x < 0 || panResizerLocation.y < 0 || panResizerLocation.x > resizer.frame.height || panResizerLocation.y > resizer.frame.width) {
            return true
        }
        return false
    }
    
    func tileLocation() -> CGPoint {
        return panTileLocation
    }
    
}
