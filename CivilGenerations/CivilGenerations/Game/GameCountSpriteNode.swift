//
//  GameCountSpriteNode.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/17/22.
//

import SpriteKit

class GameCountSpriteNode: SKSpriteNode {
    
    var labelNode:SKLabelNode? = nil
    
    private var _numberValue:Int = 0
    var numberValue:Int {
        set {
            guard _numberValue != newValue else {return}
            _numberValue = newValue
            guard let labelNode = self.labelNode else {
                labelNode = SKLabelNode(text: "\(newValue)")
                addChild(labelNode!)
                return
            }
            labelNode.text = "\(newValue)"
        }
        
        get {
            return _numberValue
        }
    }
}
